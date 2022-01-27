//
//  TableViewCell.swift
//  first_idz
//
//  Created by Ибрагимова Татьяна on 05.01.2022.
//

import UIKit

struct ActivityModel {
    let distance: String
    let duration: String
    let descriptionName: String
    let deltaTime: String
    let started: String
    let finished: String

}

struct ActivitiesTableSection {
    let date: String
    let activities: [ActivityModel]
}

class TableViewCell: UITableViewCell {

    @IBOutlet weak var View: UIView!
    @IBOutlet weak var TitelLabel: UILabel!
    @IBOutlet weak var SubTitle: UILabel!
    @IBOutlet weak var FitnesName: UILabel!
    @IBOutlet weak var Time: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = .clear
        self.selectionStyle = .none
        View.layer.cornerRadius = 10
        View.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    func setCellStats(_ model : ActivityModel){
        TitelLabel.text = model.distance
        SubTitle.text = model.duration
        FitnesName.text = model.descriptionName
        Time.text = model.deltaTime
    }
    
}
