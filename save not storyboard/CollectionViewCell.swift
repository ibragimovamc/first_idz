//
//  CollectionViewCell.swift
//  first_idz
//
//  Created by Ибрагимова Татьяна on 20.01.2022.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var Label_tag: UILabel!
    
    override var isSelected: Bool{
        didSet{
       
            layer.borderWidth = isSelected ? 2 : 1
            layer.borderColor = isSelected ? UIColor.purple.cgColor : UIColor.lightGray.cgColor
            
        }
    }
    class SelectedItemCell: UICollectionViewCell {
        class var identifier: String{
            return String(describing: self)
        }
        class var nib: UINib{
            return UINib(nibName: identifier, bundle: nil)
        }
        @IBOutlet weak var deleteButton: UIButton!
        
        
        var callback : (()->Void)?

        @IBAction func deleteAction(_ sender: Any) {
            callback?()
        }
    }
}
