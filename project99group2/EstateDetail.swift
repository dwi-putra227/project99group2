//
//  EstateDetail.swift
//  project99group2
//
//  Created by Putra  on 07/11/24.
//

import Foundation

struct EstateDetail: Decodable {
    let address: Address
    let attributes: Attributes
    let description: String?
    let id: Int?
    let photo: String?
    let projectName: String?
    let propertyDetails: [PropertyDetail]?
    
    struct PropertyDetail: Decodable {
        let label: String?
        let text: String?
    }
    
    struct Address: Decodable {
        struct MapCoordinates: Decodable {
            let lat: Double?
            let lng: Double?
        }
        let mapCoordinates: MapCoordinates?
        let subtitle: String?
        let title: String?
    }
    
    struct Attributes: Decodable {
        let areaSize: Int?
        let bathrooms: Int?
        let bedrooms: Int?
        let price: Int?
    }
    
}
