//
//  ViewControllerMap.swift
//  MapTrip
//
//  Created by 김민경 on 2022/10/25.
//

import Foundation
import GoogleMaps
import UIKit

class ViewControllerMap: UIViewController, GMSMapViewDelegate, UISearchBarDelegate {

    @IBOutlet var MapView: UIView!
//    @IBOutlet var bottomView: UIView!
    
    var mapView: GMSMapView!
    
    let searchBar = UISearchBar()
    
   @Published private (set) var lat: Float = 37.25
   @Published private (set) var lon: Float = -119.9
    var category: String = "Cafe"
    
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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.mapView.delegate = self
        
        //searchBar
        searchBar.placeholder = "카테고리 검색"
        searchBar.searchTextField.backgroundColor = UIColor(red: 251/255, green: 246/255, blue: 237/255, alpha: 1)
        self.navigationItem.titleView = searchBar
        searchBar.delegate = self
        
        
        requestPost(url: "http://192.168.70.192:5642/map/marker", method: "POST", param: ["token":"test"])
        { (success, data) in
            self.lat = data.lat
            self.lon = data.lon
            print(self.lat, self.lon)
        }
        
        for state in States{
            let stateMarker = GMSMarker()
            stateMarker.position = CLLocationCoordinate2D(latitude: state.lat, longitude: state.lon)
            stateMarker.title = state.title
            stateMarker.opacity = 0.7
            stateMarker.map = mapView
        }
        
  }
   
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        print(searchText, self.lat, self.lon, self.category)
    }
    
    //mapView
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
      marker.title = "California"
      marker.snippet = "USA"
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
