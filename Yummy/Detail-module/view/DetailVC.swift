//
//  DetailVC.swift
//  Yummy
//
//  Created by Rukiye Şentürk on 13.09.2022.
//

import UIKit
import Kingfisher

class DetailVC: UIViewController {

    @IBOutlet weak var imgFood: UIImageView!
    @IBOutlet weak var lblFoodName: UILabel!
    @IBOutlet weak var lblFoodPrice: UILabel!
    @IBOutlet weak var lblFoodPiece: UILabel!
    
    var food: Foods?

    var presenter: ViewToPresenterDetail?
    var userEmail:String?
    var foodPiece = 1
    var onePieceFood = 0
    var totalPrice = 0
    
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
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let sceneDelegate = windowScene.delegate as? SceneDelegate,
              let userName = sceneDelegate.userName
        else{
            return
        }
        self.userEmail = userName
        lblFoodPiece.text = String(foodPiece)
    }
    @IBAction func btnAddToBasket(_ sender: Any) {
        presenter?.addToBasket(food: food!, foodPiece: foodPiece, userEmail: userEmail ?? "")
        navigationController?.popViewController(animated: true)
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
        let okButton = UIAlertAction(title: "Evet", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}
