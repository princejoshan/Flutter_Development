//
//  AcadamyDetailsViewController.swift
//  TopTekkar
//
//  Created by Prince  on 19/09/21.
//

import UIKit
import MapKit

class AcadamyDetailsViewController: UIViewController,UIScrollViewDelegate {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var membershipPlanBtn: UIButton!
    
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var sportsStackView: UIStackView!
    
    @IBOutlet weak var facilityStackView: UIStackView!
    var acadamyDetails:AcadamyDetails?
    var acadamySportsDetails : [sportsDetails]?
    var acadamyDetailViewModel = AcadamyDetailViewModel()

    @IBOutlet weak var locationMap: MKMapView!
    @IBOutlet weak var sportsCollctionView: UICollectionView!
    @IBOutlet weak var topImageView: UIView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUi()
        self.updateUI()
        self.getSportsDetails()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    func setUpUi() {
        let parallaxViewFrame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 200)
        self.topImageView.addSubview(ParallaxHeaderView(frame: parallaxViewFrame))

        let backArrow = UIButton()
        backArrow.frame = CGRect(x: 8, y:0, width: 40, height: 40)
        backArrow.setTitle("<", for: .normal)
        backArrow.setTitleColor(UIColor.white, for: .normal)
        backArrow.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.topImageView.addSubview(backArrow)
        
        let fullNameArr:[String] = self.acadamyDetails?.facilities.components(separatedBy: ",") ?? []
        for facilityName in fullNameArr {
            let textLabel = UILabel()
            textLabel.textColor = UIColor.black
            textLabel.font = textLabel.font.withSize(14)
            textLabel.text  = facilityName
            textLabel.textAlignment = .center
            textLabel.widthAnchor.constraint(equalToConstant: textLabel.intrinsicContentSize.width+16).isActive = true
            textLabel.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
            textLabel.layer.borderWidth = 1
            textLabel.layer.borderColor = UIColor.lightGray.cgColor
            self.facilityStackView.addArrangedSubview(textLabel)
        }
        
        let initialLocation = CLLocation(latitude: self.acadamyDetails?.busLatitude.toDouble() ?? 0.0, longitude:  (self.acadamyDetails?.busLongitude.toDouble())!)
        self.locationMap.centerToLocation(initialLocation)
        let artwork = Artwork(title: self.acadamyDetails?.busTitle, locationName: self.acadamyDetails?.busGoogleStreet, discipline: "", coordinate: CLLocationCoordinate2D(latitude: self.acadamyDetails?.busLatitude.toDouble() ?? 0.0, longitude: (self.acadamyDetails?.busLongitude.toDouble())!))
        self.locationMap.addAnnotation(artwork)
    }

    @objc func buttonAction(sender: UIButton!) {
        self.navigationController?.popViewController(animated: true)
    }

    func updateUI()  {
        self.timeLbl.text =  "12 AM to 6 PM"
        self.phoneLbl.text = self.acadamyDetails?.busContact
        self.emailLbl.text =  self.acadamyDetails?.busEmail
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let headerView = self.topImageView.viewWithTag(1) as! ParallaxHeaderView
        headerView.scrollViewDidScroll(scrollView: scrollView)
        if headerView.offsetYy < -50 {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
            self.navigationItem.title = self.acadamyDetails?.busTitle
        }
        else {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        }
    }
    
    func getSportsDetails() {
        self.acadamyDetailViewModel =  AcadamyDetailViewModel()
        let populatedDictionary = ["bus_id": "10"]
        self.acadamyDetailViewModel.callSportsDataService(reqParam: populatedDictionary)
        self.acadamyDetailViewModel.bindingData = {
            if self.acadamyDetailViewModel.AcadamySportsDetails != nil{
                self.acadamySportsDetails = self.acadamyDetailViewModel.AcadamySportsDetails
                self.sportsCollctionView.reloadData()
            }
        }

    }

    
    @IBAction func backAction(_ sender: UIButton) {
    
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AcadamyDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:40, height: 40)
    }
}

