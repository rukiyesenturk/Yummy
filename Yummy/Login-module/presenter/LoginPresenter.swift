//
//  LoginPresenter.swift
//  Yummy
//
//  Created by Rukiye Şentürk on 13.09.2022.
//

import Foundation

class LoginPresenter: ViewToPresenterLogin {
    
    var interactor: PresenterToInteractorLogin?
    var view: PresenterToViewLogin?
    
    func signIn(email: String, password: String) {
        interactor?.signUp(email: email, password: password)
    }
    func login(email: String, password: String) {
        interactor?.login(email: email, password: password)
    }
}
extension LoginPresenter:InteractorToPresenterLogin {
    func sendDataToPresenter(titleInput: String, messageInput: String, success: Bool) {
        view?.sendDataToView(titleInput: titleInput, messageInput: messageInput, success: success)
    }
}
