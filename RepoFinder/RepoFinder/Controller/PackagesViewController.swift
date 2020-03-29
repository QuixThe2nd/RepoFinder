//
//  PackagesViewController.swift
//  RepoFinder
//
//  Created by Jacob Singer on 2/24/20.
//  Copyright © 2020 RepoFinder Team. All rights reserved.
//

import UIKit
import Kingfisher

class PackagesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    let parseData = ParseData()
    
    var repoName: String = ""
    var repoURL: String = ""
    var repoIcon: UIImage = UIImage()
    let repoTableView = RepoTableView()
    var packagesArray: [Package] = [Package]()
    var packagesSet: [Package] = [Package]()
    var searchingPackagesSet: [Package] = [Package]()
    var packageName: String = ""
    let getPackages = GetPackages()
    var complete = false
    var searching = false
    var searchQuery = ""
    var depictionURL = ""
    var loading = true
    
    @IBOutlet weak var packageSearchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        //self.tableView.refreshControl = UIRefreshControl()
        //tableView.refreshControl?.beginRefreshing()
        navigationItem.title = repoName
        
        loading = true
        
        getTheDamnPackages(url: repoURL)
        tableView.reloadData()
        if loading {
            navigationItem.title = "Loading..."
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    func getTheDamnPackages(url: String) {
        
        UserDefaults.standard.set(url, forKey: "currentRepo")
        parseData.callToServerPackages { packages in
            
            
            self.packagesArray = packages
            
            
            self.packagesSet = Array(Set(self.packagesArray))
            
            self.packagesSet.sort{ $0.Name.lowercased() < $1.Name.lowercased() }
            self.tableView.reloadData()
            
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                            
                            //self.tableView.refreshControl?.endRefreshing()
                            self.loading = false
                            self.navigationItem.title = self.repoName
                        }
        }
        
//        var urlFull = url + "Packages.bz2"
//        getPackages.getPackages(urlString: urlFull) { packages in
//            self.packagesArray = packages
//            self.packagesSet = Array(Set(packages))
        self.packagesSet = self.packagesSet.filter{ !$0.Name.isEmpty }
//            //self.packagesSet = self.packagesSet.filter{ !$0.Depiction.isEmpty }
//            //self.packagesSet = self.packagesSet.filter{ !$0.Author.isEmpty }
//            //self.packagesSet = self.packagesSet.filter{ !$0.Description.isEmpty }

        
//
        //            DispatchQueue.main.async {
        //                self.tableView.reloadData()
        ////                self.tableView.refreshControl?.endRefreshing()
        //                self.loading = false
        //                self.navigationItem.title = self.repoName
        //            }
//        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searching {
            return self.searchingPackagesSet.count
        } else {
            return self.packagesSet.count
        }
        
    }
    
    @available(iOS 11.0, *)
       func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
           
           //let copySwipe = copySwipeAction(at: indexPath)
           let addRepoSwipe = addRepoSwipeAction(at: indexPath)
           
           return UISwipeActionsConfiguration(actions: [addRepoSwipe]) //put in array for other button
       }
       
