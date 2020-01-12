//
//  MapTableViewCell.swift
//  cityFetcher
//
//  Created by MacBook Pro on 1/12/20.
//  Copyright © 2020 pharos. All rights reserved.
//

import UIKit
import MapKit

class MapTableViewCell: UITableViewCell {
    @IBOutlet var CityMap: MKMapView!
    @IBOutlet var CityLabel: UILabel!
    
    @IBOutlet var CountryLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
