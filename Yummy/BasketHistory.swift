//
//  localBasket.swift
//  Yummy
//
//  Created by Rukiye Şentürk on 15.09.2022.
//

import Foundation

class BasketHistory {
    private init() {
       // basket = retrieveBasket()
    }
    static let sharedInstance = BasketHistory() //Singleton bir yapı oluşturduk.
    
    private(set) var basket: Set<BasketFood>!
    
    func addToBasket(_ food: BasketFood) -> Void {
        if !basket.contains(food) {
        basket.insert(food)
        }
        print(Date())
        saveBasket()
    }
    func removeFromBasket(_ food: BasketFood) -> Void {
        guard let y = basket.first(where: { $0 == food }) else { return }
        basket.remove(y)
        saveBasket()
    }
    
    func saveBasket() -> Void {
        do {
            let data = try JSONEncoder().encode(basket)
            UserDefaults.standard.set(data, forKey: "\(Date())")
            UserDefaults.standard.synchronize()
        } catch let error {
            debugPrint(error)
        }
    }
    func retrieveBasket() -> Set<BasketFood> {
        do {
            guard let data = UserDefaults.standard.object(forKey: "basket") as? Data else { return [] }
            let foods = try JSONDecoder().decode(Set<BasketFood>.self, from: data)
            return foods
        } catch let error {
            debugPrint(error)
            return []
        }
    }
}
