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
 var selectedCategory:SearchCategoriesDataModel?
    var acadamySportsDetails : [SportsDetails]?
    var acadamyDetailViewModel = AcadamyDetailViewModel()
    var acadamyGetSportsViewModel = AcadamyDetailViewModel()

    var isPushed:Bool!
    var acadamyPhotosDetails : [PhotoDetails]?
    var parallaxViewFrame = ParallaxHeaderView()
    @IBOutlet weak var contentScrollView: UIScrollView!
    private let btn = UIButton(type: UIButton.ButtonType.custom) as UIButton

    @IBOutlet weak var locationMap: MKMapView!
    @IBOutlet weak var sportsCollctionView: UICollectionView!
    @IBOutlet weak var topImageView: UIView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getAcadamyPhotosDetails()
        self.setUpUi()
        self.updateUI()
        self.getSportsDetails()
        isPushed = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "BookingScreenVC" && !isPushed {
                isPushed = true
               let vc = segue.destination as! BookingScreenVC
               vc.acadamySportsDetails = self.acadamySportsDetails
                vc.selectedCategory = self.selectedCategory
           }
    }
    
    override var prefersStatusBarHidden: Bool {
        if self.navigationController?.navigationBar.isHidden == true {
            return true
        }
        return false
    }

    func setUpUi() {
        self.parallaxViewFrame.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 200)
        self.topImageView.addSubview(ParallaxHeaderView(frame: self.parallaxViewFrame.frame))

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
        
      //  let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: self.view.frame.width - 96, y: self.view.frame.height - 140, width: 80, height: 80)
        btn.setTitle("BOOK", for: .normal)
        btn.backgroundColor = UIColor.MyApp.floatingBtnColor
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 40
        
        btn.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        btn.layer.shadowOffset = CGSize(width: 0, height: 3)
        btn.layer.shadowOpacity = 1.0
        btn.layer.shadowRadius = 10.0
        btn.layer.masksToBounds = false

        btn.addTarget(self, action: #selector(tapBooking), for: .touchUpInside)
        btn.frame = CGRect(x: self.view.frame.width - 96, y:self.view.frame.size.height - 170,  width: 80, height: 80)
        self.view.addSubview(btn)

    }
    
    @objc func tapBooking() {
        self.bookAction()
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
//        let off = self.contentScrollView.contentOffset.y
//        let yPst = self.view.frame.size.height - 120
//        btn.frame = CGRect(x: self.view.frame.width - 96, y:yPst - off,  width: 80, height: 80)
    }
    
    func getSportsDetails() {
//        self.acadamyDetailViewModel =  AcadamyDetailViewModel()
//        self.view.showLoader()
        let populatedDictionary = ["bus_id": (self.acadamyDetails?.busID)!]
        self.acadamyGetSportsViewModel.callSportsDataService(reqParam: populatedDictionary)
        self.acadamyGetSportsViewModel.bindingData = {
            if self.acadamyGetSportsViewModel.AcadamySportsDetails != nil{
                self.acadamySportsDetails = self.acadamyGetSportsViewModel.AcadamySportsDetails
                DispatchQueue.main.async {
                    //self.view.hideLoader()

                self.sportsCollctionView.reloadData()

                }

            }
        }
    }
    
    func getAcadamyPhotosDetails() {
//        self.acadamyDetailViewModel =  AcadamyDetailViewModel()
//        self.view.showLoader()
        let populatedDictionary = ["bus_id": (self.acadamyDetails?.busID)!]
        self.acadamyDetailViewModel.callAcadamyPhotoDataService(reqParam: populatedDictionary)
        self.acadamyDetailViewModel.bindingAcadamyPhotoDetails = {
            if self.acadamyDetailViewModel.AcadamyPhotosDetails != nil{
                self.acadamyPhotosDetails = self.acadamyDetailViewModel.AcadamyPhotosDetails
                let arr = self.acadamyPhotosDetails?.filter {
                    $0.busID == (self.acadamyDetails?.busID) && $0.id == self.selectedCategory?.id
                }
                if ((arr?.count ?? 0) != 0) {
                    self.parallaxViewFrame.updateImage(pho: arr![0], par: self.parallaxViewFrame)
                }
//                self.view.hideLoader()
            }
        }
    }

    func bookAction()  {
        let blurBackgroundView = UIView()
        blurBackgroundView.tag = 2
        blurBackgroundView.frame = self.view.frame
        blurBackgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        self.view.addSubview(blurBackgroundView)
//        let bookingPlanVC = AcadamyBookingPlanViewController()
        let bookingPlanVC : AcadamyBookingPlanViewController = UIStoryboard(name: "Academy", bundle: nil).instantiateViewController(withIdentifier: "AcadamyBookingPlanViewController") as! AcadamyBookingPlanViewController
        self.addChild(bookingPlanVC)
        bookingPlanVC.view.frame = CGRect(x: 8, y: 40, width: self.view.frame.size.width - 16, height: 490)
        bookingPlanVC.view.center = self.view.center
        blurBackgroundView.addSubview(bookingPlanVC.view)
        bookingPlanVC.didMove(toParent: self)
        bookingPlanVC.view.cornerRadius()
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        blurBackgroundView.addGestureRecognizer(tap)

    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        self.view .viewWithTag(2)?.removeFromSuperview()
    }

    @IBAction func viewMemberShipBtnAction(_ sender: Any) {
   
    }

    
    @IBAction func backAction(_ sender: UIButton) {
    
    }
}

