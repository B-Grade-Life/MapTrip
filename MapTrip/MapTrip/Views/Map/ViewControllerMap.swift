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
    var searchCategory: String = ""
    
    var bestRoute: String = ""
    var bestRouteText: String = ""
    var secRoute: String = ""
    var secRouteText: String = ""
    
    struct State{
        let lat: CLLocationDegrees
        let lon: CLLocationDegrees
        let opacity: Float
        let category: String
    }
    
    var States: [State] = [
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
    
    var statesData: [CategoryData] = []

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
        self.searchCategory = searchBar.text!
        requestCategoryMarker(url: API_Address + "/map/getPlace", method: "POST", param: [
            "lat": prevLat,
            "lon": prevLon,
            "category": searchBar.text
        ])
        { (success, data) in
            self.statesData = data.data
        }

        sleep(2)
        
        for state in statesData{
            let stateMarker = GMSMarker()
            stateMarker.position = CLLocationCoordinate2D(latitude: state.lat, longitude: state.lon)
            stateMarker.title = state.category
            stateMarker.opacity = state.opacity
            stateMarker.icon = GMSMarker.markerImage(with: .black)
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
    
    var markers: Array = [[String: Any]]()

    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker ) -> Bool {
        print("You tapped at \(marker.position.latitude), \(marker.position.longitude)")
        print()
        States.append(
            State(
              lat: marker.position.latitude,
              lon: marker.position.longitude,
              opacity: 1.0,
              category: self.searchCategory
            )
        )
        
        mapView.clear()
        
        for state in States{
            let stateMarker = GMSMarker()
            stateMarker.position = CLLocationCoordinate2D(latitude: state.lat, longitude: state.lon)
            stateMarker.title = state.category
            stateMarker.opacity = 1
            stateMarker.icon = GMSMarker.markerImage(with: .blue)
            stateMarker.map = mapView
            
            print(state.category)
            
            markers.append([
                "lat": Float(state.lat),
                "lon": Float(state.lon),
                "category": state.category
            ])
        }
        print("markers:", markers)
        print([
            "lat": prevLat,
            "lon": prevLon,
            "category": searchBar.text
        ])
        return true
    }
    
    var shortDistancne: [ShortestDistanceData] = []
    @IBAction func getShortDistance(_ sender: Any) {
        requestShortestDistance(url: API_Address + "/map/shortestDistance", method: "POST", param: markers)
        {(success, data) in
            self.shortDistancne = data.data
            self.bestRoute = String(self.shortDistancne[0].distance)
            self.bestRouteText = self.shortDistancne[0].route
            self.secRoute = String(self.shortDistancne[1].distance)
            self.secRouteText = self.shortDistancne[1].route
        }
    }
    
    override func prepare(for seque: UIStoryboardSegue, sender: Any?) {
        sleep(1)
        if seque.destination is ViewControllerMapRoute {
          let vc = seque.destination as? ViewControllerMapRoute
          vc?.bestRoute = self.bestRoute
            vc?.bestRouteText = self.bestRouteText
            vc?.secRoute = self.secRoute
            vc?.secRouteText = self.secRouteText
        }
        
    }
    
}

struct CategoryDataList: Codable {
    let data: [CategoryData]
}

struct CategoryData: Codable {
    let lat: CLLocationDegrees
    let lon: CLLocationDegrees
    let opacity: Float
    let category: String
}

struct ShortestDistanceDataList: Codable {
    let data: [ShortestDistanceData]
}

struct ShortestDistanceData: Codable {
    let distance: Float
    let route: String
}

func requestCategoryMarker(
    url: String, method: String, param: [String: Any], completionHandler: @escaping (Bool, CategoryDataList) -> Void
) {
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
        guard let output = try? JSONDecoder().decode(CategoryDataList.self, from: data) else {
            print("Error: JSON Data Parsing failed")
            return
        }
        
        completionHandler(true, output)
    }.resume()
}

func requestShortestDistance(url: String, method: String, param: [[String: Any]], completionHandler: @escaping (Bool, ShortestDistanceDataList) -> Void) {
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
        guard let output = try? JSONDecoder().decode(ShortestDistanceDataList.self, from: data) else {
            print("Error: JSON Data Parsing failed")
            return
        }
        
        completionHandler(true, output)
    }.resume()
}
