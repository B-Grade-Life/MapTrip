//
//  ViewControllerMapRoute.swift
//  MapTrip
//
//  Created by 김민경 on 2022/11/10.
//

import Foundation
import UIKit

class ViewControllerMapRoute: UIViewController {
    
    @IBOutlet var viewBestRoute: UIView!
    @IBOutlet var viewRoute: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewBestRoute.layer.masksToBounds = false
        viewBestRoute.layer.cornerRadius = 10
        viewBestRoute.clipsToBounds = true
        
        viewRoute.layer.masksToBounds = false
        viewRoute.layer.cornerRadius = 10
        viewRoute.clipsToBounds = true
    }
}

