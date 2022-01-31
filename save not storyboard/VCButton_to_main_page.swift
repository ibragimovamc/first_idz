//
//  VCButton_to_main_page.swift
//  first_idz
//
//  Created by Ибрагимова Татьяна on 08.12.2021.
//

import UIKit

class VCButton_to_main_page: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
<<<<<<< Updated upstream

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
=======
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
            let getthemall = profileViewController(nibName: "profileViewController", bundle: nibBundle)
            let NewVC = MainPage(nibName: "MainPage", bundle: nil)
            navigationController?.setViewControllers([NewVC], animated: true)
        } catch {
            print(error)
        }
>>>>>>> Stashed changes
    }
    */

}
