//
//  Album.swift
//  CollectionViewTask
//
//  Created by Himanshu on 16/03/19.
//  Copyright © 2019 craterzone. All rights reserved.
//

import UIKit
import Photos
import Foundation
class AlbumModel {
    let name:String
    let count:Int
    let collection:PHAssetCollection
    init(name:String, count:Int, collection:PHAssetCollection) {
        self.name = name
        self.count = count
        self.collection = collection
    }
}

func listAlbums() {
    var album:[AlbumModel] = [AlbumModel]()
    print(album[0].name)
    print(album[1].name)
    
    let options = PHFetchOptions()
    let userAlbums = PHAssetCollection.fetchAssetCollections(with: PHAssetCollectionType.album, subtype: PHAssetCollectionSubtype.any, options: options)
    userAlbums.enumerateObjects{ (object: AnyObject!, count: Int, stop: UnsafeMutablePointer) in
        if object is PHAssetCollection {
            let obj:PHAssetCollection = object as! PHAssetCollection
            
            let fetchOptions = PHFetchOptions()
            fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
            fetchOptions.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.image.rawValue)
            
            let newAlbum = AlbumModel(name: obj.localizedTitle!, count: obj.estimatedAssetCount, collection:obj)
            album.append(newAlbum)
        }
    }
    
    for item in album {
        print(item)
    }
}

