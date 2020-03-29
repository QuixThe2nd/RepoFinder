//
//  getPackages.swift
//  RepoFinder
//
//  Created by Jacob Singer on 2/20/20.
//  Copyright © 2020 RepoFinder Team. All rights reserved.
//

import Foundation
import SWCompression
import Alamofire

class GetPackages {
    
    //let pattern = "(Package:)[^\n\r]+"
    let pattern = "\n\n"
    
    func getPackages(urlString: String, completion: @escaping(([Package]) -> Void)) {
        
        let url: URL = URL(string: urlString)!
        
        let task = URLSession.shared.downloadTask(with: url) { localURL, urlResponse, error in
            if let localURL = localURL {
                //DECOMPRESS THE BZIP2 AND PRINT THE AMOUNT OF BYTES
                let decompressedData = try? BZip2.decompress(data: Data(contentsOf: localURL))
                
                if let decompressedData = decompressedData {
                    let dataArray = decompressedData.split(separator: 0x000d)
                    var completeData = ""

                    for dataSlice in dataArray {
                        let data = String(bytes: dataSlice, encoding: .utf8)
                        if let data = data {
                            completeData += "\(data)\n"
                        }
                    }
                    
                    let packages = completeData.split(usingRegex: self.pattern)
                    
                    var finalPackages = [Package]()
                    
                    for pa in packages {
                        let package = Package()
                        finalPackages.append(package)
                        
                        for line in pa.split(separator: "\n") {
                            package.addData(data: String(line))
                        }
                    }
                    
                    completion(finalPackages)
                }
                /*if self.createFileAtPath(NSHomeDirectory(), contents: decompressedData as NSData?) {
                    print(decompressedData ?? 0)
                    print(localURL)
                    print("DONE")
                }*/
            }
        }
        
        task.resume()
    }
    
    func createFileAtPath(_ path: String,
                          contents data: NSData?) -> Bool {
        return true
    }
    
//    func readJSON(localURL: URL) -> String {
//        if let path = Bundle.main.path(forResource: "Packages", ofType: ""){
//            var data = Fi
//            var data = String(contentsOfFile:localURL, encoding: NSUTF8StringEncoding, error: Error)
//            if let content = (data){
//                TextView.text = content
//            }
//        }
        
        
}
