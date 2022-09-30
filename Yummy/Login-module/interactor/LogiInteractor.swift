//
//  LogiInteractor.swift
//  Yummy
//
//  Created by Rukiye Şentürk on 13.09.2022.
//

import Foundation
import Firebase

class LoginInteractor: PresenterToInteractorLogin {
  
    var presenter: InteractorToPresenterLogin?

    func signUp(email:String, password:String){
        if email != "" && password != "" {
            Auth.auth().createUser(withEmail: email, password: password) { authdataresult, error in
                if error != nil {
                    self.presenter?.sendDataToPresenter(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error, Plese try again!", success: false)
                    //self.errorMessage(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error, Plese try again!")
                }else{
                    self.presenter?.sendDataToPresenter(titleInput: "", messageInput: "", success: true)
                }
            }
        }else {
            self.presenter?.sendDataToPresenter(titleInput: "Error", messageInput: "Enter Your Email and Password", success: false)
        }
    }
    func login(email: String, password: String) {
        if email != "" && password != ""{
            Auth.auth().signIn(withEmail: email, password: password) { authdataresult, error in
                if error != nil{
                    self.presenter?.sendDataToPresenter(titleInput: "Error", messageInput: error?.localizedDescription ?? "You got an error, please try again!", success: false)
                }else{
                    BasketControl.sharedInstance.refresh()
                    self.presenter?.sendDataToPresenter(titleInput: "", messageInput: "", success: true)
                }
            }
        }else{
            self.presenter?.sendDataToPresenter(titleInput: "Error", messageInput: "Enter Your Email and Password", success: false)
        }
    }
}
