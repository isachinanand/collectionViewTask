//
//  ViewController.swift
//  CollectionViewTask
//
//  Created by Himanshu on 16/03/19.
//  Copyright © 2019 craterzone. All rights reserved.
//

import UIKit

class SearchScreen: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
    @IBOutlet weak var albumcollectionView: UICollectionView!
    @IBOutlet weak var mediaCollectionView: UICollectionView!
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.albumcollectionView {
            return 10 }
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == albumcollectionView{
            let albumCell: AlbumCell = collectionView.dequeueReusableCell(withReuseIdentifier: "album", for: indexPath) as! AlbumCell
            return albumCell
        }
        else {
            let mediaCell: MediaCell = collectionView.dequeueReusableCell(withReuseIdentifier: "media", for: indexPath) as! MediaCell
            return mediaCell
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
       albumcollectionView.register(UINib(nibName: "AlbumCell" , bundle: nil), forCellWithReuseIdentifier: "album")
        albumcollectionView.dataSource = self
        albumcollectionView.delegate = self
        mediaCollectionView.register(UINib(nibName: "MediaCell" , bundle: nil), forCellWithReuseIdentifier: "media")
        mediaCollectionView.dataSource = self
        mediaCollectionView.delegate = self
        
    }


}

