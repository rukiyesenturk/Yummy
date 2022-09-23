//
//  LoginRouter.swift
//  Yummy
//
//  Created by Rukiye Şentürk on 13.09.2022.
//

import Foundation

class LoginRouter: PresenterToRouterLogin {
    static func createModule(ref: LoginVC) {
        let presenter = LoginPresenter()
        //View
        ref.presenter = presenter
        //Presenter
        ref.presenter?.interactor = LoginInteractor()
        ref.presenter?.view = ref
        //Interactor
        ref.presenter?.interactor?.presenter = presenter
    }
}
