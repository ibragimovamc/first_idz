//
//  NEWController.swift
//  first_idz
//
//  Created by Ибрагимова Татьяна on 03.12.2021.
//

import UIKit

class NEWController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func controller(_ sender: Any) {
        let controller = therdVC(nibName: "therdVC", bundle: nil)
        navigationController?.pushViewController(controller, animated: true)
    }
}
