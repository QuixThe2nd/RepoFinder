//
//  ParseData.swift
//  RepoFinder
//
//  Created by Jacob Singer on 2/14/20.
//  Copyright © 2019 Jacob Singer. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class ParseData {

    //MARK: - JSON 1



//    func callToServerRepo(completion: @escaping (Array<Repo>) -> Void) {
//        AF.request("https://iamparsa.com/api/apt_popular_repos/output.sfdb").responseJSON { response in
//            if let data = response.data {
//                print("called to server!")
//                var repoArray : [Repo] = [Repo]()
//
//
//                 repoArray = self.parseDataRepo(dataJSON: data)
//                print(repoArray[1].name!)
//
//                completion(repoArray)
//            }
//
//        }
//
//
//
//}
//
//    func parseDataRepo(dataJSON: Data) -> Array<Repo> {
//
//        var repoArray : [Repo] = [Repo]()
//        let json = try! JSON(data: dataJSON)
//        for (_, subJson) in json{
//            let name = subJson["name"].stringValue
//            let url = subJson["url"].stringValue
//
//            let repo = Repo()
//            repo.name = name
//            repo.url = url
//            print(repo.name!)
//
//            repoArray.append(repo)
//
//        }
//        repoArray.sort{ $0.name!.lowercased() < $1.name!.lowercased() }
//
//        return repoArray
//
//
//    }
    
    func callToServerRepo(completion: @escaping (Array<Repo>) -> Void) {
        URLCache.shared.removeAllCachedResponses(); AF.request("https://iamparsa.com/api/apt_popular_repos/output.sfdb", method: .post, encoding: JSONEncoding.default).responseJSON { response in
                if let data = response.data {
                    print("called to server!")
                    var repoArray : [Repo] = [Repo]()


                     repoArray = self.parseDataRepo(dataJSON: data)

                    completion(repoArray)
                }

            }



    }

        func parseDataRepo(dataJSON: Data) -> Array<Repo> {

            var repoArray : [Repo] = [Repo]()
            let json = try! JSON(data: dataJSON)
            for (_, subJson) in json{
                let name = subJson["name"].stringValue
                let url = subJson["url"].stringValue

                let repo = Repo()
                repo.name = name
                repo.url = url
                print(repo.name!)

                repoArray.append(repo)

            }
            repoArray.sort{ $0.name!.lowercased() < $1.name!.lowercased() }

            return repoArray


        }
    
    

//    func callToServerTweak(completion: @escaping (Array<Tweak>) -> Void) {
//        AF.request("http://api.ios-repo-updates.com/1.0/search-json/?getPackage=true&s=\(UserDefaults.standard.string(forKey: "tweakQuery")!)&getRepoURLs=true").responseJSON { response in
//                if let data = response.data {
//                    print("called to server!")
//                    var tweakArray : [Tweak] = [Tweak]()
//
//                    //http://api.ios-repo-updates.com/1.0/
//                     tweakArray = self.parseDataTweak(dataJSON: data)
//
//                    if 1 > tweakArray.count{
//                    print(tweakArray[0].name)
//                    }
//
//                    completion(tweakArray)
//                }
//
//            }
//
//
//
//    }
//
//        func parseDataTweak(dataJSON: Data) -> Array<Tweak> {
//
//            var tweakArray : [Tweak] = [Tweak]()
//            let json = try! JSON(data: dataJSON)
//            for (_, subJson) in json{
//                let name = subJson["name"].stringValue
//                let repo = subJson["repoURLs"][0].stringValue
//
//                let tweak = Tweak()
//                tweak.name = name
//                tweak.repo = repo
//                print(tweak.name)
//
//                tweakArray.append(tweak)
//
//            }
//
//            tweakArray.sort{ $0.name.lowercased() < $1.name.lowercased() }
//
//            return tweakArray
//
//        }
    
    func callToServerPackages(completion: @escaping (Array<Package>) -> Void) {
        
        let url = UserDefaults.standard.string(forKey: "currentRepo")?.dropLast()
        AF.request("https://iamparsa.com/api/apt_repo_packages/output.php?repo=\(url!)").responseJSON { response in
                if let data = response.data {
                    print("called to server!")
                    var packageArray : [Package] = [Package]()
                    print("https://iamparsa.com/api/apt_repo_packages/output.php?repo=\(url!)")

                     packageArray = self.parseDataPackages(dataJSON: data)
                    
                    

                    completion(packageArray)
                }

            }

            

    }

        func parseDataPackages(dataJSON: Data) -> Array<Package> {

            var packageArray : [Package] = [Package]()
            let json = try! JSON(data: dataJSON)
            for (_, subJson) in json{
                let name = subJson["name"].stringValue
                let icon = subJson["icon"].stringValue
                let maintainer = subJson["maintainer"].stringValue
                let dependencies = subJson["dependencies"].stringValue
                let packageID = subJson["package_id"].stringValue
                let version = subJson["version"].stringValue
                let depiction = subJson["depiction"].stringValue
                let author = subJson["author"].stringValue
                let description = subJson["description"].stringValue

                let package = Package()
                package.Name = name
                package.Icon = icon
                package.Maintainer = maintainer
                package.Dependencies = dependencies
                package.PackageId = packageID
                package.Version = version
                package.Depiction = depiction
                package.Author = author
                package.Description = description
                
                
                
                print(package.Name)
                
                packageArray.append(package)

            }
            
            packageArray.sort{ $0.Name.lowercased() < $1.Name.lowercased() }
            
            return packageArray

        }
    
}


