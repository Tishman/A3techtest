//
//  Photo.swift
//  A3TechTest
//
//  Created by Роман Тищенко on 22/01/2019.
//  Copyright © 2019 Роман Тищенко. All rights reserved.
//

import Foundation

struct Photo : Decodable {
    var albumId : Int?
    var id : Int?
    var title : String?
    var url : String?
}
