//
//  contactsData.swift
//  Unit 3 HW - Parsing JSON
//
//  Created by C4Q on 11/17/17.
//  Copyright © 2017 Quark. All rights reserved.
//

import Foundation
struct Results: Codable{
    var results: [Contact]
}
struct Contact: Codable {
    var gender: String
    var name: NameWraper
    var location: LocationWraper
    var email: String?
    var picture: PictureWrapper?
    var phone: String?
    var cell: String?
}
struct NameWraper:Codable {
    var title: String?
    var first: String
    var last: String?
}
struct LocationWraper: Codable {
    var street: String
    var city: String
    var state: String
}
struct PictureWrapper: Codable {
    var large: String
    var medium: String
    var thumbnail: String
    var thumbnailToData: Data{
        let myUrl = URL(string: thumbnail)
        let  data = try! Data(contentsOf: myUrl!)
        return data
    }
    var largToData: Data{
        let myUrl = URL(string: large)
        let  data = try! Data(contentsOf: myUrl!)
        return data
    }
    
}
