//
//  DataServiceProtocol.swift
//  A3TechTest
//
//  Created by Роман Тищенко on 22/01/2019.
//  Copyright © 2019 Роман Тищенко. All rights reserved.
//

import Foundation

enum APIResult<T: Decodable> {
    case SuсcesGetUsersRequest([User])
    case SuccesGetAlbumsRequest([Album])
    case SuccesGetPhotosRequest([Photo])
    case LocalFailure(String)
}

protocol DataServiceProtocol {
    
    static func getUsers(completionHandler: @escaping ((APIResult<[User]>) -> Void))
    
    static func getUserAlbums(completionHandler: @escaping ((APIResult<[Album]>) -> Void))
    
    static func getUserPhotos(completionHandler: @escaping ((APIResult<[Photo]>) -> Void))
    
    static func getImageData(url: String) -> Data?
}
