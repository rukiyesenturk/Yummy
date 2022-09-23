//
//  HomeFlowCell.swift
//  Yummy
//
//  Created by Rukiye Şentürk on 16.09.2022.
//

import UIKit

class HomeFlowCell: UICollectionViewCell {
    
    @IBOutlet weak var imgHomeFlow: UIImageView!
    func setup(_ slide: HomeFlow){
        imgHomeFlow.image = slide.image
    }
}
