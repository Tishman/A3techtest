//
//  dataService.swift
//  A3TechTest
//
//  Created by Роман Тищенко on 22/01/2019.
//  Copyright © 2019 Роман Тищенко. All rights reserved.
//

import Foundation

class DataService: DataServiceProtocol {
    
    private static let userURL = "https://jsonplaceholder.typicode.com/users"
    private static let albumURL = "https://jsonplaceholder.typicode.com/albums"
    private static let photoURL = "https://jsonplaceholder.typicode.com/photos"
    private static let localFailureMessage = "Something went wrong..."
    
    private init () {}
    
    static func getUsers(completionHandler: @escaping ((APIResult<[User]>) -> Void)) {
        guard let requestURL = URL(string: userURL) else { return }
        URLSession.shared.dataTask(with: requestURL) { (data, response, error) in
            do {
                guard let data = data else { return }
                let users = try JSONDecoder().decode([User].self, from: data)
                completionHandler(APIResult.SuсcesGetUsersRequest(users))
            } catch {
                completionHandler(APIResult.LocalFailure(localFailureMessage))
            }
        }.resume()
    }
    
    static func getUserAlbums(completionHandler: @escaping ((APIResult<[Album]>) -> Void)) {
        guard let requestURL = URL(string: albumURL) else { return }
        URLSession.shared.dataTask(with: requestURL) { (data, response, error) in
            do {
                guard let data = data else { return }
                let albums = try JSONDecoder().decode([Album].self, from: data)
                completionHandler(APIResult.SuccesGetAlbumsRequest(albums))
            } catch {
                completionHandler(APIResult.LocalFailure(localFailureMessage))
            }
        }.resume()
    }
    
    static func getUserPhotos(completionHandler: @escaping ((APIResult<[Photo]>) -> Void)) {
        guard let requestURL = URL(string: photoURL) else { return }
        URLSession.shared.dataTask(with: requestURL) { (data, response, error) in
            do {
                guard let data = data else { return }
                let photos = try JSONDecoder().decode([Photo].self, from: data)
                completionHandler(APIResult.SuccesGetPhotosRequest(photos))
            } catch {
                completionHandler(APIResult.LocalFailure(localFailureMessage))
            }
        }.resume()
    }
    
    static func getImageData(url: String) -> Data? {
        guard let requestURL = URL(string: url) else { return  nil}
        var imageData: Data?
        if let receivedImageData = try? Data(contentsOf: requestURL) {
            imageData = receivedImageData
        } else {
            imageData = nil
        }
        
        return imageData
    }
}
