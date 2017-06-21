//
//  TestRealm.swift
//  Realm+Alamofire
//
//  Created by KyleRuan on 2017/6/20.
//  Copyright © 2017年 Kyleruan. All rights reserved.
//

import Quick
import Nimble
@testable import Realm_Alamofire


class TestRealm: QuickSpec {
    override func spec() {
        describe("RealmDao ") {
            it("can insert data") {
                let db = RealmDao<Live>()
                let data = db.query()
                
                if let count = data?.count {
                    expect(count).notTo(equal(0))
                    let data1 = data?[0] as! NSDictionary
                    let live = Live.deserialize(from: data1)
                    live?.roomId = 1314
                    db.insert(info: live?.toJSON())
                    let newdata = db.query()
                    expect(newdata?.count).to(equal(count+1))
                    // 查询
                    let newInsert = db.query(predicate: NSPredicate(format: "roomId == %d", (live?.roomId)!))
                    expect(newInsert?.count).to(equal(1))
                    
                }
                
               
            }
            
            
            

        }
    }
}
