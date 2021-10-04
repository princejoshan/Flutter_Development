//
//  SearchCategoriesVC.swift
//  TopTekkar
//
//  Created by Murugesh on 05/09/21.
//

import UIKit

class SearchCategoriesVC: UIViewController {
    @IBOutlet weak var searchCategoryCollectionView: UICollectionView!
    var searchMode: SearchCategoriesModel!
    var searchViewModel = SearchCategoriesViewModel()
    var category:[SearchCategoriesDataModel]?
    var selectedCategory:SearchCategoriesDataModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.searchCategoryCollectionView.collectionViewLayout = getCollectionLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.callToViewModelForUIUpdate()

    }
    
    
    func callToViewModelForUIUpdate(){
        
        self.searchViewModel =  SearchCategoriesViewModel()
        self.searchViewModel.fetchData()
        self.searchViewModel.bindingData = {
            if let data = self.searchViewModel.categoryData{
                self.category = self.searchViewModel.categoryData
                DispatchQueue.main.async {
                    self.searchCategoryCollectionView.reloadData()
                }
            }
        }
     
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AcadamyList" {
               let vc = segue.destination as! AcademyListViewController
               vc.selectedCategory = self.selectedCategory
           }
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


extension SearchCategoriesVC :UICollectionViewDelegate,UICollectionViewDataSource{
    
    func getCollectionLayout() -> UICollectionViewFlowLayout{
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
              layout.sectionInset = UIEdgeInsets(top: 20, left: 5, bottom: 10, right: 5)
              layout.itemSize = CGSize(width: (UIScreen.main.bounds.width/2)-10, height: 60)
              layout.minimumInteritemSpacing = 5
              layout.minimumLineSpacing = 5
        return layout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.category?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.searchCategoryCollectionView.dequeueReusableCell(withReuseIdentifier: "SearchCategoryCollectionViewCell", for: indexPath) as? SearchCategoryCollectionViewCell
        
//        cell?.categoryImg.image = self.category?[indexPath.row].i
        if let imageName = self.category?[indexPath.row].image {
            let url = TTAppConstant.UrlConstant.baseUrl+TTAppConstant.UrlConstant.categoryAPI+imageName
            self.searchViewModel.downloadImage(url: url) { (response) in
                if let data = response as? Data{
                    cell?.categoryImg.image = UIImage.init(data: data)
                }
            }
        }
        cell?.categoryLbl.text = self.category?[indexPath.row].title
        cell?.categoryImg.layer.cornerRadius = (cell?.categoryLbl.frame.size.height)!/2
        cell?.categoryImg.layer.masksToBounds = true
        
        
        
        cell?.layer.borderColor = UIColor.lightGray.cgColor
        cell?.layer.borderWidth = 1
        cell?.layer.cornerRadius = 10
        cell?.layer.masksToBounds = true
//        cell?.isSelected = true

//        cell?.layer.cornerRadius =  8
//        cell?.clipsToBounds = true
        return cell ?? UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.selectedCategory = self.category?[indexPath.row]
        
       
        if let category = self.selectedCategory {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(category) {
                let defaults = UserDefaults.standard
                defaults.set(encoded, forKey: "selectedCategory")
            }
        }

        performSegue(withIdentifier: "AcadamyList", sender: self)

        
    }
    
    
}

