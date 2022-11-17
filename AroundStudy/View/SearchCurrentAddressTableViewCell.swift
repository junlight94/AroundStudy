//
//  SearchCurrentAddressTableViewCell.swift
//  AroundStudy
//
//  Created by coder3306 on 2022/11/16.
//

import UIKit

class SearchCurrentAddressTableViewCell: UITableViewCell {
    @IBOutlet weak var btnSearchCurrentLocation: UIButton?
    
    private var currentLocation: dataClosure?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        btnSearchCurrentLocation?.layer.setBorderLayout(radius: 8)
    }
    
    public func didUpdateCurrentLocation(_ complete: @escaping dataClosure) {
        self.currentLocation = complete
    }
    
    @IBAction private func actionSearchCurrentAddress(_ sender: UIButton) {
        LocationManager.shared.getReverseGeoCodeLocation { location in
            self.currentLocation?(location)
        }
    }
}

