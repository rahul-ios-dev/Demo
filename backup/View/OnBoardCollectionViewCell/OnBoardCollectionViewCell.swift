//
//  OnBoardCollectionViewCell.swift
//  backup
//
//  Created by Rahul Acharya on 29/11/24.
//

import UIKit

class OnBoardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var vwBG: UIView!
    @IBOutlet weak var profile: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var descri: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupConfig(with model: OnboardModel, index: Int) {
        profile.image = model.image
        title.text = model.title
        descri.text = model.description
        
        if index == 0 {
            vwBG.backgroundColor = ThemeColor.on1.getColor
        }else if index == 1 {
            vwBG.backgroundColor = ThemeColor.on2.getColor
        }else {
            vwBG.backgroundColor = ThemeColor.on3.getColor
        }
    }

}
