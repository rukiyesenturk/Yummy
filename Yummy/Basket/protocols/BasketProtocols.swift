//
//  BasketProtocols.swift
//  Yummy
//
//  Created by Rukiye Şentürk on 14.09.2022.
//

import Foundation
//Ana protocoller
protocol ViewToPresenterBasket {
    var interactor: PresenterToInteractorBasket? {get set}
    var view: PresenterToViewBasket? {get set}
    
    func fetchDataInBasket(userEmail: String)
    func deleteBasketFood(userEmail: String, basketFoodId: Int, foodName: String)
    func addToBasket(foodName: String, foodImage:String, foodPrice: String, foodPiece: Int, userEmail: String)
}
protocol PresenterToInteractorBasket {
    var presenter: InteractorToPresenterBasket? {get set}
    
    func fetchDataInBasket(userEmail: String)
    func deleteBasketFood(userEmail: String, basketFoodId: Int, foodName: String)
    func addToBasket(foodName: String, foodImage:String, foodPrice: String, foodPiece: Int, userEmail: String)
}
//Taşıyıcı protocoller
protocol InteractorToPresenterBasket {
    func sendToPresenter(basketList: Array<BasketFood>)
}
protocol PresenterToViewBasket {
    func sendToView(basketList: Array<BasketFood>)
}
//Router
protocol PresenterToRouterBasket {
    static func createModule(ref: BasketVC) //hangi katmanı çalıştıracaksak onun view cont.u buraya eklememiz gerekiyor
}
