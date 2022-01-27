//
//  ViewControllerForRegistetry.swift
//  first_idz
//
//  Created by Ибрагимова Татьяна on 25.01.2022.
//

import UIKit

class ViewControllerForRegistetry: UIViewController {

    
    @IBOutlet weak var login: UITextField!
    
    @IBOutlet weak var samePassword: UITextField!
    @IBOutlet var picker: UIPickerView!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var name: UITextField!
    
    var holder_for_gender = 0
    private var pickerData = ["Мужской","Женский"]
    
    
    override func viewDidLoad() {
        
        picker.dataSource = self
        picker.delegate = self
        super.viewDidLoad()

    }
    @IBAction func Button_checker(_ sender: Any) {
        let login_user = login.text ?? ""
        let password_user = password.text ?? ""
        let paasword_user_pruf = samePassword.text ?? ""
        let name_user = name.text ?? ""
        let gender = holder_for_gender
        if (password_user != paasword_user_pruf) {
            let alert = UIAlertController(title: "Ошибка", message: "Пароли не совпадают", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Попробуйте снова", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)        }
        else {
            let body = RegModel(login: login_user, password: password_user, confirmPassword: paasword_user_pruf, gender: gender, name: name_user)
            
            do {
                let requestBody = try Auth.encoder.encode(body)
                let queue = DispatchQueue.global(qos: .utility)
                
                Auth.register(requestBody) { user in
                    queue.async {
                        UserDefaults.standard.set(user.token, forKey: "token")
                        
                        print("TOKEN" + user.token)
                    }
                } errors: { err in
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Что-то", message: "Пошло не так", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Попробуйте снова ", style: .cancel, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
                
            } catch {
                print(error)
            }

        }
        
            
    }
}


extension ViewControllerForRegistetry:UIPickerViewDataSource,UIPickerViewDelegate{


    func pickerView(_ picker: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }

    func numberOfComponents(in picker: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ picker: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        holder_for_gender = row
    }
}
