//
//  WesterosHouse.swift
//  Simple Rest Client
//
//  Created by Alvaro Morales on 8/25/17.
//  Copyright © 2017 Daniel Morales. All rights reserved.
//

import Foundation
import SwiftyJSON

struct WesterosHouse {
    let id : String
    let name : String
    let motto : String
    
    init(json: JSON) {
        id = json["id"].stringValue
        name = json["name"].stringValue
        motto = json["motto"].stringValue
    }
}

