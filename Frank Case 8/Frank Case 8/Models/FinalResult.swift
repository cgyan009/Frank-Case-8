//
//  FinalResult.swift
//  Frank Case 8
//
//  Created by Chenguo Yan on 2020-07-07.
//  Copyright © 2020 Chenguo Yan. All rights reserved.
//

import Foundation

struct FinalResult {
    var countries = Set<String>()
    var states = Set<String>()
    var itemIds = Set<Int>()
    var manufactures = Set<String>()
    var categoryIds = Set<Int>()
    var buildingIds = Set<Int>()
    var analyticDataArray = [AnalyticData]() {
        didSet {
            print("count of data array: \(analyticDataArray.count)")
            for data in analyticDataArray {
                manufactures.insert(data.manufacturer)
                for sessionInfo in data.usageStatistics.sessionInfos {
                    buildingIds.insert(sessionInfo.buildingId)
                    for purchase in sessionInfo.purchases {
                        categoryIds.insert(purchase.itemCategoryId)
                        itemIds.insert(purchase.itemId)
                    }
                }
            }
        }
    }
    var buildings = [Building]() {
        didSet {
            for building in buildings {
                countries.insert(building.country)
                states.insert(building.state)
            }
        }
    }
    func totalCostByManufacturer(manufacturer: String) -> Float {
        return analyticDataArray.filter { $0.manufacturer == manufacturer }.map {$0.totalCost}.reduce(0, +)
    }
    func totalCostByCategory(categoryId: Int) -> Float {
        return analyticDataArray.map {$0.sumByCategory(categoryId: categoryId)}.reduce(0,+)
    }
    func totalCostByCountry(country: String) -> Float {
        let buildingsOfCountry = buildings.filter {$0.country == country}
        let buildingIdsOfCountry = buildingIds.filter {buildingsOfCountry.map {$0.buildingId}.contains($0)}
        var sum: Float = 0.0
        for id in buildingIdsOfCountry {
            for analyticData in analyticDataArray {
                sum += analyticData.sumByBuilding(buildingId: id)
            }
        }
        return sum
    }
    
    func totalCostByState(state: String) -> Float {
        let buildingsOfState = buildings.filter {$0.state == state}
        let buildingIdsOfState = buildingIds.filter{buildingsOfState.map{$0.buildingId}.contains($0)}
        var sum: Float = 0
        for id in buildingIdsOfState {
            for analyticData in analyticDataArray {
                sum += analyticData.sumByBuilding(buildingId: id)
            }
        }
        return sum
    }
    
    func mostTotalPurchasesBuilding() -> String? {
        var totalPurchaseOfBuilding = [Int: Float]()
        for id in buildingIds {
            var sum: Float = 0
            for analyticData in analyticDataArray {
                sum += analyticData.sumByBuilding(buildingId: id)
            }
            totalPurchaseOfBuilding[id] = sum
        }
        let buildingId = totalPurchaseOfBuilding.sorted{$0.value > $1.value}.first?.key
        let bilding = buildings.first { $0.buildingId == buildingId}
        return bilding?.buildingName
    }
    func numberOfPurchase(itemId: Int) -> Int {
        var number = 0
        for analyticData in analyticDataArray {
            number += analyticData.numberOfPurchase(itemId: itemId)
        }
        return number
    }
    
}
