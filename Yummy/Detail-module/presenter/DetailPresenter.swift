//
//  DetailPresenter.swift
//  Yummy
//
//  Created by Rukiye Şentürk on 13.09.2022.
//

import Foundation

class DetailPresenter: ViewToPresenterDetail {
    var interactor: PresenterToInteractorDetail?
    
    func addToBasket(food: Foods, foodPiece:Int, userEmail:String) {
        interactor?.addToBasket(food: food, foodPiece: foodPiece, userEmail: userEmail)
    }
    func deleteBasketFood(userEmail: String, basketFoodId: Int) {
        interactor?.deleteBasketFood(userEmail: userEmail, basketFoodId: basketFoodId)
    }
}
