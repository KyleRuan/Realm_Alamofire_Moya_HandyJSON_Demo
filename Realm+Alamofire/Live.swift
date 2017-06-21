//
//  Live.swift
//  Realm+Alamofire
//
//  Created by KyleRuan on 2017/6/17.
//  Copyright © 2017年 Kyleruan. All rights reserved.
//

import Foundation
import RealmSwift
import HandyJSON


open class Live: HandyObject {
    
    dynamic var roomId = 0
    dynamic var sourceType = 0
    dynamic var mutilVideo = 0
    dynamic var pano = 0
    dynamic var userCount = 0
    dynamic var video = 0
    dynamic var type = 0
    dynamic var liveType = 0
    dynamic var confirm = 0
    dynamic var liveStatus = 0
    
    dynamic var roomName: String? = nil
    dynamic var image: String? = nil
    dynamic var startTime: String? = nil
    dynamic var endTime: String? = nil
    dynamic var source: String? = nil
    dynamic var userImg: String? = nil
    dynamic var userNickName: String? = nil
    dynamic var refreshId: String? = nil
    
    dynamic var match_infoData: NSData? = nil
    dynamic var sourceinfoData: NSData? = nil
    
    dynamic var order = 0
    dynamic var category = 0 
    
// LinkingObjects 设置了person的对象的dogs属性，相应的这Dog对象的owers属性就被设置为这个Person了
//    let owners = LinkingObjects(fromType: Person.self, property: "dogs")

    
    // 数字类型的optional属性 需要定义为RealmOptional  -->不过也可默认设置一个数
    //   let age = RealmOptional<Int>()
    

    override open class func primaryKey() -> String? {
        return "roomId"
    }
    
//    
//    // 经常需要被query的属性，写在这能加速查询速度
//    override static func indexedProperties() -> [String] {
//        return []
//    }
//    
//    // ignore properties
//    override static func ignoredProperties() -> [String] {
//        return ["match_infoData"]
//    }
    
    // realm 不推荐使用继承关系， 可以声明一个属性加到model中来
}

// Dict 转 model 和 model 转 dict 的操作
extension Live  {
    func mapping(mapper: HelpingMapper) {
     // 自定义方式
    }
}
