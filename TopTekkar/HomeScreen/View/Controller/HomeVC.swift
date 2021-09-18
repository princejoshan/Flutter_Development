//
//  HomeVC.swift
//  TopTekkar
//
//  Created by Murugesh on 03/09/21.
//

import Foundation
import UIKit
import Alamofire
class HomeVC: UIViewController {
    
    @IBOutlet weak var HomeCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.HomeCollectionView.register(UINib(nibName: "HomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HomeCollectionViewCell")
        self.HomeCollectionView.backgroundColor = UIColor.darkGray
        self.HomeCollectionView.reloadData()
        
    }
     func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if segue.identifier == "push" {
            
        }
    }
}
extension HomeVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:self.view.frame.size.width - 20, height: 100)
    }
}

extension HomeVC :UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.HomeCollectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as? HomeCollectionViewCell
        
        var image: UIImage!
        switch indexPath.row {
        case 0:
            image = UIImage(named: "banner1.png")
        case 1:
            image = UIImage(named: "banner2.png")
        case 2:
            image =  UIImage(named: "banner3.png")
        case 3:
            image =  UIImage(named: "banner4.png")
        default:
            image = UIImage()
        }
        cell?.imageView.image = image
//        cell?.layer.cornerRadius =  8
//        cell?.clipsToBounds = true
        return cell ?? UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "search", sender: self)
    }
    
    
}

//extension HomeVC : UITableViewDelegate,UITableViewDataSource{
    
    
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 4
//    }
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let view = UIView()
//        view.backgroundColor = UIColor.darkGray
//        return view
//    }
//
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 10
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 100
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell = self.homeTableview.dequeueReusableCell(withIdentifier: "HomeTableviewCell") as? HomeTableviewCell
//        cell?.selectionStyle = .none
//        cell?.cellImageView.image = UIImage(named: "banner1.png")
//        cell?.layer.cornerRadius = 8
//        cell?.clipsToBounds = true
//        return cell ?? UITableViewCell()
//
//    }
    
    
//}
