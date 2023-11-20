//
//  HomeViewModel.swift
//  Practicle
//
//  Created by Pratima on 18/11/23.
//

import UIKit

class HomeViewModel: NSObject {
    func callAPIForGetWathercastFor(city: String?, completion: @escaping(_ success: Bool, _ response: WeatherForecastModel.Response?, _ errorMessage: String?) -> Void) {
        let request = WeatherForecastModel.Request(
            cityName: city ?? ""
        )
        
        let apiRouter = WeatherForcastAPIRouter.forcast(request: request)
        self.WS_GetWeatherCast(withRouter: apiRouter) { success, response, message in
            if success == true {
                //Do further success operations
                response?.searchedCity = request.cityName
                completion(success, response, message)
            } else {
                //Do further failure operations
                completion(success, response, message)
            }
        }
    }
}

fileprivate extension HomeViewModel {
    func WS_GetWeatherCast(withRouter routerObject: WeatherForcastAPIRouter, completion: @escaping(_ success: Bool, _ response: WeatherForecastModel.Response?, _ message: String?) -> Void) {
        NetworkService.dataGetRequest(with: routerObject) { (responseItem: WeatherForecastModel.Response?, responseArray: [WeatherForecastModel.Response]?, error: String?) in
            DispatchQueue.main.async {
                if let detail = responseItem {
                    completion(true, detail, nil)
                } else if let detail = responseArray?.first{
                    completion(true, detail, nil)
                } else {
                    completion(false, nil, error)
                }
            }
        }
    }
}
