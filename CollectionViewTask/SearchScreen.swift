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
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let albumCell: AlbumCell = collectionView.dequeueReusableCell(withReuseIdentifier: "album", for: indexPath) as! AlbumCell
        return albumCell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
       albumcollectionView.register(UINib(nibName: "AlbumCell" , bundle: nil), forCellWithReuseIdentifier: "album")
        albumcollectionView.dataSource = self
        albumcollectionView.delegate = self
    }


}

