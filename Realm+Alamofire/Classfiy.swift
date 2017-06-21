//
//  Classfiy.swift
//  Realm+Alamofire
//
//  Created by KyleRuan on 2017/6/16.
//  Copyright © 2017年 Kyleruan. All rights reserved.
//

import Foundation
import Moya

private func JSONResponseDataFormatter(_ data: Data) -> Data {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return prettyData
    } catch {
        return data // fallback to original data if it can't be serialized.
    }
}
let classifyProvider = MoyaProvider<Classify>(plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)])
enum Classify {
    case getContent(category: Int, pageNo:Int)
}

extension Classify:TargetType {
//    http://106.38.231.147/livechannel/classify/4/1.json
    public var baseURL: URL { return URL(string: "http://data.live.126.net/livechannel/classify")! }
    /// The path to be appended to `baseURL` to form the full `URL`.
    public var path: String {
        switch self {
        case .getContent(let category, let pageNo):
            return "\(category)/\(pageNo).json"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getContent:
            return .get
        }
    }

//    
//    /// The parameters to be encoded in the request.
    public var parameters: [String: Any]? {
        switch self {
        case .getContent :
            return nil
        }
    }
    
    public var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
//    
//    /// Provides stub data for use in testing.
    public var sampleData: Data {
        switch self {
        case .getContent:
            return Data()
        }
    }
//
//    /// The type of HTTP task to be performed.
        public var task: Task {
            return .request
        }

    
}
