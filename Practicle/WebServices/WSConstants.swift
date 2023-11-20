//
//  WSConstants.swift
//  Practicle
//
//  Created by Pratima on 16/11/23.
//

import UIKit

let IS_STAGING_MODE : Bool = true
let DEBUG_PRINT : Bool = true

struct WSConstants {
    static let APIKey : String = "522db6a157a748e2996212343221502"
}

struct BaseURL {
    fileprivate static let kStaging : String = "https://api.weatherapi.com"
    fileprivate static let kProduction : String = "https://api.weatherapi.com"
    
    static var url : String {
        let baseURLString = IS_STAGING_MODE ? BaseURL.kStaging : BaseURL.kProduction
        let versioning = APIVersion.kV1
        
        return baseURLString + "/" + versioning.rawValue + "/"
    }
}

fileprivate enum APIVersion : String {
    case kV1 = "v1"
}

enum EndPoint : String {
    case kForcast = "forecast.json"
}
