//
//  DetailInteractor.swift
//  Yummy
//
//  Created by Rukiye Şentürk on 13.09.2022.
//

import Foundation
import Alamofire

class DetailInteractor : PresenterToInteractorDetail{
    var presenter: InteractorToPresenterDetail?
    
    func addToBasket(food: Foods, foodPiece: Int, userEmail: String) {
        if !BasketControl.sharedInstance.basketControl.contains(food) {
    
            let params:Parameters = ["yemek_adi":food.foodName, "yemek_resim_adi":food.foodImage, "yemek_fiyat":food.foodPrice, "yemek_siparis_adet":foodPiece, "kullanici_adi":userEmail]
            AF.request("http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php",method: .post,parameters: params).response{ response in
                if let data = response.data {
                    do {
                        let cevap = try JSONSerialization.jsonObject(with: data)
                        print(cevap)
                        food.foodCount = foodPiece
                        food.userEmail = userEmail
                        BasketControl.sharedInstance.addToBasket(food)
                    }catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }else {
            presenter?.sendDataToPresenter(titleInput: "Uyarı!", messageInput: "Ürün sepetinizde mevcuttur.")
        }
    }
}
