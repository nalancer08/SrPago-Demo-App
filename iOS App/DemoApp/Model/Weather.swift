//
//  Weather.swift
//  DemoApp
//
//  Created by David Morales on 06/02/20.
//  Copyright © 2020 David Morales. All rights reserved.
//

import UIKit
import Alamofire
import GoogleMaps

class Weather {
    
    public fileprivate(set) var temp:Double = 0.0 {
        didSet {
			temp = (temp - 273.15).rounded(); //  -- Kalvin to Celcius
        }
    }
    
    public static func getWeather(marker:GMSMarker) {
        
		let weatherObject = Weather();
		let url = "http://api.openweathermap.org/data/2.5/weather";
		let parameters:Parameters = ["lat":marker.position.latitude, "lon":marker.position.longitude, "appid":"47fcd684cec5fb80c54d2a7553cfd19d"];
		AF.request(url, parameters: parameters).responseJSON { response in
            
            switch response.result {
                        
                case .success(let JSON):
                    print("Success with JSON: \(JSON)");
                    let response = JSON as? NSDictionary ?? NSDictionary();
                    let w = response.object(forKey: "main") as? NSDictionary ?? nil;
                    if (w != nil) {
                        
                        weatherObject.temp = w?.object(forKey: "temp") as? Double ?? 0.0;
                        marker.snippet = "Temperatura: \(weatherObject.temp) °C";
                }
                    

                case .failure(let error):
                    print("Request failed with error: \(error)");
            }
        }
    }

}
