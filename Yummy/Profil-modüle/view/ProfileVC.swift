//
//  ProfileVC.swift
//  Yummy
//
//  Created by Rukiye Şentürk on 13.09.2022.
//

import UIKit
import Firebase
import SwiftUI

class ProfileVC: UIViewController {

    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var txfUserName: UITextField!
    @IBOutlet weak var txfUserEmail: UITextField!
    @IBOutlet weak var txfUserPhone: UITextField!
    @IBOutlet weak var profileCollectionView: UICollectionView!
    

    var slides: [ProfileSlide] = []
    var user: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        profileCollectionView.delegate = self
        profileCollectionView.dataSource = self
        
        slides = [ProfileSlide(image: "house.fill", title: "Adreslerim"), ProfileSlide(image: "building.columns.fill", title: "Favori Restoranlar"),ProfileSlide(image: "cart.fill", title: "Geçmiş Siparişler"),ProfileSlide(image: "phone.fill", title: "İletişim Tercihleri"),ProfileSlide(image: "bubble.left.and.bubble.right.fill", title: "Hesap Ayarları"),ProfileSlide(image: "person.crop.circle.badge.minus.fill", title: "Çıkış Yap")]
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        profileCollectionView.collectionViewLayout = layout
        
        getUser()
        
        txfUserName.isUserInteractionEnabled = false
        txfUserEmail.isUserInteractionEnabled = false
        txfUserPhone.isUserInteractionEnabled = false
    }
    func getUser() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let sceneDelegate = windowScene.delegate as? SceneDelegate,
              let userEmail = sceneDelegate.userName
        else{
            return
        }
        self.txfUserEmail.text = userEmail
    }
    @IBAction func btnEditProfile(_ sender: UIButton) {
        if sender.isEnabled == true {
            txfUserName.isUserInteractionEnabled = true
            txfUserPhone.isUserInteractionEnabled = true
        }
    }
}

extension ProfileVC: UICollectionViewDelegate,UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileDetailCell", for: indexPath) as! ProfileDetailCell
        //cell.setup(slides[indexPath.row])
        let list = slides[indexPath.row]
        cell.lblProfileInformation.text = list.title
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 12, weight: .heavy, scale: .large)
        let laergeBolDoc = UIImage(systemName: "\(list.image)", withConfiguration: largeConfig)
        cell.btnProfileInformation.setImage(laergeBolDoc, for: .normal)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ProfileDetailCell {
            if cell.lblProfileInformation.text == "Çıkış Yap" {
                let signOutAction = UIAlertController(title: "Çıkış Yap", message: "Çıkmak istediğinizden emin misiniz?", preferredStyle: .alert)
                let iptalAction = UIAlertAction(title: "İptal", style: .cancel) { action in}
                let evetAction = UIAlertAction(title: "Evet", style: .destructive) { action in
                    do {
                        try Auth.auth().signOut()
                        let root = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC")
                        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                        windowScene?.keyWindow?.rootViewController = root
                        }catch let error {
                            print("errorrrrrr", error)
                        }
                    }
                signOutAction.addAction(iptalAction)
                signOutAction.addAction(evetAction)
                self.present(signOutAction, animated: true)
            
            }}
    }
}
extension ProfileVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let gridLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let widht = UIScreen.main.bounds.width
        let itemWidht = (widht - gridLayout.sectionInset.left - gridLayout.sectionInset.right)
      
            return CGSize(width: itemWidht, height: 40)
        
    }
}
