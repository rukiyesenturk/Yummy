//
//  BasketInteractor.swift
//  Yummy
//
//  Created by Rukiye Şentürk on 14.09.2022.
//

import Foundation
import Alamofire
import Kingfisher

class BasketInteractor: PresenterToInteractorBasket {
    
    var presenter: InteractorToPresenterBasket?
    
    func fetchDataInBasket(userEmail: String) {
        let params:Parameters = ["kullanici_adi":userEmail]
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php", method: .post,parameters: params).response {
            response in
            if let data = response.data {
                print(data)
                do{
                    let answer = try JSONDecoder().decode(Basket.self, from: data)
                    print(answer)
                    var list = [BasketFood]()
                    if let answerlist = answer.sepetYemekler {
                        list = answerlist
                        
                    }
                    self.presenter?.sendToPresenter(basketList: list.sorted{ $0.basketFoodName < $1.basketFoodName })
                }catch {
                    print(error.localizedDescription)
                    self.presenter?.sendToPresenter(basketList: [])
                }
            }
        }
    }
    func deleteBasketFood(userEmail: String, basketFoodId: Int, foodName: String) {
        let params:Parameters = ["kullanici_adi":userEmail,"sepet_yemek_id":basketFoodId]
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php", method: .post,parameters: params).response {
            response in
            if let data = response.data{
                do {
                    let answer = try JSONSerialization.jsonObject(with: data)
                    print(answer)
                    self.fetchDataInBasket(userEmail: userEmail)
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
    func addToBasket(foodName: String, foodImage:String, foodPrice: String, foodPiece: Int, userEmail: String) {
        
        let params:Parameters = ["yemek_adi":foodName, "yemek_resim_adi":foodImage, "yemek_fiyat":foodPrice, "yemek_siparis_adet":foodPiece, "kullanici_adi":userEmail]
        AF.request("http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php",method: .post,parameters: params).response{ response in
            if let data = response.data {
                do {
                    let cevap = try JSONSerialization.jsonObject(with: data)
                    print(cevap)
                    //BasketControl.sharedInstance.addToBasket(foodName)
                }catch {
                    print(error.localizedDescription)
                }
            }
        }
        
        
    }
}
