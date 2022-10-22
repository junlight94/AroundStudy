//
//  PhotoPickerCollectionViewCell.swift
//  AroundStudy
//
//  Created by 박상현 on 2022/10/21.
//

import UIKit

class PhotoPickerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var cameraIconImageView: UIImageView!
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var overlayView: UIView!
    
    var representedAssetIdentifier: String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setupCell(hideIcon: Bool = true, hideButton: Bool = false, selected: Bool = false) {
        /// 이미지 초기화
        photoImageView.image = nil
        cameraIconImageView.isHidden = hideIcon
        selectButton.isSelected = selected
        selectButton.isHidden = hideButton
        overlayView.isHidden = selected ? false : true
    }
    
    func selectCell(select: Bool) {
        selectButton.isSelected = select ? true : false
        overlayView.isHidden = select ? false : true
    }
    
    func setImage(image: UIImage?) {
        if let image = image {
            photoImageView.image = image
        }
    }
    
}
