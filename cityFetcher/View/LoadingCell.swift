//
//  LoadingCell.swift
//  cityFetcher
//
//  Created by Adham Ragab on 1/11/20.
//  Copyright © 2020 pharos. All rights reserved.
//

import UIKit

class LoadingCell: UITableViewCell {

    @IBOutlet var Spinner: UIActivityIndicatorView? = UIActivityIndicatorView()
    override func awakeFromNib() {
        super.awakeFromNib()
       
        Spinner?.center = self.contentView.center
        Spinner?.hidesWhenStopped = true
        Spinner?.style = UIActivityIndicatorView.Style.large
        self.contentView.addSubview(Spinner!)
        Spinner?.startAnimating()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
           
        // Configure the view for the selected state
    }
    
}
