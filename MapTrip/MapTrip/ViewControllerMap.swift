//
//  ViewControllerMap.swift
//  MapTrip
//
//  Created by 김민경 on 2022/10/25.
//

import Foundation
import GoogleMaps

class ViewControllerMap: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: 37.5666805, longitude: 126.9784147, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        self.view.addSubview(mapView)

        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 37.5666805, longitude: 126.9784147)
        marker.title = "Seoul"
        marker.snippet = "Korea"
        marker.map = mapView
  }
}
