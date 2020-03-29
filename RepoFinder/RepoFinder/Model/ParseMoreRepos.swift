//
//  ParseMoreRepos.swift
//  RepoFinder
//
//  Created by Jacob Singer on 2/26/20.
//  Copyright © 2020 RepoFinder Team. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class ParseMoreRepos {
    
    
        
        func callToServerRepo(completion: @escaping (Array<Repo>) -> Void) {
            URLCache.shared.removeAllCachedResponses()
            AF.request("https://iamparsa.com/api/apt_repos/output.sfdb", method: .post, encoding: JSONEncoding.default).responseJSON { response in
                if let data = response.data {
                    print("called to server!")
                    var repoArray : [Repo] = [Repo]()
                    
                    print(data)
                    
                    
                    repoArray = self.parseDataRepo(data: data)
                    print(repoArray)
                    
                    completion(repoArray)
                }
                
            }
            
        
        
    }
    
    func parseDataRepo(data: Data) -> Array<Repo> {
        
        var repoArray : [Repo] = [Repo]()
        
        let json = try! JSON(data: data)
        
        print(json)
        
        for (_, subJson) in json[] {
            
            var repo = Repo()
            
            if let name = subJson["name"].string {
                repo.name = name
            }
            if let url = subJson["url"].string {
                repo.url = url + "/"
            }
            
            print(repo)
            repoArray.append(repo)
        }
        
        
        //let repos = json["repos"] as [[String : String]]
        repoArray.sort{ $0.name!.lowercased() < $1.name!.lowercased() }
        
        return repoArray
        
        
    }
}
