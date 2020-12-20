//
//  VolumeResponse.swift
//  BookStore_Bruno
//
//  Created by BRUNO VASCONCELOS on 20/12/2020.
//

import Foundation
import ObjectMapper

class VolumeResponse: Mappable {
    
    var totalItems: Int!
    var items: [BookModel]?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        totalItems <- map["totalItems"]
        items <- map["items"]
    }
}

