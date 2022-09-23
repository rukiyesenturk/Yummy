//
//  BasketPresenter.swift
//  Yummy
//
//  Created by Rukiye Şentürk on 14.09.2022.
//

import Foundation
import SwiftUI

class BasketPresenter: ViewToPresenterBasket {
    var interactor: PresenterToInteractorBasket?    
    var view: PresenterToViewBasket?
    
    func fetchDataInBasket(userEmail: String) {
        interactor?.fetchDataInBasket(userEmail: userEmail)
    }
    func deleteBasketFood(userEmail: String, basketFoodId: Int, foodName: String) {
        interactor?.deleteBasketFood(userEmail: userEmail, basketFoodId: basketFoodId, foodName: foodName)
    }
    func addToBasket(foodName: String, foodImage:String, foodPrice: String, foodPiece: Int, userEmail: String) {
        interactor?.addToBasket(foodName: foodName, foodImage: foodImage, foodPrice: foodPrice, foodPiece: foodPiece, userEmail: userEmail)
    }
}
extension BasketPresenter: InteractorToPresenterBasket {
    func sendToPresenter(basketList: Array<BasketFood>) {
        view?.sendToView(basketList: basketList)
    }
}
