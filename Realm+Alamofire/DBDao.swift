//
//  DBDao.swift
//  Realm+Alamofire
//
//  Created by KyleRuan on 2017/6/18.
//  Copyright © 2017年 Kyleruan. All rights reserved.
//

import Foundation

//dict的增删查找
protocol DBDAOProtocol {
    // MARK:==Creat==
   
    /// 根据表名创建DAO对象
    ///
    /// - Parameter tableName: 创建DAO对象的表名
//    init?(tableName: String);
    
    // MARK:==Query==
    /// 查询当前表下面所有数据
    ///
    /// - Returns: 查询结果列表
//    func query() -> [Any]?;
//    
//    /// 根据主键查询数据
//    ///
//    /// - Parameter primaryKey: 需要查询的数据主键
//    /// - Returns: 查询结果
//    func query(primaryKey: String) -> Dictionary<String, Any>?;
//    
//    /// 根据predicate查询数据
//    ///
//    /// - Parameter predicate: 需要查询的predicate
//    /// - Returns: 查询结果列表
//    func query(predicate: NSPredicate) -> [Any]?;
//    
//    /// 根据predicate查询数据
//    ///
//    /// - Parameters:
//    ///   - predicate: 需要查询的predicate
//    ///   - limit: 查询结果数量限制
//    /// - Returns: 查询结果列表
//    func query(predicate: NSPredicate, limit: Int) -> [Any]?;
//    
//    /// 查询当前表下面所有数据，并按sortDescriptors顺序返回
//    ///
//    /// - Parameter sortDescriptors: 查询结果的排序方法
//    /// - Returns: 查询结果列表
    func query(sortDescriptors: [NSSortDescriptor]) -> [Any]?;
//    
    /// 查询当前表下面所有数据，并按sortDescriptors顺序返回
    ///
    /// - Parameters:
    ///   - sortDescriptors: 查询结果的排序方法
    ///   - limit: 查询结果数量限制
    /// - Returns: 查询结果列表
    func query(sortDescriptors: [NSSortDescriptor], limit: Int) -> [Any]?;
//
//    
//    /// 根据predicate查询当前表下面所有数据，并按sortDescriptors顺序返回
//    ///
//    /// - Parameters:
//    ///   - predicate: 需要查询的predicate
//    ///   - sortDescriptors: 查询结果的排序方法
//    /// - Returns: 查询结果列表
//    func query(predicate: NSPredicate, sortDescriptors: [NSSortDescriptor]) -> [Any]?;
//    
//    /// 根据predicate查询当前表下面所有数据，并按sortDescriptors顺序返回
//    ///
//    /// - Parameters:
//    ///   - predicate: 需要查询的predicate
//    ///   - sortDescriptors: 查询结果的排序方法
//    ///   - limit: 查询结果数量限制
//    /// - Returns: 查询结果列表
//    func query(predicate: NSPredicate, sortDescriptors: [NSSortDescriptor], limit: Int) -> [Any]?;
//    
//    // MARK:==Insert==
//    
//    /// 向当前表插入数据
//    ///
//    /// - Parameter info: 需要插入的数据信息，必须包含主键数据，否则插入失败
//    func insert(info: Dictionary<String, Any>?);
//    
//    /// 向当前表插入数据列表
//    ///
//    /// - Parameter list: 需要插入的数据列表信息，每条数据必须包含主键数据，否则插入失败
    func insert(list: [Dictionary<String, Any>]?);
//
//    // MARK:==Update==
//    /// 根据primaryKey更新数据
//    ///
//    /// - Parameters:
//    ///   - primaryKey: 需要更新的数据主键
//    ///   - info: 需要更新的数据信息
//    func update(primaryKey: String?, info: Dictionary<String, Any>?);
//    
//    /// 根据predicate批量更新数据keyPath对应的属性
//    ///
//    /// - Parameters:
//    ///   - predicate: 需要更新的数据predicate
//    ///   - keyPath: 需要更新的属性keyPath
//    ///   - value: 需要更新的属性的值
//    func update(predicate: NSPredicate?, keyPath: String?, value: Any?);
//    
//    // MARK:==Delete==
//    /// 根据primaryKey删除记录
//    ///
//    /// - Parameter primaryKey: 需要删除记录的主键
//    func delete(primaryKey: String?);
//    
//    /// 根据predicate删除记录
//    ///
//    /// - Parameter predicate: 需要删除数据的predicate
//    func delete(predicate: NSPredicate?);
//    
//    /// 删除当前表下面的全部数据
//    func delete();

}
