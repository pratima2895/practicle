//
//  WeatherForcastAPIRouter.swift
//  Practicle
//
//  Created by Pratima on 16/11/23.
//

import UIKit

enum WeatherForcastAPIRouter: RouterProtocol {
    var baseUrlString: String {
        return BaseURL.url
    }
    
    case forcast(request:WeatherForecastModel.Request)
    
    var method: HTTPMethod {
        switch self {
        case .forcast:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .forcast:
            return EndPoint.kForcast.rawValue
        }
    }
    
    var parameters: [String: Any]? {
        var dictParam = [String: Any]()
        
        switch self {
        case .forcast(let request):
            dictParam = [
                "days" : "\(request.days)",
                "alerts" : request.alerts,
                "aqi" : request.aqi,
                "q" : request.cityName,
                "key" : WSConstants.APIKey,
            ]
        }
        
        return dictParam
    }
    
    var headers: [String : String]? {
        return nil
    }
}
