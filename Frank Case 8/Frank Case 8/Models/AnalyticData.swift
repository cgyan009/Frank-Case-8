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
    
}

struct UsageStatistics: Decodable {
    let sessionInfos: [SessionInfo]
}

struct SessionInfo: Decodable {
    let buildingId: Int
    let purchases: [Purchase]
}

struct Purchase: Decodable {
    let itemId: Int
    let itemCategoryId: Int
    let cost: Float
}
