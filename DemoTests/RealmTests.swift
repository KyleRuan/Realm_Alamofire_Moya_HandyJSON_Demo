//
//  RealmTest.swift
//  Realm+Alamofire
//
//  Created by KyleRuan on 2017/6/21.
//  Copyright © 2017年 Kyleruan. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import Realm_Alamofire
@testable import HandyJSON


class RealmTests: QuickSpec {
    override func spec() {
        describe("RealmDao operation ") {
            var roomId:Int!
            it("can insert data") {
                let db = RealmDao<Live>()
                let data = db.query()
                
                if let count = data?.count {
                    expect(count).notTo(equal(0))
                    let data1 = data?[0] as! NSDictionary
                    let live = Live.deserialize(from: data1)
                    live?.roomId = (live?.roomId)!+1
                    db.insert(info: live?.toJSON())
                    let newdata = db.query()
                    expect(newdata?.count).to(equal(count+1))
                    let newInsert = db.query(predicate: NSPredicate(format: "roomId == %d", (live?.roomId)!))
                    expect(newInsert?.count).to(equal(1))
                    roomId = live?.roomId
                }
                
                
            }
            
            it("delete data in realm"){
                let db = RealmDao<Live>()
                if let count = db.query()?.count {
                     db.delete(predicate: NSPredicate(format: "roomId == %d", roomId))
                    if let afterDelete = db.query()?.count {
                        expect(afterDelete).to(equal(count-1))
                    }
                }
            }
            
            
        }
    }
}
