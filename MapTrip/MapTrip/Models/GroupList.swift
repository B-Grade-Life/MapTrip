//
//  GroupList.swift
//  MapTrip
//
//  Created by 김민경 on 2022/12/09.
//

import UIKit

struct GroupList{
    let title: String
    let image: UIImage
}

let Groups: [GroupList] = [
    GroupList(title: "Los Angeles", image: UIImage(named: "LA")!),
    GroupList(title: "San Francisco", image: UIImage(named: "SanFrancisco")!),
    GroupList(title: "San Diego", image: UIImage(named: "SanDiego")!)
]
