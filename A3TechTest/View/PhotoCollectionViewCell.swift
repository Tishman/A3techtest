//
//  PhotoCollectionViewCell.swift
//  A3TechTest
//
//  Created by Роман Тищенко on 22/01/2019.
//  Copyright © 2019 Роман Тищенко. All rights reserved.
//

import UIKit

var imageCache = NSCache<AnyObject, AnyObject>()

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var userPhoto: UIImageView!
    @IBOutlet weak var userTitle: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    func setUpCellStyle() {
        self.contentView.backgroundColor = UIColor.white
        self.contentView.layer.cornerRadius = 10
        self.contentView.layer.borderWidth = 1
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }
    
    func updateCell(photo: Photo) {
        if let image = imageCache.object(forKey: photo.url! as String as AnyObject) as? UIImage {
            userPhoto.image = image
            self.activityIndicator.stopAnimating()
        } else {
            DispatchQueue.global().async {
                guard let imageData = DataService.getImageData(url: photo.url!) else { return }
                guard let image = UIImage(data: imageData) else { return }
                imageCache.setObject(image, forKey: photo.url! as String as AnyObject)
                DispatchQueue.main.async {
                    self.userPhoto.image = image
                    self.activityIndicator.stopAnimating()
                }
            }
        }
        userTitle.text = photo.title
    }
    
}

