//
//  RepoTableView.swift
//  RepoFinder
//
//  Created by Jacob Singer on 2/22/20.
//  Copyright © 2020 RepoFinder Team. All rights reserved.
//

import UIKit

class RepoTableView: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate  {
    
    @IBOutlet weak var repoSearchBar: UISearchBar!
    @IBOutlet weak var repoTableView: UITableView!
    let repoTableViewCell = RepoTableViewCell()
    var repoArray: [Repo] = [Repo]()
    var searchRepoArray: [Repo] = [Repo]()
    var searchRepoArrayLower: [Repo] = [Repo]()
    var packagesArray: [Package] = [Package]()
    let parseData = ParseData()
    let getPackages = GetPackages()
    var searching = false
    let pasteboard = UIPasteboard.general
    var titleName = ""
    let parseMoreRepos = ParseMoreRepos()
    
    //VALUES FROM TABLE INDEX
    var repoName: String = ""
    var repoURL: String = ""
    var repoIcon: UIImage = UIImage()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("test")
        
        repoTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let moreRepos = UserDefaults.standard.bool(forKey: "moreRepos")
        
        if moreRepos {
            
            parseMoreRepos.callToServerRepo { (Array) in
                self.repoArray = Array
                self.repoTableView.reloadData()
            }
            
        } else {
            print("searching old")
            //retrieve and parse data, after that reload table view
            parseData.callToServerRepo { (Array) in
                self.repoArray = Array
                self.repoTableView.reloadData()
            }
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let moreRepos = UserDefaults.standard.bool(forKey: "moreRepos")
        
        if moreRepos {
            
            parseMoreRepos.callToServerRepo { (Array) in
                self.repoArray = Array
                self.repoTableView.reloadData()
            }
            
        } else {
            print("searching old")
            //retrieve and parse data, after that reload table view
            parseData.callToServerRepo { (Array) in
                self.repoArray = Array
                self.repoTableView.reloadData()
            }
        }
    }
    
    @available(iOS 11.0, *)
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let copySwipe = copySwipeAction(at: indexPath)
        let addRepoSwipe = addRepoSwipeAction(at: indexPath)
        
        return UISwipeActionsConfiguration(actions: [addRepoSwipe, copySwipe]) //put in array for other button
    }
    
    @available(iOS 11.0, *)
    func copySwipeAction(at indexPath: IndexPath) -> UIContextualAction {
        let repo = repoArray[indexPath.row]
        let action = UIContextualAction(style: .normal, title: "Copy") { (action, view, completion) in
            
            //PUT CODE HERE FOR THIS BUTTON TO DO
            if self.searching {
                print(self.searchRepoArray[indexPath.row].url!)
                self.pasteboard.string = self.searchRepoArray[indexPath.row].url
                completion(true)
                
                let message = "\(self.searchRepoArray[indexPath.row].url!) copied to the clipboard"
                let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
                self.present(alert, animated: true)
                
                // duration in seconds
                let duration: Double = 2
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration) {
                    alert.dismiss(animated: true)
                }
            }else{
                print(self.repoArray[indexPath.row].url!)
                self.pasteboard.string = self.repoArray[indexPath.row].url
                completion(true)
                
                let message = "\(self.repoArray[indexPath.row].url!) copied to the clipboard"
                let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
                self.present(alert, animated: true)
                
                // duration in seconds
                let duration: Double = 2
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration) {
                    alert.dismiss(animated: true)
                }
            }
        }
        action.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        if #available(iOS 13.0, *) {
            action.image = UIImage(systemName: "doc.on.clipboard")
        } else {
            // Fallback on earlier versions
        }
        return action
    }
    
    
    
    @available(iOS 11.0, *)
    func addRepoSwipeAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "Add") { (action, view, completion) in
            
            if self.searching {
            //PUT CODE HERE FOR THIS BUTTON TO DO
                let pmString = UserDefaults.standard.string(forKey: "pmURL")
                let fullRepoURLString = pmString! + self.searchRepoArray[indexPath.row].url!
                let urlToOpen = URL(string: fullRepoURLString)
                UIApplication.shared.open(urlToOpen!)
            } else {
                let pmString = UserDefaults.standard.string(forKey: "pmURL")
                let fullRepoURLString = pmString! + self.repoArray[indexPath.row].url!
                let urlToOpen = URL(string: fullRepoURLString)
                UIApplication.shared.open(urlToOpen!)
            }
            
            completion(true)
        }
        action.backgroundColor = #colorLiteral(red: 0.4914485812, green: 0.5147647262, blue: 0.9991312623, alpha: 1)
        if #available(iOS 13.0, *) {
            action.image = UIImage(systemName: "paperplane.fill")
        } else {
            // Fallback on earlier versions
        }
        
        
        return action
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return searchRepoArray.count
        } else {
            return repoArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepoCell", for: indexPath) as! RepoTableViewCell
        
        if searching {
            let name = searchRepoArray[indexPath.row].name
            let url = searchRepoArray[indexPath.row].url
            cell.nameLabel.text = name
            cell.urlLabel.text = url
            cell.repoIcon.layer.cornerRadius = 12
            
            let iconString = (url!) + ("/CydiaIcon.png")
            let iconURL = URL(string: iconString)
            cell.repoIcon.kf.setImage(with: iconURL, placeholder: UIImage(imageLiteralResourceName: "RFIcon"))
            repoIcon = cell.repoIcon.image ?? UIImage(named: "RFIcon")!
            
        } else {
            
            let name = repoArray[indexPath.row].name
            let url = repoArray[indexPath.row].url
            cell.nameLabel.text = name
            cell.urlLabel.text = url
            cell.repoIcon.layer.cornerRadius = 12
            
            //load image
            let iconString = (url!) + ("/CydiaIcon.png")
            let iconURL = URL(string: iconString)
            cell.repoIcon.kf.setImage(with: iconURL, placeholder: UIImage(imageLiteralResourceName: "RFIcon"))
            repoIcon = cell.repoIcon.image ?? UIImage(named: "RFIcon")!
            
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searching {
            
            repoName = searchRepoArray[indexPath.row].name ?? "NO NAME"
            repoURL = searchRepoArray[indexPath.row].url ?? "NO URL"
            
            performSegue(withIdentifier: "showDetail", sender: self)
            
        } else {
            
            repoName = repoArray[indexPath.row].name ?? "NO NAME"
            repoURL = repoArray[indexPath.row].url ?? "NO URL"
            performSegue(withIdentifier: "showDetail", sender: self)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchRepoArray = repoArray.filter({$0.name!.lowercased().prefix(searchText.count) == searchText.lowercased()})
        searching = true
        repoTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        repoTableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let vc = segue.destination as? PackagesViewController {
                vc.packagesArray = self.packagesArray
                vc.repoName = self.repoName
                vc.repoURL = self.repoURL
                vc.repoIcon = self.repoIcon
            }
            
            //PASS OVER VALUES
            
            
            
        }
    }
}


