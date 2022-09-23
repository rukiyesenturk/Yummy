//
//  HomeProtocols.swift
//  Yummy
//
//  Created by Rukiye Şentürk on 12.09.2022.
//

import Foundation

//Ana Protocoller
protocol ViewToPresenterHome{
    var interactor: PresenterToInteractorHome? {get set}
    var view: PresenterToViewHome? {get set}
    
    func uploadFoodList()
    func search(searchText: String)
}
protocol PresenterToInteractorHome{
    var presenter: InteractorToPresenterHome? {get set}
    func uploadFoodList()
    func search(searchText: String)
}
//TaşıyıcıProtocol
protocol InteractorToPresenterHome{
    func sendDataToPresenter(foodList: Array<Foods>)
}
protocol PresenterToViewHome{
    func sendDataToView(foodList: Array<Foods>)
}
//Router
protocol PresenterToRouterHome{
    static func createModule(ref: HomeVC)
}
