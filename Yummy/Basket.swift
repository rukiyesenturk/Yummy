//
//  Basket.swift
//  Yummy
//
//  Created by Rukiye Şentürk on 14.09.2022.
//

import Foundation

struct Basket: Codable {
    let sepetYemekler: [BasketFood]?
    let success: Int?
    
    enum CodingKeys: String, CodingKey {
        case sepetYemekler = "sepet_yemekler"
        case success
    }
}

class BasketFood: Codable {
    let basketFoodId, basketFoodName, basketImageName, basketFoodPrice, basketFoodPiece, basketUser : String

    enum CodingKeys: String, CodingKey {
        case basketFoodId = "sepet_yemek_id"
        case basketFoodName = "yemek_adi"
        case basketImageName = "yemek_resim_adi"
        case basketFoodPrice = "yemek_fiyat"
        case basketFoodPiece = "yemek_siparis_adet"
        case basketUser = "kullanici_adi"
    }
}
extension BasketFood: Equatable, Hashable {
    
    static func == (lhs: BasketFood, rhs: BasketFood) -> Bool {
        return lhs.basketFoodId == rhs.basketFoodId
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(basketFoodId)
    }
    
}
