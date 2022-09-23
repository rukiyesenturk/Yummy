//
//  HomeInteractor.swift
//  Yummy
//
//  Created by Rukiye Şentürk on 12.09.2022.
//

import Foundation
import Alamofire

class HomeInteractor: PresenterToInteractorHome {
    var presenter: InteractorToPresenterHome?

    func uploadFoodList() {
        AF.request("http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php", method: .get).response{ response in
            if let data = response.data {
                do{
                    let answer = try JSONDecoder().decode(Food.self, from: data)
                    if let list = answer.yemekler {
                        self.presenter?.sendDataToPresenter(foodList: list)
                    }
                }catch {
                    print(error.localizedDescription)
                }
            }
                
        }
    }
    func search(searchText: String) {
        let params:Parameters = ["yemek_adi":searchText]
        AF.request("http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php",method: .get,parameters: params).response {
            response in
            if let data = response.data {
                do{
                    let answer = try JSONDecoder().decode(Food.self, from: data)
                    if let list = answer.yemekler {
                        print("Başarı : \(answer.success!)")
                        self.presenter?.sendDataToPresenter(foodList: list)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
