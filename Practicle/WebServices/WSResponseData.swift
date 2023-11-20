//
//  WSResponseData.swift
//  Practicle
//
//  Created by Pratima on 16/11/23.
//

import UIKit

public class WSResponseData: Codable {
    init() {
        
    }
    
    public func encode(to encoder: Encoder) throws {
        
    }
    
    required public init(from decoder: Decoder) throws {
        
    }
    
    func jsonDictionary() -> [String: AnyObject] {
        let encoder = JSONEncoder()
        let data = try? encoder.encode(self)
        let dictData = try? JSONSerialization.jsonObject(with: data ?? Data()) as? [String: AnyObject]
        return dictData ?? [:]
    }
}
