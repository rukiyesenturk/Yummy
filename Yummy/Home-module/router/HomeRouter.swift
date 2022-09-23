//
//  HomeRouter.swift
//  Yummy
//
//  Created by Rukiye Şentürk on 12.09.2022.
//

import Foundation

class HomeRouter: PresenterToRouterHome {
    static func createModule(ref: HomeVC) {
        let presenter = HomePresenter()
        //View
        ref.presenter = presenter
        //Presenter
        ref.presenter?.interactor = HomeInteractor()
        ref.presenter?.view = ref
        //Interactor
        ref.presenter?.interactor?.presenter = presenter
    }
}
