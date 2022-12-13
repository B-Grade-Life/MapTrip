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
    
    var mapView: GMSMapView!
    let searchBar = UISearchBar()
    
   @Published private (set) var lat: Float = 34.09876574831812
   @Published private (set) var lon: Float = -118.32556470475944
    
    var prevLat: CLLocationDegrees = 34.09876574831812
    var prevLon: CLLocationDegrees = -118.32556470475944
   // var markers = [Double]() //배열 선언 및 초기화
    
    
    struct State{
        let lat: CLLocationDegrees
        let lon: CLLocationDegrees
        let opacity: Float
        let category: String
    }
    
    let States: [State] = [
        State(lat: 34.0977173999738,
              lon: -118.32824691379166,
              opacity: 1.0,
              category: "The Dome Entertainment Centre"
             ),
        State(lat: 34.10024052146207,
              lon: -118.32656248651944,
              opacity: 1.0,
              category: "Trader Joes")
    ]
    
    var statesData: [Response] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.mapView.delegate = self
        
        //searchBar
        searchBar.placeholder = "카테고리 검색"
        searchBar.searchTextField.backgroundColor = UIColor(red: 251/255, green: 246/255, blue: 237/255, alpha: 1)
        self.navigationItem.titleView = searchBar
        searchBar.delegate = self
        
        for state in States{
            let stateMarker = GMSMarker()
            stateMarker.position = CLLocationCoordinate2D(latitude: state.lat, longitude: state.lon)
            stateMarker.title = state.category
            stateMarker.opacity = 1
            stateMarker.icon = GMSMarker.markerImage(with: .blue)
            stateMarker.map = mapView
        }
        
  }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        print(searchBar.text, prevLat, prevLon)
        
        requestPost(url: "http://172.30.1.35:5642/map/getPlace", method: "POST", param: [
            "lat": prevLat,
            "lon": prevLon,
            "category": searchBar.text
        ])
        { (success, data) in
            self.statesData = data.data
//            print(self.statesData)
        }
        
        print(statesData)
        
        for state in statesData{
            print("check")
            let stateMarker = GMSMarker()
            stateMarker.position = CLLocationCoordinate2D(latitude: state.lat, longitude: state.lon)
            stateMarker.title = state.category
            stateMarker.opacity = state.opacity
            stateMarker.icon = GMSMarker.markerImage(with: .green)
            stateMarker.map = mapView
        }
        
    }
    //mapView
    override func loadView() {
        super.loadView()
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(lon), zoom: 15.0)
        mapView = GMSMapView.map(withFrame: MapView.frame, camera: camera)
        self.view.addSubview(mapView)
      }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
      print("You tapped at \(coordinate.latitude), \(coordinate.longitude)")
        prevLat = coordinate.latitude
        prevLon = coordinate.longitude
      let marker = GMSMarker()
      marker.position = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
      marker.map = mapView
    }
}

struct Data: Codable {
    let data: [Response]
}

struct Response: Codable {
    let lat: CLLocationDegrees
    let lon: CLLocationDegrees
    let opacity: Float
    let category: String
}

func requestPost(url: String, method: String, param: [String: Any], completionHandler: @escaping (Bool, Data) -> Void) {
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
        guard let output = try? JSONDecoder().decode(Data.self, from: data) else {
            print("Error: JSON Data Parsing failed")
            return
        }
        
        completionHandler(true, output)
    }.resume()
}
