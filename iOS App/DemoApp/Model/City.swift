//
//  City.swift
//  DemoApp
//
//  Created by David Morales on 06/02/20.
//  Copyright © 2020 David Morales. All rights reserved.
//

import UIKit

class City {

    public fileprivate(set) var name:String = "";
    public fileprivate(set) var lat:Double = 0.0;
    public fileprivate(set) var lng:Double = 0.0;
    
    public init() {}
    
    public static func getCities() -> [City] {
        
        // --
        var cities:[City]! = [City]();
        
        // -- Creating cities
        let cdmx = City();
        cdmx.name = "Ciudad de Mexico";
        cdmx.lat = 19.370977;
        cdmx.lng = -99.180235;
        cities.append(cdmx);
        
        // -- Creating cities
        let mty = City();
        mty.name = "Monterrey";
        mty.lat = 25.688685;
        mty.lng = -100.318596;
        cities.append(mty);
        
        // -- Creating cities
        let gdl = City();
        gdl.name = "Guadalajara";
        gdl.lat = 20.662545;
        gdl.lng = -103.351035;
        cities.append(gdl);
        
        // --
        return cities;
    }
}
