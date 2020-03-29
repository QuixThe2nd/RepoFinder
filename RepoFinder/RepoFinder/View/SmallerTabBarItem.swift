//
//  SmallerTabBarItem.swift
//  RepoFinder
//
//  Created by Jamie Berghmans on 23/02/2020.
//  Copyright © 2020 RepoFinder Team. All rights reserved.
//

import UIKit

class SmallerTabBarItem: UITabBarItem {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        
        let image = self.image?.resizeImage(targetSize: CGSize(width: 25, height: 25))
        self.image = image;
    }
    
}
