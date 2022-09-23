//
//  ProfileProtocols.swift
//  Yummy
//
//  Created by Rukiye Şentürk on 13.09.2022.
//

import Foundation

protocol ViewToPresenterProfile {
    var interactor: PresenterToInteractorProfile? {get set}
}
protocol PresenterToInteractorProfile {
    
}
protocol PresenterToRouterProfile{
    static func createModule(ref: ProfileVC)
}
