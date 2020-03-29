//
//  PackageTableViewCell.swift
//  RepoFinder
//
//  Created by Jacob Singer on 2/24/20.
//  Copyright © 2020 RepoFinder Team. All rights reserved.
//

import UIKit

class PackageTableViewCell: UITableViewCell {

    @IBOutlet weak var packageIcon: UIImageView!
    @IBOutlet weak var packageName: UILabel!
    @IBOutlet weak var packageDescription: UILabel!
    @IBOutlet weak var packageAuthor: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
