//
//  Case8ViewModel.swift
//  Frank Case 8
//
//  Created by Chenguo Yan on 2020-07-07.
//  Copyright © 2020 Chenguo Yan. All rights reserved.
//

import Foundation

class Case8ViewModel {
    
    private var api: API
    private enum Constants {
        static let buildingDataUrl = "http://positioning-test.mapsted.com/api/Values/GetBuildingData/"
        static let analyticDataUrl = "http://positioning-test.mapsted.com/api/Values/GetAnalyticData/"
    }
    
    var finalResult = FinalResult()
    
//    var analyticDataArray = [AnalyticData]() {
//        didSet {
//            print("++++\(analyticDataArray.count)")
//            analyticDataArray.forEach { (analyticData) in
//                print("Total cost of \(analyticData.manufacturer): \(analyticData.totalCostOfManufacturer)")
//            }
//        }
//    }
//    var buildings = [Building]() {
//        didSet {
//            print("------\(buildings.count)")
//        }
//    }
    
    var flag: Int = 0 {
        didSet {
            if flag == 2 {
                print("Downloaded")
            }
        }
    }
    
    init(api: API) {
        self.api = api
    }
    
    func getData() {
        let downloadGroup = DispatchGroup()
        downloadGroup.enter()
        api.fetchData(with: Constants.buildingDataUrl) { (result: Result<[Building], Error>) in
            switch result {
            case .success(let dataList):
                self.finalResult.buildings.append(contentsOf: dataList)
                self.flag += 1
            case .failure(let error):
                print(error.localizedDescription)
            }
            downloadGroup.leave()
        }
        downloadGroup.enter()
        api.fetchData(with: Constants.analyticDataUrl) { (result: Result<[AnalyticData], Error>) in
            switch result {
            case .success(let dataList):
                self.finalResult.analyticDataArray.append(contentsOf: dataList)
                self.flag += 1
            case .failure(let error):
                print(error.localizedDescription)
            }
            downloadGroup.leave()
        }
        downloadGroup.wait()
        let cost = finalResult.totalCostByManufacturer(manufacturer: "Motorola")
        let costByCategory = finalResult.totalCostByCategory(categoryId: 6)
        let costByCountry = finalResult.totalCostByCountry(country: "United States")
        print(costByCountry)
        print(finalResult.totalCostByState(state: "Ontario"))
        print(finalResult.mostTotalPurchasesBuilding() ?? "n/a")
        print(finalResult.numberOfPurchase(itemId: 94))
        print("========================")
    }
    
    
}
