//
//  APIRouterProtocol.swift
//  Practicle
//
//  Created by Pratima on 16/11/23.
//

import UIKit

class APIRouterProtocol: NSObject {

}

public enum HTTPMethod : String {
    case get = "GET"
    case post = "POST"
}

/// Router Protocol default for whole app
public protocol RouterProtocol {
    /// HTTP Method
    var method: HTTPMethod { get }
    
    /// Base URL String to call API
    var baseUrlString: String { get }
    
    /// Path for api
    var path: String { get }
    
    /// Parameters for API
    var parameters: [String: Any]? { get }
    
    var headers: [String: String]? { get }
}

// MARK: - URL Request Extension
public extension RouterProtocol {
    /// get URL Request
    ///
    /// - Returns: return urls request object
    /// - Throws: throws exception if any error
    func asURLRequest() throws -> URLRequest {
        guard let url = URL(string: self.baseUrlString) else {
            throw(NSError(domain: "Unable to create url", code: 0))
        }

        let finalPath = path.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? path.replacingOccurrences(of: " ", with: "%20")
        
        var newURL = (finalPath.contains("http://") || finalPath.contains("https://")) ? URL(string: finalPath)! : url.appendingPathComponent(finalPath)
        
        if method == .get {
            var urlComponents = URLComponents(url: newURL, resolvingAgainstBaseURL: false)

            let queryItems = parameters?.map({ (key: String, value: Any) in URLQueryItem(name: key, value: value as? String)})
            urlComponents?.queryItems = queryItems
            newURL = urlComponents?.url ?? url
        }
        
        
        var request = URLRequest(url: newURL)
        
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = self.headers
        request.timeoutInterval = 600
        
        if method == .post {
            let paramData = try JSONSerialization.data(withJSONObject: self.parameters as Any, options: .fragmentsAllowed)
            request.httpBody = paramData
        }
    
        return request
    }
    /// Array of parameters
    var arrayParameters: [Any]? {
        return nil
    }
}
