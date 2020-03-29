//
//  ColorNavBarHeader.swift
//  RepoFinder
//
//  Created by Jamie Berghmans on 23/02/2020.
//  Copyright © 2020 RepoFinder Team. All rights reserved.
//

import UIKit

class ColorNavBarHeader: UINavigationBar {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.titleTextAttributes = [.foregroundColor: UIColor(named: "RFpurple")]
        self.largeTitleTextAttributes = [.foregroundColor: UIColor(named: "RFpurple")]
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
