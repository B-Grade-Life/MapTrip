//
//  ViewControllerMap.swift
//  MapTrip
//
//  Created by 김민경 on 2022/10/25.
//

import Foundation
import GoogleMaps
import UIKit

class ViewControllerMap: UIViewController {

    @IBOutlet var MapView: UIView!
    @IBOutlet var bottomView: UIView!
    
   let searchController = UISearchController()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let searchBar = UISearchBar()
        searchBar.placeholder = "카테고리 검색"
        searchBar.searchTextField.backgroundColor = UIColor(red: 251/255, green: 246/255, blue: 237/255, alpha: 1)
        self.navigationItem.titleView = searchBar
        
        
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: 37.5666805, longitude: 126.9784147, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: MapView.frame, camera: camera)
        self.view.addSubview(mapView)

        // Creates a marker in the center of the map.
        let position = CLLocationCoordinate2D(latitude: 37.5666805, longitude: 126.9784147)
        let marker = GMSMarker(position: position)
        marker.title = "Seoul"
        marker.snippet = "Korea"
        marker.map = mapView
        
        
       
        bottomView.layer.masksToBounds = false
        bottomView.layer.cornerRadius = 20
        bottomView.clipsToBounds = true

  }

}
