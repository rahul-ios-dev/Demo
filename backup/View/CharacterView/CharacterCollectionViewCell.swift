//
//  CharacterCollectionViewCell.swift
//  Demo
//
//  Created by Rahul Acharya on 22/10/24.
//

import UIKit
import Kingfisher

class CharacterCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var testttLabel: UILabel!
    @IBOutlet weak var testImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func getConfig(with name: String, image: String) {
        testttLabel.text = name
        guard let imageURL = URL(string: image) else { return }
        self.testImg.kf.setImage(with: imageURL)
        
        
//        CustomImageLoader.shared.downloadImage(imageURL) { [weak self] result in
//            guard let self = self else { return }
//            switch result {
//            case .success(let data):
//                DispatchQueue.main.async {
//                    self.testImg.image = UIImage(data: data)
//                }
//            case .failure(let error):
//                print("Error loading image: \(error)")
//            }
//        }
    }
}
