//
//  ViewControllerProfile.swift
//  MapTrip
//
//  Created by 김민경 on 2022/11/01.
//

import Foundation
import UIKit

class ViewControllerProfile: UIViewController {
    
    @IBOutlet var sampleImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        sampleImageView.layer.masksToBounds = false
        sampleImageView.layer.cornerRadius = sampleImageView.frame.height/2
        sampleImageView.clipsToBounds = true
    }
}
