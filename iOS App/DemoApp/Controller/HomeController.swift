//
//  HomeController.swift
//  DemoApp
//
//  Created by David Morales on 06/02/20.
//  Copyright © 2020 David Morales. All rights reserved.
//

import UIKit
import GoogleMaps

class HomeController: UIViewController, GMSMapViewDelegate, DataPickerViewDelegate {
    
    @IBOutlet weak var mapView: GMSMapView!;
    @IBOutlet weak var cityLabel: UITextField!
    
    private let cities:[City] = City.getCities();
	private var currentMarker:GMSMarker! = nil;

    override func viewDidLoad() {
        
        // --
        super.viewDidLoad();
        
        // -- Init header view
        self.initHeaderView();
        
        // -- Creating the map
        self.createMap();
    }
    
    private func initHeaderView() {
        
        // -- Initial
        self.cityLabel.text = cities[0].name;
        
        // --
        self.setPickerView();
    }
    
    private func createMap() {
        
        // -- Get first city
        let firstCity:City = self.cities[0];
        
        // -- Camera view
        let camera = GMSCameraPosition.camera (withLatitude: CLLocationDegrees(firstCity.lat), longitude: CLLocationDegrees(firstCity.lng), zoom: 12.0);
        self.mapView.camera = camera;
        self.mapView.delegate = self;
		self.mapView.settings.zoomGestures = true;
        
        // -- Add marker
        self.addMarker(city: firstCity);
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        
        self.addMarker(lat: coordinate.latitude, lng: coordinate.longitude, title: "", description: "");
        self.mapView.selectedMarker = self.currentMarker;
    }
    
    @discardableResult private func addMarker(city:City) -> GMSMarker {
        return addMarker(lat: city.lat, lng: city.lng, title: city.name, description: "");
    }
    
    @discardableResult private func addMarker(lat:Double, lng:Double, title:String, description:String) -> GMSMarker {
        
		// -- Removing and releasiing the current marker if exists
		if (self.currentMarker != nil) {
			
			self.currentMarker.map = nil;
			self.currentMarker = nil;
		}
		
        // -- Create marker
		self.currentMarker = GMSMarker();
        self.currentMarker.position = CLLocationCoordinate2D(latitude: lat, longitude: lng);
        self.currentMarker.title = title;
        self.currentMarker.snippet = "Clima :: Cargando";
        self.currentMarker.map = self.mapView;
        Weather.getWeather(marker: self.currentMarker);
		
		// -- Moving the camera to the marker
		self.mapView.animate(toLocation: self.currentMarker.position);
		
		// -- REturn marker
        return self.currentMarker;
    }
    
    private func setPickerView() {
        
		let citiesMap:[String] = self.cities.map({ (city: City) -> String in
			return city.name
		});
        let picker = DataPickerView(pickerData: citiesMap, dropdownField: self.cityLabel);
		picker.deli = self;
		self.cityLabel.isUserInteractionEnabled = true;
		self.cityLabel.inputView = picker;
		self.cityLabel.tag = 123;
    }
	
	// -- DataPicker Listener
	func optionSelected(field: UITextField, position: Int) {
		
		// -- Getting the city
		let city = self.cities[position];
		self.addMarker(city: city);
	}
}
