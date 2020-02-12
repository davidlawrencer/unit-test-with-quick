//
//  MuseumItem.swift
//  unit-tests-with-quick
//
//  Created by David Rifkin on 2/11/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import Foundation


struct RijksmuseumResponse: Codable {
    let museumItems: [MuseumItem]

    static func decodeMuseumItemsFromData(from jsonData: Data) throws -> [MuseumItem] {
        let response = try JSONDecoder().decode(RijksmuseumResponse.self, from: jsonData)
        return response.museumItems
    }

    private enum CodingKeys: String, CodingKey {
        case museumItems = "artObjects"
    }
}

struct MuseumItem: Codable {
    //MARK: - Codable Properties
    private let longTitle: String
    private let objectNumber: String
    let principalOrFirstMaker: String
    let productionPlaces: [String]
    private let webImage: ItemImage?

    //MARK: - Favoritable Properties
    var id: String {
        return self.objectNumber
    }

    var photoUrl: String? {
        if let webImage = webImage {
            return webImage.url
        }
        return "No photo url"
    }

    var name: String {
        return self.longTitle
    }

    var details: String {
        if productionPlaces.count > 1 {
            return self.productionPlaces[0]
        }
        return "Place of production unknown"
    }

    var isEvent: Bool? {
        return false
    }

    var eventPrice: String? {
        return nil
    }

    var eventLink: String? {
        return nil
    }

    var isMuseumItem: Bool? {
        return true
    }
}

struct Link: Codable {
    let web: String
}

struct ItemImage: Codable {
    let url: String
}
