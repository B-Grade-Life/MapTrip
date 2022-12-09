//
//  GroupCollectionViewCell.swift
//  MapTrip
//
//  Created by 김민경 on 2022/12/09.
//

import UIKit

class GroupCollectionViewCell: UICollectionViewCell {

    @IBOutlet var imageView: UIImageView!
    static let identifier = "GroupCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    public func configure(with image: UIImage){
        imageView.image = image
    }
    static func nib() -> UINib {
        return UINib(nibName: "GroupCollectionViewCell", bundle: nil)
    }
}
