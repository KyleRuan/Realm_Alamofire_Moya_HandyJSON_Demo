//
//  APITest.swift
//  Realm+Alamofire
//
//  Created by KyleRuan on 2017/6/16.
//  Copyright © 2017年 Kyleruan. All rights reserved.
//

import Foundation
import Alamofire

protocol APIClientDelegate {
    func APIClientDidSuccessReceiveData(data:Any)
}

struct APIClient {
    var delegate:APIClientDelegate?
    
    init() {
        
    }
    
    func API()  {
        Alamofire.request("http://106.38.231.147/livechannel/classify/3/1.json").responseJSON { (respond) in
            self.delegate?.APIClientDidSuccessReceiveData(data: respond.value!)
        }
    }
}
