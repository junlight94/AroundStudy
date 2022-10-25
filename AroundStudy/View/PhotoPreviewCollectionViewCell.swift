//
//  photoPreviewCollectionViewCell.swift
//  AroundStudy
//
//  Created by 박상현 on 2022/10/24.
//

import UIKit

class PhotoPreviewCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var previewImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        previewImageView.layer.cornerRadius = 12
    }
    
    func setImage(image: UIImage) {
        previewImageView.image = image
    }
}
