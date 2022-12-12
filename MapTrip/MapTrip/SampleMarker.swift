//
//  SampleMarker.swift
//  MapTrip
//
//  Created by 김민경 on 2022/12/11.
//

import UIKit
import GoogleMaps

struct State{
    let title: String
    let lat: CLLocationDegrees
    let lon: CLLocationDegrees
}
let States: [State] = [
    State(title: "California", lat: 36.77, lon: -119.42),
       State(title: "Los Angeles", lat: 34.05, lon: -118.2),
       State(title: "SanFrancisco", lat: 37.77, lon: -122.41),
       State(title: "San Diago", lat: 32.72, lon: -117.16)
]
