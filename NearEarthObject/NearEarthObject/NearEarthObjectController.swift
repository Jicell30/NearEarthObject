//
//  NearEarthObjectController.swift
//  NearEarthObject
//
//  Created by Jicell on 10/4/22.
//

import Foundation
class NearEarthObjectController {
    //SOT
    var neos: [NearEarthObject] = []
  private static let baseURLString = "https://api.nasa.gov/neo/rest/v1/"
    
    //keys
   private static let kNeoComponent = "neo"
    private static let kBrowseComponent = "browse"
    private static let kApiKeyKey = "api_key"
    private static let kAPIKeyValue = "4n60BKby49tKEuBuKpZvGUe4w4k0MRjci9ZTfhlg"
    
    // CRUD
    
    // We use a completion handeler to inform me when the fetch neos function has completed its task.
   static func fetchNeos(completionHandeler: @escaping ([NearEarthObject]?) -> Void) {
        
        //step 1: create the url
       guard let baseUrl = URL(string: baseURLString) else { completionHandeler(nil); return}
       let neoURL = baseUrl.appendingPathComponent(kNeoComponent)
       let browseUrl = neoURL.appendingPathComponent(kBrowseComponent)
       
       //to use URL query items you need a URLComponent struct
       var urlComponents = URLComponents(url: browseUrl, resolvingAgainstBaseURL: true)
       
        //step 2: create the data task to retrieve that data
        let apiQueryItem = URLQueryItem(name: kApiKeyKey, value: kAPIKeyValue)
       urlComponents?.queryItems? = [apiQueryItem]
       
       guard let finalURL = urlComponents?.url else {completionHandeler(nil); return}
       print(finalURL)
       
       //step 2: create the data task to retrieve that data
       URLSession.shared.dataTask(with: finalURL) { neoData, _, error in
           if let error = error {
               print("There was an error with the data task", error.localizedDescription)
               //  completionHandler(nil)
           }
           //check for data
           guard let data = neoData else {completionHandeler(nil); return}
           //Now that I have data i can convert that data into a JSON object
           do {
              guard let topLevelDictionary = try? JSONSerialization.jsonObject(with:data, options: .fragmentsAllowed) as? [String:Any],
                    let neosArray = topLevelDictionary["near_earth_objects"] as? [[String:Any]] else {
                  completionHandeler(nil); return}
               // create a temporary array to hold those neos
               var tempNeoArray: [NearEarthObject] = []
               
               for neoDict in neosArray {
                   guard let neo = NearEarthObject(dictionary: neoDict) else {completionHandeler(nil); return}
                   tempNeoArray.append(neo)
               }
               completionHandeler(tempNeoArray)
           }
       }
        //step 3:
    }
}// end of class.
