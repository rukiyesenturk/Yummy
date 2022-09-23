//
//  BasketControl.swift
//  Yummy
//
//  Created by Rukiye Şentürk on 22.09.2022.
//

import Foundation
import UIKit

class BasketControl {
    var userEmail: String?
    private init() {
        basketControl = retrieveBasket()
    }
    static let sharedInstance = BasketControl() //Singleton bir yapı oluşturduk.
    
    private(set) var basketControl: Set<String>!
    
    func addToBasket(_ foodName: String) -> Void {
        if !basketControl.contains(foodName) {
            basketControl.insert(foodName)
        }
        saveBasket()
    }
    func removeFromBasket(_ foodName: String) -> Void {
        guard let y = basketControl.first(where: { $0 == foodName }) else { return }
            basketControl.remove(y)

        saveBasket()
    }
    
    func saveBasket() -> Void {
        do {
            let data = try JSONEncoder().encode(basketControl)
            UserDefaults.standard.set(data, forKey: "\(self.userEmail ?? "")")
            UserDefaults.standard.synchronize()
        } catch let error {
            debugPrint(error)
        }
    }
    func retrieveBasket() -> Set<String> {
        do {
            guard let data = UserDefaults.standard.object(forKey: "\(self.userEmail ?? "")") as? Data else { return [] }
            let foodNames = try JSONDecoder().decode(Set<String>.self, from: data)
            return foodNames
        } catch let error {
            debugPrint(error)
            return []
        }
    }
    func getUser() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let sceneDelegate = windowScene.delegate as? SceneDelegate,
              let userEmail = sceneDelegate.userName
        else{
            return
        }
        self.userEmail = userEmail
    }
}
