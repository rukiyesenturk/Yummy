//
//  DetailVC.swift
//  Yummy
//
//  Created by Rukiye Şentürk on 13.09.2022.
//

import UIKit
import Kingfisher
import Firebase

class DetailVC: UIViewController {

    @IBOutlet weak var imgFood: UIImageView!
    @IBOutlet weak var lblFoodName: UILabel!
    @IBOutlet weak var lblFoodPrice: UILabel!
    @IBOutlet weak var lblFoodPiece: UILabel!
    
    var food: Foods?
    var basketFood: BasketFood?
    var presenter: ViewToPresenterDetail?
    var foodPiece = 1
    var onePieceFood = 0
    var totalPrice = 0
    var titleInput: String?
    var messageInput: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let f = food {
            if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(f.foodImage)"){
                DispatchQueue.main.async {
                    self.imgFood.kf.setImage(with: url)
                }
            }
            lblFoodName.text = f.foodName
            lblFoodPrice.text = "₺ \(f.foodPrice)"
            onePieceFood = Int(f.foodPrice)!
        }
        DetailRouter.createModule(ref: self)

        lblFoodPiece.text = String(foodPiece)
    }
    @IBAction func btnAddToBasket(_ sender: Any) {
        if let user = Auth.auth().currentUser?.email{
            presenter?.addToBasket(food: food!, foodPiece: foodPiece, userEmail: user)
            if titleInput != "" && messageInput != "" {
                guard let titleInput = titleInput, let messageInput = messageInput else { return }
                errorMessage(titleInput: titleInput, messageInput: messageInput)
            }
        }
    }
    @IBAction func btnIncreasePiece(_ sender: UIButton) {
        if foodPiece < 10 {
            foodPiece += 1
            lblFoodPiece.text = String(foodPiece)
            totalPrice = onePieceFood * foodPiece
            lblFoodPrice.text = "₺ \(totalPrice)"
        }
        else {
            errorMessage(titleInput: "Uyarı!", messageInput: "Maxsimum 10 adet sipariş verilebilir.")
        }
    }
    
    @IBAction func btnDecreasePiece(_ sender: UIButton) {
        if foodPiece > 1 {
            foodPiece -= 1
            lblFoodPiece.text = String(foodPiece)
            totalPrice = foodPiece * onePieceFood
            lblFoodPrice.text = "₺ \(totalPrice)"
        }
    }
    func errorMessage(titleInput: String, messageInput: String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default) { action in
            if titleInput == "Uyarı!" || titleInput == "Sepet"{
                self.navigationController?.popViewController(animated: true)
            }
        }
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}
extension DetailVC: PresenterToViewDetail{
    func sendDataToView(titleInput: String, messageInput: String) {
        self.titleInput = titleInput
        self.messageInput = messageInput
    }
}
