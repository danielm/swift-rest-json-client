//
//  MyServices.swift
//  Simple Rest Client
//
//  Created by Alvaro Morales on 8/25/17.
//  Copyright © 2017 Daniel Morales. All rights reserved.
//

import Foundation
import TRON
import SwiftyJSON

struct MyServices {
    let tron = TRON(baseURL: "https://api.daniel.uy/api")

    static let singleton = MyServices()
    
    func fetchHouses(doneHandler: @escaping ([WesterosHouse]) -> Void) {
        let request: APIRequest<MyServicesJsonData, MyServicesJsonError> = tron.request("/asoiaf/houses")

        request.perform(withSuccess: { (housesData) in
            doneHandler(housesData.dataset)
        }) { (err) in
            print ("MyServices: Error fetching Houses", err)
        }
    }
    
    class MyServicesJsonError: JSONDecodable {
        required init(json: JSON) throws {
            throw NSError(domain: "com.danieluy.samples", code: 2,
                          userInfo: [NSLocalizedDescriptionKey: "MyServices: Failted to parse JSON."])
        }
    }
    
    class MyServicesJsonData: JSONDecodable {
        let status : String
        let message : String
        let dataset : [WesterosHouse]
        
        required init(json: JSON) throws {
            status = json["status"].stringValue
            message = json["message"].stringValue
            
            if (status == "KO") {
                throw NSError(domain: "com.danieluy.samples", code: 3,
                              userInfo: [NSLocalizedDescriptionKey: message])
            }
            
            guard let housesJsonArray = json["dataset"].array else {
                throw NSError(domain: "com.danieluy.samples", code: 3,
                              userInfo: [NSLocalizedDescriptionKey: "MyServices: Failed to parse Houses data."])
            }
            
            dataset = housesJsonArray.map{WesterosHouse(json: $0)}
        }
    }
}
