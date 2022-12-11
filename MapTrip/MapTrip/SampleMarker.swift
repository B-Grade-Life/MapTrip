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
    let lon: CLLocationDegrees
    let lat: CLLocationDegrees
    let opacity: Float
}
let States: [State] = [
    State(title: "California", lon: 36.77, lat: -119.42, opacity: 0.7),
    State(title: "Los Angeles", lon: 34.05, lat: -118.24, opacity: 0.7),
    State(title: "SanFrancisco", lon: 37.77, lat: -122.41, opacity: 0.7),
    State(title: "San Diago", lon: 32.72, lat: -117.16, opacity: 0.7)
]
