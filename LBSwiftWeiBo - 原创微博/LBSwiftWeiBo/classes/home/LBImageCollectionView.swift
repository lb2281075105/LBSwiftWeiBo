//
//  LBImageCollectionView.swift
//  LBSwiftWeiBo
//
//  Created by yunmei on 2017/12/18.
//  Copyright © 2017年 liubo. All rights reserved.
//

import UIKit

class LBImageCollectionView: UICollectionView {
    
    var picURLs : [NSURL] = [NSURL]() {
        didSet {
            self.reloadData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        dataSource = self
    }
}


extension LBImageCollectionView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return picURLs.count
    }
    
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LBImageCollectionCell", for: indexPath as IndexPath) as! LBImageCollectionCell
        
        cell.picURL = picURLs[indexPath.item]
        
        return cell
    }
}
class LBImageCollectionCell : UICollectionViewCell {

    var picURL : NSURL? {
        didSet {
            guard let picURL = picURL else {
                return
            }

            iconView.sd_setImage(with: picURL as URL, placeholderImage: UIImage(named: "empty_picture"))
        }
    }
    
    @IBOutlet weak var iconView: UIImageView!
}
