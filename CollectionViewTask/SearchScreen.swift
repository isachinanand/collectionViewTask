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
    let albumList = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .albumRegular, options: nil)
    @IBOutlet weak var albumcollectionView: UICollectionView!
    @IBOutlet weak var mediaCollectionView: UICollectionView!
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.albumcollectionView {
            return albumList.count }
        return images.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == albumcollectionView{
            let albumCell: AlbumCell = collectionView.dequeueReusableCell(withReuseIdentifier: "album", for: indexPath) as! AlbumCell
            albumCell.albumTitle.text = albumList.object(at: indexPath.row).localizedTitle
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
           /*albumList.enumerateObjects { (coll, _, _) in
                let result = self.getAssets(fromCollection: coll)
                print("\(coll.localizedTitle): \(result.count)")
                let asset = result.object(at: indexPath.row)
                
                // get the "real" image
                PHCachingImageManager.default().requestImage(for: asset, targetSize: CGSize(width: 200, height: 200), contentMode: .aspectFill, options: nil) { (image, _) in
                    mediaCell.imageOfAlbum.image = image
                }
            } */
            return mediaCell
        }
        
    }
   /* func getAssets(fromCollection collection: PHAssetCollection) -> PHFetchResult<PHAsset> {
        let photosOptions = PHFetchOptions()
        photosOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        photosOptions.predicate = NSPredicate(format: "mediaType == %d", PHAssetMediaType.image.rawValue)
        
        return PHAsset.fetchAssets(in: collection, options: photosOptions)
    } */
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        /* if collectionView == albumcollectionView
         {
         self.getImages()
         } */
        
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
    // Below is the code i used to get data from gallery, it was successful but im commenting it to try other cases.
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
    /*private func setupPhotos() {
     let fetchOptions = PHFetchOptions()
     let smartAlbums = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .any, options: fetchOptions)
     let topLevelUserCollections = PHCollectionList.fetchTopLevelUserCollections(with: fetchOptions)
     let allAlbums = [topLevelUserCollections, smartAlbums]
     
     allAlbums.enumerateObjects {(assetCollection, index, stop) in
     
     if #available(iOS 9.0, *) {
     fetchOptions.fetchLimit = 1
     }
     
     let assets = PHAsset.fetchAssets(in: assetCollection, options: fetchOptions)
     if let _ = assets.firstObject {
     let assetObject = MYSpecialAssetContainerStruct(asset: assets)
     self.myDataArray.append(assetObject)
     }
     }
     self.myDataArray.sortInPlace {(a, b) in
     return a.asset.localizedTitle < b.asset.localizedTitle
     }
     albumcollectionView.reloadData()
     }*/
    
    
}

