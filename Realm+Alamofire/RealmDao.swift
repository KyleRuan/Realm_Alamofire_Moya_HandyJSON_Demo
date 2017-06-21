//
//  RealmDao.swift
//  Realm+Alamofire
//
//  Created by KyleRuan on 2017/6/18.
//  Copyright © 2017年 Kyleruan. All rights reserved.
//

import Foundation
import RealmSwift
import HandyJSON


open class HandyObject: Object,HandyJSON {
    open func toDictionary() -> [String:Any] {
        let properties = self.objectSchema.properties.map { $0.name }
        let dictionary = self.dictionaryWithValues(forKeys: properties)
        return dictionary
    }
}

open class RealmDao<objectClass>: NSObject,DBDAOProtocol  where objectClass : HandyObject {
    
 
    
    public static func config() {
        var config = self.migrationConfig()
        
        if let realmPath = self.realmFilePath() {
            config.fileURL = realmPath.appendingPathComponent("Demo.realm")
        }
        Realm.Configuration.defaultConfiguration = config
    }

    
    public static func realmFilePath() -> URL? {
        let cache = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first!
        
        guard let cachePath = URL(string:cache) else {
            return nil
        }
        let realmPath = cachePath.appendingPathComponent("RealmDB");
        
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: realmPath.absoluteString) == false {
            try? fileManager.createDirectory( atPath: realmPath.absoluteString,
                                              withIntermediateDirectories: true,
                                              attributes: nil )
        }
        
