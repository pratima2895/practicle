//
//  NetworkService.swift
//  Practicle
//
//  Created by Pratima on 16/11/23.
//

import UIKit

public protocol NetworkProtocol {
    static func dataGetRequest<Model: WSResponseData>(with inputRequest: RouterProtocol, completionHandler: @escaping (Model?, [Model]?, String?) -> Void)
}

final class NetworkService {
    private init() {}
}

extension NetworkService: NetworkProtocol {
    static func dataGetRequest<Model: WSResponseData>(with inputRequest: RouterProtocol, completionHandler: @escaping (Model?, [Model]?, String?) -> Void) {
        
        if DEBUG_PRINT {
            print("ROUTER BASE", inputRequest.baseUrlString)
            print("ROUTER PARAMETERS", inputRequest.parameters ?? [:])
            print("ROUTER PATH", inputRequest.path)
            print("ROUTER VERB", inputRequest.method)
            print("ROUTER HEADERS", inputRequest.headers as Any)
        }
        
//        let parameters = inputRequest.parameters?.json ?? ""
//        let postData = parameters.data(using: .utf8)
//
//        var request = URLRequest(url: URL(string: inputRequest.baseUrlString + inputRequest.path)!,timeoutInterval: Double.infinity)
//
//        if let headers = inputRequest.headers {
//            for key in Array(headers.keys) {
//                if let value = headers[key] {
//                    request.addValue(value, forHTTPHeaderField: key)
//                }
//            }
//        }
//
//        request.httpMethod = "POST"
//        request.httpBody = postData
        
        guard let request = try? inputRequest.asURLRequest() else {
            if DEBUG_PRINT {
                print("Invalid Request", inputRequest)
            }
            
            completionHandler(nil, nil, "Invalid Request")
            return;
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            print("Response =====> ", String(data: data ?? Data(), encoding: .utf8) as Any)
            DispatchQueue.main.async {
                guard error == nil else {
                    completionHandler(nil, nil, error?.localizedDescription ?? "Something went wrong")
                    return
                }
                
                guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                    if let data = data {
                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .formatted(DateFormatter.customFormat)
                        let decodedValueItem = try? decoder.decode(WeatherForecastModel.ErrorResponse.self, from: data)
                        completionHandler(nil, nil, decodedValueItem?.error?.message)
                    } else {
                        completionHandler(nil, nil, error?.localizedDescription ?? "Unknown Error")
                    }
                    
                    return
                }
                
                let finalResponseData: Data? = data
                
                if let data = finalResponseData {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .formatted(DateFormatter.customFormat)
                    let decodedValueItem = try? decoder.decode(Model.self, from: data)
                    let decodedValueArray = try? decoder.decode([Model].self, from: data)
                    
                    // Logout user automatically if He/She has activated session on another devicr7e
                    completionHandler(decodedValueItem, decodedValueArray, nil)
                } else {
                    completionHandler(nil, nil, error?.localizedDescription ?? "Network connection timeout")
                }
            }
        }

        task.resume()
    }
}

fileprivate extension DateFormatter {
    /// Get the Date formatter object
    static let customFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}

