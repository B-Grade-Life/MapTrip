//
//  ViewControllerProfile.swift
//  MapTrip
//
//  Created by 김민경 on 2022/10/28.
//

import Foundation
import UIKit

class ViewControllerProfile: UIViewController {
    
    @IBOutlet var sampleImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure(){
        sampleImageView.layer.cornerRadius = CGFloat(8)
    }
    
}
