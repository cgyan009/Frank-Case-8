//
//  Building.swift
//  Frank Case 8
//
//  Created by Chenguo Yan on 2020-07-07.
//  Copyright © 2020 Chenguo Yan. All rights reserved.
//

import Foundation

struct Building: Decodable {
    let buildingId: Int
    let buildingName: String
    let city: String
    let state: String
    let country: String
}
