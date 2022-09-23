//
//  HomePresenter.swift
//  Yummy
//
//  Created by Rukiye Şentürk on 12.09.2022.
//

import Foundation

class HomePresenter: ViewToPresenterHome{
    
    var interactor: PresenterToInteractorHome?
    var view: PresenterToViewHome?
    
    func uploadFoodList() {
        interactor?.uploadFoodList()
    }
    func search(searchText: String) {
        interactor?.search(searchText: searchText)
    }
}
extension HomePresenter: InteractorToPresenterHome {
    func sendDataToPresenter(foodList: Array<Foods>) {
        view?.sendDataToView(foodList: foodList)
    }
}
