//
//  Estate.swift
//  project99group2
//
//  Created by Putra  on 05/11/24.
//

import Foundation

struct Estate : Decodable {
    let id : Int?
    var projectName: String?
    let category: String?
    let photo: String
    let completedAt: String?
    let tenure: Int?
    let address: Address
    let attributes: Attributes
}

struct Address: Decodable{
    let district: String?
    let streetName: String?
}

struct Attributes: Decodable {
    let areaSize: Int?
    let bathrooms: Int?
    let bedrooms: Int?
    let price: Int?
}
