//
//  VCButton_to_main_page.swift
//  first_idz
//
//  Created by Ибрагимова Татьяна on 08.12.2021.
//

import UIKit

class VCButton_to_main_page: UIViewController {

    @IBOutlet weak var login: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func Button_checker(_ sender: Any) {
        let login_user = login.text ?? ""
        let password_user = password.text ?? ""
        
        let body = LogModel(login: login_user, password: password_user)
        
        do {
            let requestBody = try Auth.encoder.encode(body)
            let queue = DispatchQueue.global(qos: .utility)
            
            Auth.login(requestBody) { user in
                queue.async {
                    UserDefaults.standard.set(user.token, forKey: "token")
                }
            
            } errors: { err in
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Что-то", message: "Пошло не так", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Что-то пошло не так :-(", style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    }
                }
            let getthemall = MainPage(nibName: "MainPage", bundle: nibBundle)
            let NewVC = MainPage(nibName: "MainPage", bundle: nil)
            navigationController?.setViewControllers([getthemall], animated: true)
        } catch {
            print(error)
        }
    }
}
