//
//  ViewControllerCalendar.swift
//  MapTrip
//
//  Created by 김민경 on 2022/10/28.
//

import Foundation
import UIKit

class ViewControllerCalendar: UIViewController {
    
    let imageView: UIImageView = {
        let sampleImageView = UIImageView()
        sampleImageView.image = UIImage(named: "sampleImage")
        //image 표시방법
        sampleImageView.contentMode = .scaleAspectFit
        //둥근 테두리
        sampleImageView.layer.cornerRadius = 150
        //넘치는 영역 잘라내기
        sampleImageView.clipsToBounds = true
        
        sampleImageView.translatesAutoresizingMaskIntoConstraints = false
        return sampleImageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),imageView.widthAnchor.constraint(equalToConstant: 200),imageView.heightAnchor.constraint(equalToConstant: 230),
                            ])
    }
    
}

