//
//  OnboardingCell.swift
//  Yummy
//
//  Created by Rukiye Şentürk on 15.09.2022.
//

import UIKit

class OnboardingCell: UICollectionViewCell {
    
    static let identifier = String(describing: OnboardingCell.self)

    @IBOutlet weak var imgSlide: UIImageView!
    @IBOutlet weak var lblSlideTiltle: UILabel!
    @IBOutlet weak var lblSlideDescription: UILabel!
        
    func setup(_ slide: OnboardingSlide) {
        imgSlide.image = slide.image
        lblSlideTiltle.text = slide.title
        lblSlideDescription.text = slide.desciption
    }
}