//       @available(iOS 11.0, *)
//       func copySwipeAction(at indexPath: IndexPath) -> UIContextualAction {
//           let repo = repoArray[indexPath.row]
//           let action = UIContextualAction(style: .normal, title: "Copy") { (action, view, completion) in
//
//               //PUT CODE HERE FOR THIS BUTTON TO DO
//               if self.searching {
//                   print(self.searchRepoArray[indexPath.row].url!)
//                   self.pasteboard.string = self.searchRepoArray[indexPath.row].url
//                   completion(true)
//
//                   let message = "\(self.searchRepoArray[indexPath.row].url!) copied to the clipboard"
//                   let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
//                   self.present(alert, animated: true)
//
//                   // duration in seconds
//                   let duration: Double = 2
//
//                   DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration) {
//                       alert.dismiss(animated: true)
//                   }
//               }else{
//                   print(self.repoArray[indexPath.row].url!)
//                   self.pasteboard.string = self.repoArray[indexPath.row].url
//                   completion(true)
//
//                   let message = "\(self.repoArray[indexPath.row].url!) copied to the clipboard"
//                   let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
//                   self.present(alert, animated: true)
//
//                   // duration in seconds
//                   let duration: Double = 2
//
//                   DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration) {
//                       alert.dismiss(animated: true)
//                   }
//               }
//           }
//           action.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
//           if #available(iOS 13.0, *) {
//               action.image = UIImage(systemName: "doc.on.clipboard")
//           } else {
//               // Fallback on earlier versions
//           }
//           return action
//       }
       
       @available(iOS 11.0, *)
       func addRepoSwipeAction(at indexPath: IndexPath) -> UIContextualAction {
           let action = UIContextualAction(style: .normal, title: "Add") { (action, view, completion) in
               
               //PUT CODE HERE FOR THIS BUTTON TO DO
            if self.searching {
                self.packageName = self.searchingPackagesSet[indexPath.row].Name
                self.openInPM(packageID: self.searchingPackagesSet[indexPath.row].PackageId, repoURL: self.repoURL)
            } else {
                self.packageName = self.packagesSet[indexPath.row].Name
                self.openInPM(packageID: self.packagesSet[indexPath.row].PackageId, repoURL: self.repoURL)
            }
               completion(true)
           }
           action.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
           if #available(iOS 13.0, *) {
               action.image = UIImage(systemName: "paperplane.fill")
           } else {
               // Fallback on earlier versions
           }
           
           
           return action
       }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PackageCell", for: indexPath) as! PackageTableViewCell
        
        if searching {
            let name = self.searchingPackagesSet[indexPath.row].Name
            let description = self.searchingPackagesSet[indexPath.row].Description
            let author = self.searchingPackagesSet[indexPath.row].Author
            let iconURL = self.searchingPackagesSet[indexPath.row].Icon
            
            cell.packageName.text = name
            cell.packageDescription.text = description
            cell.packageAuthor.text = author
            cell.packageIcon.kf.setImage(with: URL(string: iconURL), placeholder: UIImage(imageLiteralResourceName: "RFIcon"))
            cell.packageIcon.layer.cornerRadius = 12
        } else {
            let name = self.packagesSet[indexPath.row].Name
            let description = self.packagesSet[indexPath.row].Description
            let author = self.packagesSet[indexPath.row].Author
            let iconURL = self.packagesSet[indexPath.row].Icon
            
            cell.packageName.text = name
            cell.packageDescription.text = description
            cell.packageAuthor.text = author
            cell.packageIcon.kf.setImage(with: URL(string: packagesSet[indexPath.row].Icon), placeholder: UIImage(imageLiteralResourceName: "RFIcon"))
            cell.packageIcon.layer.cornerRadius = 12
        }
       
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searching {
                depictionURL = searchingPackagesSet[indexPath.row].Depiction
            performSegue(withIdentifier: "packageToWeb", sender: self)
            } else {
            
            depictionURL = packagesSet[indexPath.row].Depiction
            performSegue(withIdentifier: "packageToWeb", sender: self)
            
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searching = true
        searchQuery = searchBar.text ?? ""
        print(searchQuery)
        searchingPackagesSet = packagesSet.filter({$0.Name.lowercased().prefix(searchQuery.count) == searchQuery.lowercased()})
        tableView.reloadData()
        if searchQuery == "" {
            searching = false
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "packageToWeb" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let controller = segue.destination as! WebViewController
                
                //PASS OVER VALUES
                controller.url = depictionURL
                
            }
        }
    }
    
    
    func openInPM(packageID: String, repoURL: String) {
        
        var openURL = ""
            
            var repoString = UserDefaults.standard.string(forKey: "pmURL")
            
            if repoString!.contains("cydia://url/https://cydia.saurik.com/api/share#?source=") {
                print("Cydia is selected")
                openURL = "cydia://package/\(packageID)"
                if let url = URL(string: openURL) {
                    UIApplication.shared.open(url)
                }
            } else if repoString!.contains("sileo://source/") {
                print("Sileo is selected")
                openURL = "sileo://package/\(packageID)"
                if let url = URL(string: openURL) {
                    UIApplication.shared.open(url)
                }
            }  else if repoString!.contains("zbra://sources/add/") {
                print("Zebra is selected")
                print(packageID)
                openURL = "zbra://packages/\(packageID)"
                if let url = URL(string: openURL) {
                    UIApplication.shared.open(url)
                }
            }  else if repoString!.contains("installer://add/repo=") {
                print("Installer is selected")
                openURL = "installer://show/shared=Installer&name=&bundleid=\(packageID)&repo=\(self.repoURL)"
                
                print(openURL)
                if let url = URL(string: openURL) {
                    UIApplication.shared.open(url)
                }
                
            }
        
    }
    
}

