//
//  profileViewController.swift
//  first_idz
//
//  Created by Ибрагимова Татьяна on 28.01.2022.
//

import UIKit
import HealthKitUI
import HealthKit

class profileViewController: UIViewController {
    
    
    
    private var user : UserModel? {
        didSet{
            profile_label?.text = user?.name
            nick_label?.text = user?.login
            gender_label?.text = user?.gender.name
        }
    }
    
    @IBOutlet weak var health_view: UIView!
    
    @IBOutlet weak var gender_label: UILabel!
    @IBOutlet weak var password_label: UILabel!
    @IBOutlet weak var nick_label: UILabel!
    @IBOutlet weak var profile_label: UILabel!
    @IBOutlet weak var profile_view: UIView!
    @IBOutlet weak var gender_view: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        profile_view.layer.cornerRadius = 15
        gender_view.layer.cornerRadius = 15
        

    }
    override func viewWillAppear(_ animated: Bool) {
        Auth.profile { user in
            DispatchQueue.main.async {
                self.user = user
            }
        } reject: { err in
            print(err)
        }
    }
    

    @IBAction func button_to_quit(_ sender: Any) {
        Auth.logout {
            DispatchQueue.main.async {
                UserDefaults.standard.removeObject(forKey: "token")
                let main_view_page = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
                main_view_page?.modalPresentationStyle = .fullScreen
                self.present(main_view_page!, animated: true, completion: nil)
            }
        } reject: { error in
            print(error)
        }
    }
    

}
