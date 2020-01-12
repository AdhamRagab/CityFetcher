//
//  CityModel.swift
//  cityFetcher
//
//  Created by Adham Ragab on 1/11/20.
//  Copyright © 2020 pharos. All rights reserved.
//

import Foundation
import UIKit
import MapKit
class CityModel: Codable {
    
    var country: String?
    var name: String?
    private var _id: String?
    private var _coord: [String: String]?
    var id: String? {
        get {
            return self._id
        }
    }
    var coord : CLLocationCoordinate2D? {
        if let lat = _coord?["lat"], let lon = _coord?["lon"] {
            return CLLocationCoordinate2D(latitude: Double(lat) ?? 0, longitude: Double(lon) ?? 0)
        }
        return nil
    }
    
    
    
    enum CodingKeys: String, CodingKey {
        case _id
        case country
        case name
        case _coord = "coord"
    }
}

extension CityModel : Equatable {
    static func == (lhs: CityModel, rhs: CityModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    
}
