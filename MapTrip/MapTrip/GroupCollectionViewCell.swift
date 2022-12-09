//
//  GroupCollectionViewCell.swift
//  MapTrip
//
//  Created by 김민경 on 2022/12/09.
//

import UIKit

class GroupCollectionViewCell: UICollectionViewCell {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var lblGrouopTitle: UILabel!
//    @IBOutlet var collectionViewCell: UIView!
    
    func setup(with group: GroupList){
//        collectionViewCell.layer.masksToBounds = false
//        collectionViewCell.layer.cornerRadius = 15
//        collectionViewCell.clipsToBounds = true
        imageView.image = group.image
        lblGrouopTitle.text = group.title
    }
}