        return realmPath

    }
    
   fileprivate func Realmquery(predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil, limit: Int? = nil) -> [Any]? {
        let realm = try! Realm()
        var result = realm.objects(objectClass.self)
        
        if let p = predicate {
            result = result.filter(p)
        }
    
        if let descriptors = sortDescriptors {
            var sorts = [SortDescriptor]()
            for s in descriptors {
                if let key = s.key {
                    sorts.append(SortDescriptor(keyPath: key, ascending: s.ascending))
                }
            }
            result = result.sorted(by: sorts)
        }
        
        var list = [Any]()
        
        var count = result.count
        if let _limit = limit, _limit != 0, _limit < count{
            count = _limit
        }
        let arr = Array(result[0..<count])
        for i in 0..<count {
         list.append(arr[i].toDictionary())
        }
        return list
    }
    
    /// - Returns: 查询结果列表
    func query() -> [Any]? {
        return  self.Realmquery()
    }
    
    /// 根据主键查询数据
    ///
    /// - Parameter primaryKey: 需要查询的数据主键
    /// - Returns: 查询结果
    func query(primaryKey: String) -> Dictionary<String, Any>?{
        let realm = try! Realm();
        if let object = realm.object(ofType: objectClass.self, forPrimaryKey: primaryKey) {
            if let info = object.toJSON()  {
                return info
            }
        }
        return nil
        
    }
    
    /// 根据predicate查询数据
    ///
    /// - Parameter predicate: 需要查询的predicate
    /// - Returns: 查询结果列表
    func query(predicate: NSPredicate) -> [Any]? {
        return self.Realmquery(predicate: predicate, sortDescriptors: nil, limit: nil)
    }
    
    /// 根据predicate查询数据
    ///
    /// - Parameters:
    ///   - predicate: 需要查询的predicate
    ///   - limit: 查询结果数量限制
    /// - Returns: 查询结果列表
    func query(predicate: NSPredicate, limit: Int) -> [Any]?{
        return self.Realmquery(predicate: predicate, sortDescriptors: nil, limit: limit)
    }
    
    /// 查询当前表下面所有数据，并按sortDescriptors顺序返回
    ///
    /// - Parameter sortDescriptors: 查询结果的排序方法
    /// - Returns: 查询结果列表
    func query(sortDescriptors: [NSSortDescriptor]) -> [Any]?{
        return self.Realmquery(predicate: nil, sortDescriptors: sortDescriptors, limit: nil)
    }
    
    /// 查询当前表下面所有数据，并按sortDescriptors顺序返回
    ///
    /// - Parameters:
    ///   - sortDescriptors: 查询结果的排序方法
    ///   - limit: 查询结果数量限制
    /// - Returns: 查询结果列表
    func query(sortDescriptors: [NSSortDescriptor], limit: Int) -> [Any]?{
        return self.Realmquery(predicate: nil, sortDescriptors: sortDescriptors, limit: nil)
    }
    
    
    /// 根据predicate查询当前表下面所有数据，并按sortDescriptors顺序返回
    ///
    /// - Parameters:
    ///   - predicate: 需要查询的predicate
    ///   - sortDescriptors: 查询结果的排序方法
    /// - Returns: 查询结果列表
    func query(predicate: NSPredicate, sortDescriptors: [NSSortDescriptor]) -> [Any]? {
        return self.Realmquery(predicate: predicate, sortDescriptors: sortDescriptors, limit: nil)
    }
    
    /// 根据predicate查询当前表下面所有数据，并按sortDescriptors顺序返回
    ///
    /// - Parameters:
    ///   - predicate: 需要查询的predicate
    ///   - sortDescriptors: 查询结果的排序方法
    ///   - limit: 查询结果数量限制
    /// - Returns: 查询结果列表
    func query(predicate: NSPredicate, sortDescriptors: [NSSortDescriptor], limit: Int) -> [Any]?{
        return self.Realmquery(predicate:predicate,sortDescriptors:sortDescriptors,limit:limit)
    }
    
    // MARK:==Insert==
    
    /// 向当前表插入数据
    ///
    /// - Parameter info: 需要插入的数据信息，必须包含主键数据，否则插入失败
    func insert(info: Dictionary<String, Any>?) {
        //
        if let i = info {
            self.insert(list: [i])
        }
        
    }
    
    /// 向当前表插入数据列表
    ///
    /// - Parameter list: 需要插入的数据列表信息，每条数据必须包含主键数据，否则插入失败
    func insert(list: [Dictionary<String, Any>]?) {
        guard let l = list else {
            return
        }
        let realm = try! Realm()
        try! realm.write {
            for info in l {
                guard let key = objectClass.primaryKey() else {
                    print("Insert failed,\(objectClass.self) not find primaryKey)")
                    continue
                }
                guard let primaryKey = info[key] else {
                    print("Insert failed,\(info) not find primaryKey \(key)")
                    continue
                }
                if let object = realm.object(ofType: objectClass.self, forPrimaryKey: primaryKey) {
                    
                    let  z = objectClass.deserialize(from: info as NSDictionary)
                    realm.add(z!, update: true)
                } else if let result = objectClass.deserialize(from: info as NSDictionary) {
                    realm.add(result, update:true)
                }
            }
        }
        
    }
    
    // MARK:==Update==
    /// 根据primaryKey更新数据
    ///
    /// - Parameters:
    ///   - primaryKey: 需要更新的数据主键
    ///   - info: 需要更新的数据信息
    func update(primaryKey: String?, info: Dictionary<String, Any>?) {
        guard let _primaryKey = primaryKey,let dic = info else {
            return
        }
        let realm = try! Realm()
        if let object = realm.object(ofType: objectClass.self, forPrimaryKey: _primaryKey) {
            try! realm.write {
                
                    let  z = objectClass.deserialize(from: dic as NSDictionary)
                    realm.add(z!, update: true)
            }
        }
        
        
    }
    
    /// 根据predicate批量更新数据keyPath对应的属性
    ///
    /// - Parameters:
    ///   - predicate: 需要更新的数据predicate
    ///   - keyPath: 需要更新的属性keyPath
    ///   - value: 需要更新的属性的值
    func update(predicate: NSPredicate?, keyPath: String?, value: Any?){
        guard let pre = predicate ,let key = keyPath  else {
            return
        }
        let realm = try! Realm()
        let result = realm.objects(objectClass).filter(pre)
        try! realm.write {
            for obj in result {
                obj[key] = value
            }
        }
        
    }
    
    // MARK:==Delete==
    /// 根据primaryKey删除记录
    ///
    /// - Parameter primaryKey: 需要删除记录的主键
    func delete(primaryKey: String?) {
        guard let _primaryKey = primaryKey else {
            return
        }
        let realm = try! Realm()
        if let result = realm.object(ofType: objectClass.self, forPrimaryKey: _primaryKey) {
            try! realm.write {
                realm.delete(result)
            }
        }
    }
    /// 根据predicate删除记录
    ///
    /// - Parameter predicate: 需要删除数据的predicate
    func delete(predicate: NSPredicate?){
        let realm = try! Realm()
        if let pre = predicate {
            let result = realm.objects(objectClass).filter(pre)
            try! realm.write {
                realm.delete(result)
            }
        }
    }
    
    /// 删除当前表下面的全部数据
    func delete() {
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
    }


}

