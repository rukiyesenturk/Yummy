//
//  Food.swift
//  Yummy
//
//  Created by Rukiye Şentürk on 12.09.2022.
//

import Foundation

struct Food: Codable {
    let yemekler: [Foods]?
    let success: Int?
}

class Foods: Codable {
    let foodId, foodName, foodImage, foodPrice: String
    var foodCount: Int = 0
    var userEmail: String = ""

    enum CodingKeys: String, CodingKey {
        case foodId = "yemek_id"
        case foodName = "yemek_adi"
        case foodImage = "yemek_resim_adi"
        case foodPrice = "yemek_fiyat"
        case foodCount
        case userEmail
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        foodId = try values.decode(String.self, forKey: .foodId)
        foodName = try values.decode(String.self, forKey: .foodName)
        foodImage = try values.decode(String.self, forKey: .foodImage)
        foodPrice = try values.decode(String.self, forKey: .foodPrice)
        foodCount = try values.decodeIfPresent(Int.self, forKey: .foodCount) ?? 0
        userEmail = try values.decodeIfPresent(String.self, forKey: .userEmail) ?? ""
    }
}

extension Foods: Equatable, Hashable {
    
    static func == (lhs: Foods, rhs: Foods) -> Bool {
        return lhs.foodName == rhs.foodName
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(foodId)
    }
    
}
