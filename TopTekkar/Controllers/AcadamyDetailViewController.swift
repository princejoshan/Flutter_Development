//
//  AcadamyDetailViewController.swift
//  TopTekkar
//
//  Created by Prince  on 18/09/21.
//

import UIKit

class AcadamyDetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var acadamyDetailtableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let parallaxViewFrame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 200)
        self.acadamyDetailtableView.tableHeaderView  = ParallaxHeaderView(frame: parallaxViewFrame)
        self.navigationController?.navigationBar.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let headerView = self.acadamyDetailtableView.tableHeaderView as! ParallaxHeaderView
        headerView.scrollViewDidScroll(scrollView: scrollView)
        if headerView.offsetYy < -200 {
            self.navigationController?.navigationBar.isHidden = false;
        }
        else {
            self.navigationController?.navigationBar.isHidden = true

        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = (tableView.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell?)!
        return cell

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

        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = UIColor.red

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
        let url = "http://www.toptekker.com/turfdemo/uploads/admin/category/cricket_(1).png"
        self.acadamyListViewModel.downloadImage(url: url) { (response) in
            if let data = response as? Data{
                imageView.image = UIImage(data: data)
            }
        }
        let lblName = UILabel()

        lblName.frame = CGRect(x: 8, y: 20, width: 200, height: 22)
        lblName.text = "<"
        lblName.textColor = UIColor.blue
        lblName.font = UIFont.systemFont(ofSize: 26)
        lblName.clipsToBounds = true
        imageView.addSubview(lblName)

        
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
