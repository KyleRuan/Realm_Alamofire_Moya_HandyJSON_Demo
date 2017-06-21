//
//  DBMigrate.swift
//  Realm+Alamofire
//
//  Created by KyleRuan on 2017/6/17.
//  Copyright © 2017年 Kyleruan. All rights reserved.
//

import Foundation
import RealmSwift

//Example

//let config = Realm.Configuration(
//    schemaVersion: 5,
//    migrationBlock: { migration, oldSchemaVersion in
//        //增加或删除属性，Realm自动完成
//        if oldSchemaVersion < 1 {
//             //Person:add sex,title remove name
//        }
//
//        //增加属性并提供默认值
//        if oldSchemaVersion < 2 {
//            migration.enumerateObjects(ofType: Person.className()) { oldObject, newObject in
//                newObject!["email"] = ""
//            }
//        }
//
//        //重命名
//        if oldSchemaVersion < 3 {
//            migration.renameProperty(onType: Person.className(), from: "yearsSinceBirth", to: "age")
//        }
//
//        //合并
//        if oldSchemaVersion < 4 {
//            migration.enumerateObjects(ofType: Person.className()) { oldObject, newObject in
//                // combine name fields into a single field
//                let firstName = oldObject!["firstName"] as! String
//                let lastName = oldObject!["lastName"] as! String
//                newObject!["fullName"] = "\(firstName) \(lastName)"
//            }
//        }
//})

extension RealmDAO {
    
    static func migrationConfig() -> Realm.Configuration {
        let config = Realm.Configuration(
            schemaVersion: 250,
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < 250 {
                    
                }
        })
        return config
    }
    
}

