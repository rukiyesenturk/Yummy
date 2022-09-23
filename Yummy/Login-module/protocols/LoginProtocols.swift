//
//  LoginProtocols.swift
//  Yummy
//
//  Created by Rukiye Şentürk on 13.09.2022.
//

import Foundation
//Ana Protocoller
protocol ViewToPresenterLogin{
    var interactor: PresenterToInteractorLogin? {get set}
    var view: PresenterToViewLogin? {get set}
    
    func signIn(email:String, password:String)
    func login(email:String, password:String)
}
protocol PresenterToInteractorLogin{
    var presenter: InteractorToPresenterLogin? {get set}
    
    func signUp(email:String, password:String)
    func login(email:String, password:String)
}
//TaşıyıcıProtocol
protocol InteractorToPresenterLogin{
    func sendDataToPresenter(titleInput: String, messageInput: String, success: Bool)
}
protocol PresenterToViewLogin{
    func sendDataToView(titleInput: String, messageInput: String, success: Bool)
}
//Router
protocol PresenterToRouterLogin{
    static func createModule(ref: LoginVC)
}
