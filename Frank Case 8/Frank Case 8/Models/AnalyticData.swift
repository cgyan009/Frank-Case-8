//
//  AnalyticData.swift
//  Frank Case 8
//
//  Created by Chenguo Yan on 2020-07-07.
//  Copyright © 2020 Chenguo Yan. All rights reserved.
//

import Foundation

struct AnalyticData: Decodable {
    let manufacturer: String
    let marketName: String
    let codename: String
    let model: String
    let usageStatistics: UsageStatistics
    var totalCost: Float {
        return usageStatistics.sumOfSession
    }
    func sumByCategory(categoryId: Int) -> Float {
        return usageStatistics.sessionInfos.map {$0.sumByCategory(categoryId: categoryId)}.reduce(0,+)
    }
    
    func sumByBuilding(buildingId: Int) -> Float {
        return usageStatistics.sessionInfos.filter {$0.buildingId == buildingId}.map {$0.sumByBuilding}.reduce(0, +)
    }
    
    func numberOfPurchase(itemId: Int) -> Int {
        var number = 0
        for sessionInfo in usageStatistics.sessionInfos {
            number += sessionInfo.numberOfPurchase(itemId: itemId)
        }
        return number
    }
    
}

struct UsageStatistics: Decodable {
    let sessionInfos: [SessionInfo]
    var sumOfSession: Float {
        return sessionInfos.map {$0.sumByBuilding}.reduce(0, +)
    }
    
}

struct SessionInfo: Decodable {
    let buildingId: Int
    let purchases: [Purchase]
    func sumByItem(itemId: Int) -> Float {
        return purchases.filter{$0.itemId == itemId}.map {$0.cost}.reduce(0, +)
    }
    func sumByCategory(categoryId: Int) -> Float {
        return purchases.filter({$0.itemCategoryId == categoryId}).map {$0.cost}.reduce(0, +)
    }
    var sumByBuilding: Float {
        return purchases.map {$0.cost}.reduce(0,+)
    }
    
    func numberOfPurchase(itemId: Int) -> Int {
        return purchases.filter{$0.itemId == itemId}.count
    }
}

struct Purchase: Decodable {
    let itemId: Int
    let itemCategoryId: Int
    let cost: Float
}
