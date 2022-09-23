//
//  BasketRouter.swift
//  Yummy
//
//  Created by Rukiye Şentürk on 14.09.2022.
//

import Foundation

class BasketRouter: PresenterToRouterBasket {
    static func createModule(ref: BasketVC) {
        let presenter = BasketPresenter()
        //View
        ref.presenter = presenter
        //Presenter
        ref.presenter?.interactor = BasketInteractor()
        ref.presenter?.view = ref
        //Interactor
        ref.presenter?.interactor?.presenter = presenter
    }
}
