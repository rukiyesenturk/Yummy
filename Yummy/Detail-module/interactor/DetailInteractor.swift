//
//  DetailInteractor.swift
//  Yummy
//
//  Created by Rukiye Şentürk on 13.09.2022.
//

import Foundation
import Alamofire

class DetailInteractor : PresenterToInteractorDetail{
    
    func addToBasket(food: Foods, foodPiece: Int, userEmail: String) {
        if !BasketControl.sharedInstance.basketControl.contains(food.foodName) {
    
            let params:Parameters = ["yemek_adi":food.foodName, "yemek_resim_adi":food.foodImage, "yemek_fiyat":food.foodPrice, "yemek_siparis_adet":foodPiece, "kullanici_adi":userEmail]
            AF.request("http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php",method: .post,parameters: params).response{ response in
                if let data = response.data {
                    do {
                        let cevap = try JSONSerialization.jsonObject(with: data)
                        print(cevap)
                        food.foodCount = foodPiece
                        food.userEmail = userEmail
                        
                        BasketControl.sharedInstance.addToBasket(food.foodName)
                    }catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    func deleteBasketFood(userEmail: String, basketFoodId: Int) {
        let params:Parameters = ["kullanici_adi":userEmail,"sepet_yemek_id":basketFoodId]
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php", method: .post,parameters: params).response {
            response in
            if let data = response.data{
                do {
                    let answer = try JSONSerialization.jsonObject(with: data)
                    print(answer)

                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
}
