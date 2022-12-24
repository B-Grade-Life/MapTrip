//
//  NewPlanTableViewCell.swift
//  MapTrip
//
//  Created by 김민경 on 2022/12/11.
//

import UIKit

class NewPlanTableViewCell: UITableViewCell {
    
    @IBOutlet var lineImageView: UIImageView!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblDate: UILabel!
    
    func setup(with plan: table){
        lblTitle.text = plan.content
        lblDate.text = plan.date
    }
}
