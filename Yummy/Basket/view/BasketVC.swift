//
//  BasketVC.swift
//  Yummy
//
//  Created by Rukiye Şentürk on 14.09.2022.
//

import UIKit
import Firebase

class BasketVC: UIViewController {

    @IBOutlet weak var basketTableView: UITableView!
    @IBOutlet weak var lblBasketTotalPrice: UILabel!
    
    var food: [Foods] = []
    var presenter: ViewToPresenterBasket?
    var basketList: [BasketFood] = []
    var totalPrice = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        basketTableView.delegate = self
        basketTableView.dataSource = self
        
        BasketRouter.createModule(ref: self)
        
    }
  
    override func viewWillAppear(_ animated: Bool) {
        totalPrice = 0
        if let user = Auth.auth().currentUser?.email{
            presenter?.fetchDataInBasket(userEmail: user)
            self.basketTableView.reloadData()
        }
    }

    @IBAction func btnApproveBasket(_ sender: UIButton) {
        
        for i in basketList {
            if let user = Auth.auth().currentUser?.email {
                BasketControl.sharedInstance.removeAll()
                presenter?.deleteBasketFood(userEmail: user, basketFoodId: Int(i.basketFoodId)!, foodName: i.basketFoodName)
                presenter?.fetchDataInBasket(userEmail: user)
            }
           
        }
        lblBasketTotalPrice.text = "-- ₺"
        let alert = UIAlertController(title: "Siparişiniz Oluşturuldu.", message: "Hemen Hazırlanıyor.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Evet", style: .destructive) {action in
            let root = self.storyboard?.instantiateViewController(withIdentifier: "custemTabBarController")
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            windowScene?.keyWindow?.rootViewController = root
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}
extension BasketVC: PresenterToViewBasket {
    func sendToView(basketList: Array<BasketFood>) {
        self.food = Array(BasketControl.sharedInstance.basketControl)
        self.basketList = basketList
        DispatchQueue.main.async {
            self.totalPrice = 0
            self.basketTableView.reloadData()
        }
    }
}
extension BasketVC: UITableViewDelegate, UITableViewDataSource, BasketCellProtocol {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return basketList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let b = basketList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasketCell", for: indexPath) as! BasketCell
        cell.lblFoodName.text = b.basketFoodName
        let fiyat = Int(b.basketFoodPrice)
        let adet = Int(b.basketFoodPiece)
        let toplamfiyat = fiyat! * adet!
        self.totalPrice += toplamfiyat
        self.lblBasketTotalPrice.text = "\(totalPrice) TL"
        print(self.totalPrice)
        cell.lblFoodPrice.text = "₺ \(toplamfiyat)"
        cell.lblFoodPiece.text = "\(b.basketFoodPiece)"
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(b.basketImageName)"){
            DispatchQueue.main.async {
                cell.imgFoodBasket.kf.setImage(with: url)
            }
        }
        
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        cell.backgroundColor = UIColor.white
        cell.selectionStyle = .none
        
        cell.basketProtocol = self
        cell.indexPath = indexPath

        return cell
    }
    func btnIncreasePieceClicked(indexPath: IndexPath, foodPiece: Int) {
        let food = self.food[indexPath.row]
        let b = self.basketList[indexPath.row]
        self.totalPrice = 0
        BasketControl.sharedInstance.addToBasket(food)
        self.food = Array(BasketControl.sharedInstance.basketControl)
        presenter?.deleteBasketFood(userEmail: b.basketUser, basketFoodId: Int(b.basketFoodId)!, foodName:b.basketFoodName)
        presenter?.addToBasket(foodName: b.basketFoodName, foodImage: b.basketImageName, foodPrice: b.basketFoodPrice, foodPiece: foodPiece, userEmail: b.basketUser)
        basketTableView.reloadData()

    }
    func btnDecreasePieceClicked(indexPath: IndexPath, foodPiece: Int) {
        let food = self.food[indexPath.row]
        let b = self.basketList[indexPath.row]
        self.totalPrice = 0
        BasketControl.sharedInstance.takeOutBasket(food)
        self.food = Array(BasketControl.sharedInstance.basketControl)
        presenter?.deleteBasketFood(userEmail: b.basketUser, basketFoodId: Int(b.basketFoodId)!, foodName:b.basketFoodName)
        presenter?.addToBasket(foodName: b.basketFoodName, foodImage: b.basketImageName, foodPrice: b.basketFoodPrice, foodPiece: foodPiece, userEmail: b.basketUser)
        basketTableView.reloadData()
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Sil") { (contextualAction, view, bool) in
            let b = self.basketList[indexPath.row]
            let alert = UIAlertController(title: "Silme İşlemi", message: "\(b.basketFoodName) silinsin mi?", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "İptal", style: .cancel) {action in}
            let okAction = UIAlertAction(title: "Evet", style: .destructive) {action in
                self.totalPrice = 0
                for f in self.food {
                    if f.foodName == b.basketFoodName {
                        BasketControl.sharedInstance.removeFromBasket(f)
                    }
                }
                self.presenter?.deleteBasketFood(userEmail: b.basketUser, basketFoodId: Int(b.basketFoodId)!, foodName: b.basketFoodName)
                self.basketTableView.reloadData()
            }
            alert.addAction(cancelAction)
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let cellSpacingHeight: CGFloat = 15
        return cellSpacingHeight
    }
}

