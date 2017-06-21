//
//  ViewController.swift
//  Realm+Alamofire
//
//  Created by KyleRuan on 2017/6/16.
//  Copyright © 2017年 Kyleruan. All rights reserved.
//

import UIKit
import Moya
import RealmSwift
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        let server = LiveService()
        server.fetchLives()
        classifyProvider.request(.getContent(category: 4, pageNo: 1)) { (result) in
            switch result {
            case let .success(moyaResponse):
                  let data = moyaResponse.data// Data, your JSON response
                  let datas = try! JSONSerialization.jsonObject(with: data, options: .allowFragments)
                  let arr:Dictionary<String,Any> = datas as! Dictionary<String, Any>
                  if let lives = arr["live_review"] as? [Dictionary<String, Any>] {
                    server.insertLive(list: lives)
                  }
            // query 查询操作 返回的是一个Result对象 都是懒加载，只有这个对象被使用的时候，才真正的被加载
            // 如果你修改了返回的结果，那么数据库里的数据相应的也被修改了（不是一份copy）
            
                // 1 查询
//                let dogs = realm.objects(Dog.self)
                
                  // 2用字符串
//                  var tanDogs = realm.objects(Dog.self).filter("color = 'tan' AND name BEGINSWITH 'B'")
                  
                  // 3 NSPredicate
//                  let predicate = NSPredicate(format: "color = %@ AND name BEGINSWITH %@", "tan", "B")
//                  tanDogs = realm.objects(Dog.self).filter(predicate)
                
                // 查询排序
//                let sortedDogs = realm.objects(Dog.self).filter("color = 'tan' AND name BEGINSWITH 'B'").sorted(byKeyPath: "name")
                // 连接两个查询操作
                  //                let tanDogs = realm.objects(Dog.self).filter("color = 'tan'")
//                  let tanDogsWithBNames = tanDogs.filter("name BEGINSWITH 'B'")
                
                // 4 Results
                // 假如说你查询了一个操作，这时候在某个线程，又向数据库插入了数据，这个时候你查询的结果，就可能变化（这个使realm更加的快速）
                
                // realm 是懒加载的，所以没有查询数量的限制，
                

                
            case let .failure(error):
                print(error)
            }
        }
    }


}

extension ViewController:APIClientDelegate {
    func APIClientDidSuccessReceiveData(data: Any) {
        print(data);
    }
}

