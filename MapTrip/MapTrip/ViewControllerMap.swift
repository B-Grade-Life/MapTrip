//
//  ViewControllerMap.swift
//  MapTrip
//
//  Created by 김민경 on 2022/10/25.
//

import Foundation
import GoogleMaps
import UIKit

class ViewControllerMap: UIViewController, GMSMapViewDelegate {

    @IBOutlet var MapView: UIView!
//    @IBOutlet var bottomView: UIView!
    
    var mapView: GMSMapView!
    
   let searchController = UISearchController()
    
   @Published private (set) var lat: Float = 37.25
   @Published private (set) var lon: Float = -119.9
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.mapView.delegate = self
        
        let searchBar = UISearchBar()
        searchBar.placeholder = "카테고리 검색"
        searchBar.searchTextField.backgroundColor = UIColor(red: 251/255, green: 246/255, blue: 237/255, alpha: 1)
        self.navigationItem.titleView = searchBar
        
        
        requestPost(url: "http://192.168.70.192:5642/map/marker", method: "POST", param: ["token":"test"])
        { (success, data) in
            self.lat = data.lat
            self.lon = data.lon
            print(self.lat, self.lon)
        }

  }
    override func loadView() {
        super.loadView()
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(lon), zoom: 6.0)
        mapView = GMSMapView.map(withFrame: MapView.frame, camera: camera)
        self.view.addSubview(mapView)
      }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
      print("You tapped at \(coordinate.latitude), \(coordinate.longitude)")
      let marker = GMSMarker()
      marker.position = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
      marker.title = "Sydney"
      marker.snippet = "Australia"
      marker.map = mapView
    }
}

struct Response: Codable {
    let success: Bool
    let lat: Float
    let lon: Float
}

func requestPost(url: String, method: String, param: [String: Any], completionHandler: @escaping (Bool, Response) -> Void) {
    let sendData = try! JSONSerialization.data(withJSONObject: param, options: [])
    
    guard let url = URL(string: url) else {
        print("Error: cannot create URL")
        return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = method
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = sendData
    
    URLSession.shared.dataTask(with: request) { (data, response, error) in
        guard error == nil else {
            print("Error: error calling GET")
            print(error!)
            return
        }
        guard let data = data else {
            print("Error: Did not receive data")
            return
        }
        guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
            print("Error: HTTP request failed")
            return
        }
        guard let output = try? JSONDecoder().decode(Response.self, from: data) else {
            print("Error: JSON Data Parsing failed")
            return
        }
        
        completionHandler(true, output)
    }.resume()
}
