//
//  DetailPresenter.swift
//  Yummy
//
//  Created by Rukiye Şentürk on 13.09.2022.
//

import Foundation

class DetailPresenter: ViewToPresenterDetail {
    var view: PresenterToViewDetail?
    var interactor: PresenterToInteractorDetail?
    
    func addToBasket(food: Foods, foodPiece:Int, userEmail:String) {
        interactor?.addToBasket(food: food, foodPiece: foodPiece, userEmail: userEmail)
    }
}
extension DetailPresenter: InteractorToPresenterDetail {
    func sendDataToPresenter(titleInput: String, messageInput: String) {
        view?.sendDataToView(titleInput: titleInput, messageInput: messageInput)
    }
}
