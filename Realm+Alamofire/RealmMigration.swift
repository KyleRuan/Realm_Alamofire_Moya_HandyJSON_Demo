//
//  RealmMigration.swift
//  Realm+Alamofire
//
//  Created by KyleRuan on 2017/6/18.
//  Copyright © 2017年 Kyleruan. All rights reserved.
//

import Foundation
import RealmSwift

extension RealmDao {
    public static func migrationConfig() -> Realm.Configuration {
        let config = Realm.Configuration(
            schemaVersion: 1,
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < 1 {
                    
                }
        })
        return config

    }
}
