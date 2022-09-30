//
//  DetailRouter.swift
//  Yummy
//
//  Created by Rukiye Şentürk on 13.09.2022.
//

import Foundation

class DetailRouter: PresenterToRouterDetail {
    static func createModule(ref: DetailVC) {
        let presenter = DetailPresenter()
        
        ref.presenter = presenter
        ref.presenter?.interactor = DetailInteractor()
        ref.presenter?.view = ref
        ref.presenter?.interactor?.presenter = presenter
    }
}
