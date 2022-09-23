//
//  ViewController.swift
//  Yummy
//
//  Created by Rukiye Şentürk on 12.09.2022.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var gifView: UIImageView!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btnPassword: UIButton!
    
    var iconClick = false
    var presenter: ViewToPresenterLogin?
    
    var titleInput: String?
    var messageInput: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //gifView.loadGif(name: "yummy!")
        LoginRouter.createModule(ref: self)
    }

    @IBAction func btnPassword(_ sender: UIButton) {
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .large)
        if iconClick == false {
            tfPassword.isSecureTextEntry = false
            let largeBolDoc = UIImage(systemName: "eye", withConfiguration: largeConfig)
            btnPassword.setImage(largeBolDoc, for: .normal)
            iconClick = true
        }else {
            tfPassword.isSecureTextEntry = true
            let largeBolDoc = UIImage(systemName: "eye.slash", withConfiguration: largeConfig)
            btnPassword.setImage(largeBolDoc, for: .normal)
            iconClick = false
        }
    }
    @IBAction func btnSignIn(_ sender: UIButton) {
        presenter?.signIn(email: tfEmail.text ?? "", password: tfPassword.text ?? "")
        if titleInput != "" && messageInput != "" {
            guard let titleInput = titleInput, let messageInput = messageInput else { return }
            errorMessage(titleInput: titleInput, messageInput: messageInput)
            
        }
    }
    
    @IBAction func btnLogin(_ sender: UIButton) {
        presenter?.login(email: tfEmail.text ?? "", password: tfPassword.text ?? "")
        guard let titleInput = titleInput, let messageInput = messageInput else {return}
        if titleInput != "" && messageInput != ""{
            errorMessage(titleInput: titleInput, messageInput: messageInput)
        }
    }
    func errorMessage(titleInput: String, messageInput: String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}
extension LoginVC: PresenterToViewLogin {
    func sendDataToView(titleInput: String, messageInput: String, success: Bool) {
        self.titleInput = titleInput
        self.messageInput = messageInput
        if success {
            let root = storyboard?.instantiateViewController(withIdentifier: "custemTabBarController")
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            windowScene?.keyWindow?.rootViewController = root
        }
    }
}