extension AcadamyDetailsViewController :UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell",
                                                      for: indexPath)
        let sportsLogo:UIImageView = cell.viewWithTag(1) as! UIImageView
        let url = "http://www.toptekker.com/turfdemo/uploads/admin/category/cricket_(1).png"
        self.acadamyDetailViewModel.downloadImage(url: url) { (response) in
            if let data = response as? Data{
                sportsLogo.image = UIImage(data: data)
            }
        }
//        cell?.layer.cornerRadius =  8
//        cell?.clipsToBounds = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}


final class ParallaxHeaderView: UIView {

    var acadamyListViewModel = AcadamyListViewModel()

    fileprivate var heightLayoutConstraint = NSLayoutConstraint()
    fileprivate var bottomLayoutConstraint = NSLayoutConstraint()
    fileprivate var containerView = UIView()
    fileprivate var containerLayoutConstraint = NSLayoutConstraint()
    var offsetYy:Float = 0
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.tag = 1
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = UIColor.clear

        self.addSubview(containerView)
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[containerView]|",
                                                           options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                                       metrics: nil,
                                                       views: ["containerView" : containerView]))

        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[containerView]|",
                                                           options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                                       metrics: nil,
                                                       views: ["containerView" : containerView]))

        containerLayoutConstraint = NSLayoutConstraint(item: containerView,
                                                   attribute: .height,
                                                   relatedBy: .equal,
                                                   toItem: self,
                                                   attribute: .height,
                                                   multiplier: 1.0,
                                                   constant: 0.0)
        self.addConstraint(containerLayoutConstraint)

        let imageView: UIImageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .white
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
//        let url = "http://www.toptekker.com/turfdemo/uploads/admin/category/cricket_(1).png"
//        self.acadamyListViewModel.downloadImage(url: url) { (response) in
           // if let data = response as? Data{
                imageView.image = UIImage(named: "banner1.png")
           // }
//        }

        
//        imageView.image = UIImage(named: "YourImage")

        containerView.addSubview(imageView)
        containerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[imageView]|",
                                                                    options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                                                metrics: nil,
                                                                views: ["imageView" : imageView]))

        bottomLayoutConstraint = NSLayoutConstraint(item: imageView,
                                                attribute: .bottom,
                                                relatedBy: .equal,
                                                toItem: containerView,
                                                attribute: .bottom,
                                                multiplier: 1.0,
                                                constant: 0.0)

        containerView.addConstraint(bottomLayoutConstraint)

        heightLayoutConstraint = NSLayoutConstraint(item: imageView,
                                                attribute: .height,
                                                relatedBy: .equal,
                                                toItem: containerView,
                                                attribute: .height,
                                                multiplier: 1.0,
                                                constant: 0.0)

        containerView.addConstraint(heightLayoutConstraint)
}

    func scrollViewDidScroll(scrollView: UIScrollView) {
        containerLayoutConstraint.constant = scrollView.contentInset.top;
        let offsetY = -(scrollView.contentOffset.y + scrollView.contentInset.top);
        containerView.clipsToBounds = offsetY <= 0
        self.offsetYy = Float(offsetY)
        bottomLayoutConstraint.constant = offsetY >= 0 ? 0 : -offsetY / 2
        heightLayoutConstraint.constant = max(offsetY + scrollView.contentInset.top, scrollView.contentInset.top)
    }
}

extension String {
    func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
}

private extension MKMapView {
  func centerToLocation(
    _ location: CLLocation,
    regionRadius: CLLocationDistance = 1000
  ) {
    let coordinateRegion = MKCoordinateRegion(
      center: location.coordinate,
      latitudinalMeters: regionRadius,
      longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
  }
}

class Artwork: NSObject, MKAnnotation {
  let title: String?
  let locationName: String?
  let discipline: String?
  let coordinate: CLLocationCoordinate2D

  init(
    title: String?,
    locationName: String?,
    discipline: String?,
    coordinate: CLLocationCoordinate2D
  ) {
    self.title = title
    self.locationName = locationName
    self.discipline = discipline
    self.coordinate = coordinate

    super.init()
  }

  var subtitle: String? {
    return locationName
  }
}
