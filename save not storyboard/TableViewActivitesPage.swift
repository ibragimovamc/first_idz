//
//  TableViewActivitesPage.swift
//  first_idz
//
//  Created by Ибрагимова Татьяна on 09.01.2022.
//

import UIKit

class TableViewActivitesPage: UIViewController {
    
    
    @IBOutlet weak var Distance: UILabel!
    @IBOutlet weak var TimeAgo: UILabel!
    @IBOutlet weak var Duration: UILabel!
    @IBOutlet weak var FinishLabel: UILabel!
    @IBOutlet weak var SportDescriprion: UILabel!
    @IBOutlet weak var TimeAgoAtAll: UILabel!
    
    var activity : ActivityModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Distance.text = activity?.distance
        TimeAgo.text = activity?.deltaTime
        Duration.text = activity?.duration
        FinishLabel.text = "Старт \(activity?.started ?? "null") · Финиш \( activity?.finished ?? "null")"
        SportDescriprion.text = activity?.descriptionName
        TimeAgoAtAll.text = activity?.deltaTime
        
        self.title = activity?.descriptionName
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: nil, action: nil)
    }



}
