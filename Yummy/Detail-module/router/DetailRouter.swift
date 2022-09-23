//
//  DetailRouter.swift
//  Yummy
//
//  Created by Rukiye Şentürk on 13.09.2022.
//

import Foundation

class DetailRouter: PresenterToRouterDetail {
    static func createModule(ref: DetailVC) {
        ref.presenter = DetailPresenter()
        ref.presenter?.interactor = DetailInteractor()
    }
}