extension AcadamyDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:40, height: 40)
    }
}

extension AcadamyDetailsViewController :UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.acadamySportsDetails?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell",
                                                      for: indexPath)
        let sportsLogo:UIImageView = cell.viewWithTag(1) as! UIImageView
        if let imageName = self.acadamySportsDetails?[indexPath.row].image {
            let url = TTAppConstant.UrlConstant.baseUrl+TTAppConstant.UrlConstant.categoryAPI+imageName
            self.acadamyDetailViewModel.downloadImage(url: url) { (response) in
                if let data = response as? Data{
                    sportsLogo.image =  UIImage.init(data: data)
                }
            }
        }
        
        
//        let url = "http://www.toptekker.com/turfdemo/uploads/admin/category/cricket_(1).png"
//        self.acadamyDetailViewModel.downloadImage(url: url) { (response) in
//            if let data = response as? Data{
//                sportsLogo.image = UIImage(data: data)
//            }
//        }
//        let url = TTAppConstant.UrlConstant.baseUrl+TTAppConstant.UrlConstant.Academy_photos_path+(acadamySportsDetails?[indexPath.row].image)!
//
//        self.acadamyDetailViewModel.downloadImage(url: url) { (response) in
//            if let data = response as? Data{
//                sportsLogo.image = UIImage(data: data)
//            }
//        }

//        cell?.layer.cornerRadius =  8
//        cell?.clipsToBounds = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}


final class ParallaxHeaderView: UIView {

    var acadamyDetailsViewModel = AcadamyDetailViewModel()

    fileprivate var heightLayoutConstraint = NSLayoutConstraint()
    fileprivate var bottomLayoutConstraint = NSLayoutConstraint()
    fileprivate var containerView = UIView()
    fileprivate var containerLayoutConstraint = NSLayoutConstraint()
    let imageView: UIImageView = UIImageView()
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

        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .white
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        

        let url = "http://www.toptekker.com/turfdemo/uploads/admin/category/Indoor-Cricket.jpg"
        self.acadamyDetailsViewModel.downloadImage(url: url) { (response) in
            if let data = response as? Data{
                DispatchQueue.main.async { [self] in
                    imageView.image =   UIImage(named: "banner1.png")
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
            }
        }

        
//        imageView.image = UIImage(named: "YourImage")

}

    func scrollViewDidScroll(scrollView: UIScrollView) {
        containerLayoutConstraint.constant = scrollView.contentInset.top;
        let offsetY = -(scrollView.contentOffset.y + scrollView.contentInset.top);
        containerView.clipsToBounds = offsetY <= 0
        self.offsetYy = Float(offsetY)
        bottomLayoutConstraint.constant = offsetY >= 0 ? 0 : -offsetY / 2
        heightLayoutConstraint.constant = max(offsetY + scrollView.contentInset.top, scrollView.contentInset.top)
      //  imageView.image = UIImage(named: "banner1.png")

    }
    
    func updateImage(pho : PhotoDetails?,par : ParallaxHeaderView)  {
        let acad = AcadamyDetailViewModel()
        if let imageName = pho?.photoImage {
            let url = TTAppConstant.UrlConstant.baseUrl+TTAppConstant.UrlConstant.categoryAPI+imageName
            acad.downloadImage(url: url) { [self] (response) in
                if let data = response as? Data{
//                    DispatchQueue.main.async {
//                        imageView.image = UIImage(named: "banner1.png")
//                    }
                }
            }
        }
    }
}

