//
//  CollectionViewControllerForMap.swift
//  first_idz
//
//  Created by Ибрагимова Татьяна on 21.01.2022.
//

import UIKit

private let reuseIdentifier = "Cell"

class CollectionViewControllerForMap: UICollectionViewController {
    
    let dataSource:[String] = ["Велосипед", "Бег", "Ходьба" ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}
