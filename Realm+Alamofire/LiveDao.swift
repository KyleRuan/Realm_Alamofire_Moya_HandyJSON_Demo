//
//  LiveDao.swift
//  Realm+Alamofire
//
//  Created by KyleRuan on 2017/6/17.
//  Copyright © 2017年 Kyleruan. All rights reserved.
//

import Foundation


// Live相关的存储

class LiveService {
    var dbDAO:DBDAOProtocol;
    func databaseTableName() -> String  {
        return "Live"
    }
   
    func fetchLives() ->Array<Live>  {
      let s = NSSortDescriptor(key: "order", ascending: true)
      let list = self.dbDAO.query(sortDescriptors: [s])  as! NSDictionary
        return [Live].deserialize(from: list)

    }
    func refreshLiveWithData(dataArray:NSArray) {
        let key = "key"
        
        self.dbDAO.insert(list: [key:dataArray])
    
    }
}






#pragma mark - Refresh

- (void)refreshLiveWithData:(NSArray *)dataArray offset:(NSInteger)offset{
    if (!verifiedNSArray(dataArray)) return;
    if (offset == 0)  [self clearAllLives];
    
    
    __block NSString *firstRefreshId = [NSString stringWithFormat:@"%.0f",[[NSDate date] timeIntervalSince1970]*1000];
    NSMutableArray *result = [NSMutableArray array];
    [dataArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
    
    NSNumber *roomId = validNumberValue(obj[@"roomId"]);
    
    if (!roomId) {
    return;
    }
    NSNumber *sourceType = validNumberValue(obj[@"sourceType"]);
    NSMutableDictionary *info = [obj mutableCopy];
    
    if (idx == 0 && verifiedString(info[@"refreshId"])) {
    firstRefreshId = info[@"refreshId"];
    }
    if (!info[@"refreshId"]) {
    info[@"refreshId"] = firstRefreshId;
    }
    [result addObject:[info copy]];
    }];
    
    [self.dbDAO insertWithList:[result copy]];
}

