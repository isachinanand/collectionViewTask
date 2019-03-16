//
//  ViewController.swift
//  CollectionViewTask
//
//  Created by Himanshu on 16/03/19.
//  Copyright © 2019 craterzone. All rights reserved.
//

import UIKit
import Photos

class SearchScreen: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    var images = [PHAsset]()
    @IBOutlet weak var albumcollectionView: UICollectionView!
    @IBOutlet weak var mediaCollectionView: UICollectionView!
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.albumcollectionView {
            return 10 }
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == albumcollectionView{
            let albumCell: AlbumCell = collectionView.dequeueReusableCell(withReuseIdentifier: "album", for: indexPath) as! AlbumCell
            return albumCell
        }
        else {
            let mediaCell: MediaCell = collectionView.dequeueReusableCell(withReuseIdentifier: "media", for: indexPath) as! MediaCell
            let asset = images[indexPath.row]
            let manager = PHImageManager.default()
            if mediaCell.tag != 0 {
                manager.cancelImageRequest(PHImageRequestID(mediaCell.tag))
            }
            mediaCell.tag = Int(manager.requestImage(for: asset,
                                                targetSize: CGSize(width: 120.0, height: 120.0),
                                                contentMode: .aspectFill,
                                                options: nil) { (result, _) in
                                                    mediaCell.imageOfAlbum?.image = result
            })
            return mediaCell
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.getImages()
        
       albumcollectionView.register(UINib(nibName: "AlbumCell" , bundle: nil), forCellWithReuseIdentifier: "album")
        albumcollectionView.dataSource = self
        albumcollectionView.delegate = self
        mediaCollectionView.register(UINib(nibName: "MediaCell" , bundle: nil), forCellWithReuseIdentifier: "media")
        mediaCollectionView.dataSource = self
        mediaCollectionView.delegate = self
        
    }
    func getImages() {
        let assets = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: nil)
        assets.enumerateObjects({ (object, count, stop) in
            // self.cameraAssets.add(object)
            self.images.append(object)
        })
        
        //In order to get latest image first, we just reverse the array
        self.images.reverse()
        
        // To show photos, I have taken a UICollectionView
        self.mediaCollectionView.reloadData()
    }


}

