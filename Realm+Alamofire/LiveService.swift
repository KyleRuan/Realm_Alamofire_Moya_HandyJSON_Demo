//
//  LiveService.swift
//  Realm+Alamofire
//
//  Created by KyleRuan on 2017/6/19.
//  Copyright © 2017年 Kyleruan. All rights reserved.
//

import Foundation
import HandyJSON

open class LiveService:BaseService {
    
    override func databaseTableName() -> String {
        return "Live"
    }
    override init() {
        super.init()
        dbDAO = RealmDao<Live>()

    }
    func fetchLives() -> Array<Live>?{
        let s = NSSortDescriptor(key: "order", ascending: true)
        
        guard let list = self.dbDAO.query(sortDescriptors: [s])  else{
            return nil
        }
        var result:Array<Live> = []
        for item in list {
            if let live = item as? NSDictionary {
                result.append(Live.deserialize(from: live)!)
            }
        }
        return result

    }
    
    func insertLive(list: [Dictionary<String, Any>]?) {
        self.dbDAO.insert(list: list)
    }
    
}
