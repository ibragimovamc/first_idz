//
//  ViewController.swift
//  first_idz
//
//  Created by Ибрагимова Татьяна on 28.11.2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func registration(_ sender: Any) {
        let VCregistration = therdVC(nibName: "therdVC", bundle: nil)
        navigationController?.pushViewController(VCregistration, animated: true)
    }
    @IBAction func MAINBUTTON(_ sender: Any) {
        let controller = NEWController(nibName: "NEWController", bundle: nil)
        navigationController?.pushViewController(controller, animated: true)
    }
    
}

