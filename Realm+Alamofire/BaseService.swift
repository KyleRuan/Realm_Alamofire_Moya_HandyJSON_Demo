//
//  BaseService.swift
//  Realm+Alamofire
//
//  Created by KyleRuan on 2017/6/19.
//  Copyright © 2017年 Kyleruan. All rights reserved.
//

import Foundation


open class BaseService: NSObject {
    var dbDAO:DBDAOProtocol!
    
    override init() {
        super.init()
               
    }
    func databaseTableName() ->String {
      return ""
    }
    
    func deleteAllData() {
    
    }
}
