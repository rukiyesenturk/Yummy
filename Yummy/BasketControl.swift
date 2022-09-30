//
//  BasketControl.swift
//  Yummy
//
//  Created by Rukiye Şentürk on 22.09.2022.
//

import Foundation
import UIKit
import Firebase

class BasketControl {

    private init() {
        basketControl = retrieveBasket()
    }
    static let sharedInstance = BasketControl() //Singleton bir yapı oluşturduk.
    
    private(set) var basketControl: Set<Foods>!
    
    func addToBasket(_ food: Foods) -> Void {
        if !basketControl.contains(food) {
            basketControl.insert(food)
        } else {
            guard let y = basketControl.first(where: {$0 == food}) else {return}
            y.foodCount += food.foodCount
        }
        saveBasket()
    }
    func takeOutBasket(_ food: Foods) -> Void {
        guard let y = basketControl.first(where: { $0 == food }) else { return }
        if y.foodCount > 1 {
            y.foodCount -= 1
        }else {
            basketControl.remove(y)
        }
        saveBasket()
    }
    func removeFromBasket(_ food: Foods) -> Void {
        basketControl.remove(food)
        saveBasket()
    }
    func refresh() {
        basketControl.removeAll()
        basketControl = retrieveBasket()
    }
    func removeAll() {
        basketControl.removeAll()
    }
    func saveBasket() -> Void {
        do {
            let data = try JSONEncoder().encode(basketControl)
            if let user = Auth.auth().currentUser?.email{
                UserDefaults.standard.set(data, forKey: "\(user)")
            }
            UserDefaults.standard.synchronize()
        } catch let error {
            debugPrint(error)
        }
    }
    func retrieveBasket() -> Set<Foods> {
        do {
            if let user = Auth.auth().currentUser?.email{
                guard let data = UserDefaults.standard.object(forKey: "\(user)") as? Data else { return [] }
                let food = try JSONDecoder().decode(Set<Foods>.self, from: data)
                return food
            }
            return []
        } catch let error {
            debugPrint(error)
            return []
        }
    }
}
