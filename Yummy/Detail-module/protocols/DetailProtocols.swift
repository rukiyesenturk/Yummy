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
    var view: PresenterToViewDetail? {get set}
    
    func addToBasket(food: Foods, foodPiece: Int, userEmail: String)
}
protocol PresenterToInteractorDetail {
    var presenter: InteractorToPresenterDetail? {get set}
    
    func addToBasket(food: Foods, foodPiece: Int, userEmail: String)
}
protocol InteractorToPresenterDetail {
    func sendDataToPresenter(titleInput: String, messageInput: String)
}
protocol PresenterToViewDetail {
    func sendDataToView(titleInput: String, messageInput: String)
}
//Router
protocol PresenterToRouterDetail {
    static func createModule(ref: DetailVC)
}
