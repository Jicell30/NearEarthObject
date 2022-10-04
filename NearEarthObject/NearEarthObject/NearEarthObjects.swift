//
//  NearEarthObjects.swift
//  NearEarthObject
//
//  Created by Jicell on 10/4/22.
//

import Foundation

class NearEarthObject {
    
    let name: String
    let designation: String
    let isWorldKiller: Bool
    
    // Memberwise initializer
    init(name: String, designation: String, isWorldKiller: Bool) {
        self.name = name
        self.designation = designation
        self.isWorldKiller = isWorldKiller
    }
    
  // Failable initializer
    init?(dictionary: [String:Any]) {
        guard let name = dictionary["name_limited"] as? String else {return nil}
        guard let designation = dictionary["designation"] as? String else {return nil}
        guard let isWorldKiller = dictionary["is_potentially_hazardous_asteroid"] as? Bool else {return nil}
        
        self.name = name
        self.designation = designation
        self.isWorldKiller = isWorldKiller
        
        
    }
    
}// End of class


/**
Example of what JSON looks like
 
  Example of what the JSON Object looks like
  { TLD
      "links": {
      },
      "page": {
      },
      "near_earth_objects": [
          { 0 - First
              "links": {
              },
              "id": "2000433",
              "neo_reference_id": "2000433",
              "name": "433 Eros (A898 PA)",
              "name_limited": "Eros",
              "designation": "433",
              "nasa_jpl_url": "s",
              "absolute_magnitude_h": 10.31,
              "estimated_diameter": {
              },
              "is_potentially_hazardous_asteroid": false,
              "close_approach_data": [
                  {
             },
  
  */
 
