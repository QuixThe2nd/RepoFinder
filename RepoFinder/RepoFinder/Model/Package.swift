//
//  Package.swift
//  RepoFinder
//
//  Created by Jacob Singer on 2/16/20.
//  Copyright © 2020 RepoFinder Team. All rights reserved.
//

import Foundation

class Package: Hashable {
    static var lastKey = ""
    
    var PackageId: String = ""
    var Name: String = ""
    var Description: String = ""
    var Maintainer: String = ""
    var Author: String = ""
    var Version: String = ""
    var Section: String = ""
    var Depiction: String = ""
    var Icon: String = ""
    var Dependencies: String = ""
    
    func addData(data: String?) {
        if let data = data, !data.isEmpty {
            
            var key = ""
            var value = ""
            
            if (data.contains(": ")) {
                let split = data.split(separator: ":", maxSplits: 1)
                key = split[0].trimmingCharacters(in: .whitespacesAndNewlines)
                value = split[1].trimmingCharacters(in: .whitespacesAndNewlines)
            } else {
                key = Package.lastKey
                value = data
            }
            
            Package.lastKey = key
            
            switch key {
                case "Package":
                    PackageId = value
                    break
                case "Version":
                    Version = value
                    break
                case "Maintainer":
                    Maintainer = value
                    break
                case "Section":
                    Section = value
                    break
                case "Description":
                    Description += value
                    break
                case "Author":
                    Author = value
                    break
                case "Name":
                    Name = value
                    break
                case "Depiction":
                    Depiction = value
                    break
                case "Icon":
                    Icon = value
                    break
                default:
                    return
            }
        }
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(PackageId)
    }
    
    static func == (lhs: Package, rhs: Package) -> Bool {
        return lhs.PackageId == rhs.PackageId
    }
}
