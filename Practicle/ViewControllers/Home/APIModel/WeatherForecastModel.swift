//
//  WeatherForecastModel.swift
//  Practicle
//
//  Created by Pratima on 16/11/23.
//

import UIKit


enum WeatherForecastModel {
    struct Request {
        let cityName : String
        let days : Int = 7
        let aqi : String = "no"
        let alerts : String = "no"
    }
    
    class Response : WSResponseData {
        var searchedCity : String = ""
        var location : Location?
        var forecast : Forecast?
        
        enum CodingKeys: String, CodingKey {
            case location = "location"
            case forecast = "forecast"
        }
        
        required init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            try super.init(from: decoder)
            
            location = try values.decodeIfPresent(Location.self, forKey: .location)
            forecast = try values.decodeIfPresent(Forecast.self, forKey: .forecast)
        }
        
        override func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            
            try container.encode(location, forKey: .location)
            try container.encode(forecast, forKey: .forecast)
        }
        
        class Location: WSResponseData {
            var name : String?
            var region : String?
            var country : String?
            var lat : Double?
            var lon : Double?
            var tz_id : String?
            var localtime_epoch : Int?
            var localtime : String?
            
            
            enum CodingKeys: String, CodingKey {
                case name = "name"
                case region = "region"
                case country = "country"
                case lat = "lat"
                case lon = "lon"
                case tz_id = "tz_id"
                case localtime_epoch = "localtime_epoch"
                case localtime = "localtime"
                
            }
            
            required init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                try super.init(from: decoder)
                
                name = try values.decodeIfPresent(String.self, forKey: .name)
                region = try values.decodeIfPresent(String.self, forKey: .region)
                country = try values.decodeIfPresent(String.self, forKey: .country)
                lat = try values.decodeIfPresent(Double.self, forKey: .lat)
                lon = try values.decodeIfPresent(Double.self, forKey: .lon)
                tz_id = try values.decodeIfPresent(String.self, forKey: .tz_id)
                localtime_epoch = try values.decodeIfPresent(Int.self, forKey: .localtime_epoch)
                localtime = try values.decodeIfPresent(String.self, forKey: .localtime)
                
            }
            
            override func encode(to encoder: Encoder) throws {
                var container = encoder.container(keyedBy: CodingKeys.self)
                
                try container.encode(name, forKey: .name)
                try container.encode(region, forKey: .region)
                try container.encode(country, forKey: .country)
                try container.encode(lat, forKey: .lat)
                try container.encode(lon, forKey: .lon)
                try container.encode(tz_id, forKey: .tz_id)
                try container.encode(localtime_epoch, forKey: .localtime_epoch)
                try container.encode(localtime, forKey: .localtime)
            }
        }
        
        class Forecast: WSResponseData {
            var forecastday : [ForecastDay]?
            
            enum CodingKeys: String, CodingKey {
                case forecastday = "forecastday"
            }
            
            required init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                try super.init(from: decoder)
                
                forecastday = try values.decodeIfPresent([ForecastDay].self, forKey: .forecastday)
            }
            
            override func encode(to encoder: Encoder) throws {
                var container = encoder.container(keyedBy: CodingKeys.self)
                
                try container.encode(forecastday, forKey: .forecastday)
            }
            
            class ForecastDay: WSResponseData {
                var date : String?
                var day : Day?
                
                enum CodingKeys: String, CodingKey {
                    case date = "date"
                    case day = "day"
                }
                
                required init(from decoder: Decoder) throws {
                    let values = try decoder.container(keyedBy: CodingKeys.self)
                    try super.init(from: decoder)
                    
                    date = try values.decodeIfPresent(String.self, forKey: .date)
                    day = try values.decodeIfPresent(Day.self, forKey: .day)
                    
                }
                
                override func encode(to encoder: Encoder) throws {
                    var container = encoder.container(keyedBy: CodingKeys.self)
                    
                    try container.encode(date, forKey: .date)
                    try container.encode(day, forKey: .day)
                }
                
                
                class Day: WSResponseData {
                    var maxtemp_c : Double?
                    var mintemp_c : Double?
                    var condition : Condition?
                    
                    enum CodingKeys: String, CodingKey {
                        case maxtemp_c = "maxtemp_c"
                        case mintemp_c = "mintemp_c"
                        case condition = "condition"
                    }
                    
                    required init(from decoder: Decoder) throws {
                        let values = try decoder.container(keyedBy: CodingKeys.self)
                        try super.init(from: decoder)
                        
                        maxtemp_c = try values.decodeIfPresent(Double.self, forKey: .maxtemp_c)
                        mintemp_c = try values.decodeIfPresent(Double.self, forKey: .mintemp_c)
                        condition = try values.decodeIfPresent(Condition.self, forKey: .condition)
                    }
                    
                    override func encode(to encoder: Encoder) throws {
                        var container = encoder.container(keyedBy: CodingKeys.self)
                        
                        try container.encode(maxtemp_c, forKey: .maxtemp_c)
                        try container.encode(mintemp_c, forKey: .mintemp_c)
                        try container.encode(condition, forKey: .condition)
                    }
                    
                    class Condition: WSResponseData {
                        var text : String?
                        var icon : String?
                        var code : Int?
                        
                        enum CodingKeys: String, CodingKey {
                            case text = "text"
                            case icon = "icon"
                            case code = "code"
                        }
                        
                        required init(from decoder: Decoder) throws {
                            let values = try decoder.container(keyedBy: CodingKeys.self)
                            try super.init(from: decoder)
                            
                            text = try values.decodeIfPresent(String.self, forKey: .text)
                            icon = try values.decodeIfPresent(String.self, forKey: .icon)
                            code = try values.decodeIfPresent(Int.self, forKey: .code)
                        }
                        
                        override func encode(to encoder: Encoder) throws {
                            var container = encoder.container(keyedBy: CodingKeys.self)
                            
                            try container.encode(text, forKey: .text)
                            try container.encode(icon, forKey: .icon)
                            try container.encode(code, forKey: .code)
                        }
                    }
                }
            }
        }
    }
    
    class ErrorResponse : WSResponseData {
        var error : ErrorData?
        
        enum CodingKeys: String, CodingKey {
            case error = "error"
        }
        
        required init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            try super.init(from: decoder)
            
            error = try values.decodeIfPresent(ErrorData.self, forKey: .error)
        }
        
        override func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            
            try container.encode(error, forKey: .error)
        }
        
        class ErrorData : WSResponseData {
            var code : Int?
            var message : String?
            
            enum CodingKeys: String, CodingKey {
                case code = "code"
                case message = "message"
            }
            
            required init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                try super.init(from: decoder)
        
                code = try values.decodeIfPresent(Int.self, forKey: .code)
                message = try values.decodeIfPresent(String.self, forKey: .message)
            }
            
            override func encode(to encoder: Encoder) throws {
                var container = encoder.container(keyedBy: CodingKeys.self)
                
                try container.encode(code, forKey: .code)
                try container.encode(message, forKey: .message)
            }
            
        }
        
    }
}
