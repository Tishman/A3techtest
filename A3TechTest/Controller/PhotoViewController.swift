//
//  PhotoViewController.swift
//  A3TechTest
//
//  Created by Роман Тищенко on 22/01/2019.
//  Copyright © 2019 Роман Тищенко. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var userId: Int?
    private var albumDataList: [Album] = []
    private var photoDataList: [Photo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self

        getUserAlbumData()
    }
    
    private func getUserAlbumData () {
        DataService.getUserAlbums { (result) in
            switch result {
            case .SuccesGetAlbumsRequest(let albums):
                for album in albums {
                    if album.userId == self.userId {
                        self.albumDataList.append(album)
                    }
                }
                self.getUserPhotoData()
            case .LocalFailure(let message):
                self.showAlertMessage(message: message)
            default:
                print("Album: Switch default detected")
                break
            }
        }
        
    }
    
    private func getUserPhotoData () {
        DataService.getUserPhotos { (result) in
            switch result {
            case .SuccesGetPhotosRequest(let photos):
                for photo in photos {
                    for album in self.albumDataList {
                        if photo.albumId == album.id {
                            self.photoDataList.append(photo)
                            DispatchQueue.main.async {
                                self.collectionView.reloadData()
                            }
                        }
                    }
                }
            case .LocalFailure(let message):
                self.showAlertMessage(message: message)
            default:
                print("Photo: Switch default detected")
                break
            }
            
        }
    }
    
    private func showAlertMessage(message: String) {
        let infoAlert = UIAlertController(title: "Oops", message: message, preferredStyle: .alert)
        infoAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(infoAlert, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoDataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let photoCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell_ID", for: indexPath) as! PhotoCollectionViewCell
        photoCollectionViewCell.activityIndicator.hidesWhenStopped = true
        photoCollectionViewCell.activityIndicator.startAnimating()
        photoCollectionViewCell.setUpCellStyle()
        photoCollectionViewCell.updateCell(photo: photoDataList[indexPath.row])
        
        return photoCollectionViewCell
    }
}
