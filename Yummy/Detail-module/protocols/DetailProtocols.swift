//
//  DetailProtocols.swift
//  Yummy
//
//  Created by Rukiye Şentürk on 13.09.2022.
//

import Foundation
//Ana protocoller
protocol ViewToPresenterDetail {
    var interactor: PresenterToInteractorDetail? {get set}
    
    func addToBasket(food: Foods, foodPiece: Int, userEmail: String)
    func deleteBasketFood(userEmail: String, basketFoodId: Int) 
}
protocol PresenterToInteractorDetail {
    func addToBasket(food: Foods, foodPiece: Int, userEmail: String)
    func deleteBasketFood(userEmail: String, basketFoodId: Int)
}

//Router
protocol PresenterToRouterDetail {
    static func createModule(ref: DetailVC)
}
