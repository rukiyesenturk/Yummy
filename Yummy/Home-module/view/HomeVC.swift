//
//  HomeVC.swift
//  Yummy
//
//  Created by Rukiye Şentürk on 12.09.2022.
//

import UIKit
import Kingfisher

class HomeVC: UIViewController {

    @IBOutlet weak var collectionViewHomeFlow: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionViewFood: UICollectionView!
    
    var foodList = [Foods]()
    var filteredData = [Foods]()
    var presenter: ViewToPresenterHome?
    var slides: [HomeFlow] = []
    var currentPage = 0
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slides = [HomeFlow(image: UIImage(named: "slide4")!), HomeFlow(image: UIImage(named: "slide5")!), HomeFlow(image: UIImage(named: "slide6")!), HomeFlow(image: UIImage(named: "slide7")!), HomeFlow(image: UIImage(named: "slide8")!)]
        
        collectionViewFood.delegate = self
        collectionViewFood.dataSource = self
        collectionViewHomeFlow.delegate = self
        collectionViewHomeFlow.dataSource = self
        searchBar.delegate = self
        
        HomeRouter.createModule(ref: self)

        let design = UICollectionViewFlowLayout()
        design.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        design.minimumInteritemSpacing = 10
        design.minimumLineSpacing = 10
    
        collectionViewFood.collectionViewLayout = design
    }
    override func viewWillAppear(_ animated: Bool) {
        presenter?.uploadFoodList()
    }
}
extension HomeVC: PresenterToViewHome {
    func sendDataToView(foodList: Array<Foods>) {
        self.foodList = foodList
        DispatchQueue.main.async {
            self.collectionViewFood.reloadData()
        }
    }
}
extension HomeVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            isSearching = false
            collectionViewFood.reloadData()
        } else {
            isSearching = true
            filteredData = foodList.filter({$0.foodName.contains(searchText)})
            collectionViewFood.reloadData()
        }
    }
}
extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == self.collectionViewFood) {
            if isSearching {
                return filteredData.count
            }else {
                return foodList.count
            }
        }else {
            return slides.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView == self.collectionViewFood) {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "foodCell", for: indexPath) as! FoodCell
            if isSearching {
                let food = filteredData[indexPath.row]
                if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(food.foodImage)"){
                    DispatchQueue.main.async {
                        cell.imgFood.kf.setImage(with: url)
                    }
                }
                cell.lblFoodName.text = "\(food.foodName)"
                cell.lblFoodPrice.text = "₺\(food.foodPrice)"
            }else {
                let food = foodList[indexPath.row]
                if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(food.foodImage)"){
                    DispatchQueue.main.async {
                        cell.imgFood.kf.setImage(with: url)
                    }
                }
                cell.lblFoodName.text = "\(food.foodName)"
                cell.lblFoodPrice.text = "₺\(food.foodPrice)"
            }
            
            
            //cell.layer.borderColor = UIColor.lightGray.cgColor
            cell.layer.borderWidth = 0.3
            cell.layer.cornerRadius = 10.0
            cell.backgroundColor = UIColor(white: 0.95, alpha: 1)
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeFlowCell", for: indexPath) as! HomeFlowCell
            cell.setup(slides[indexPath.row])
            return cell
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (collectionView == self.collectionViewFood) {
            if isSearching {
                let food = filteredData[indexPath.row]
                performSegue(withIdentifier: "toDetail", sender: food)
            }else {
                let food = foodList[indexPath.row]
                performSegue(withIdentifier: "toDetail", sender: food)
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            if let f = sender as? Foods {
                let gidilecekVC = segue.destination as! DetailVC
                gidilecekVC.food = f
            }
        }
    }
}
extension HomeVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (collectionView == self.collectionViewFood) {
            let gridLayout = collectionViewLayout as! UICollectionViewFlowLayout
            let widht = UIScreen.main.bounds.width //collectionViewFood.frame.size.width
            let itemWidht = (widht-gridLayout.sectionInset.left - gridLayout.sectionInset.right - gridLayout.minimumInteritemSpacing) / 2
            return CGSize(width: itemWidht, height: itemWidht * 1.3)
        }else{
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.width * 1.5)
        }
    }

}

