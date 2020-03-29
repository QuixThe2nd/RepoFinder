//
//  SettingsViewController.swift
//  RepoFinder
//
//  Created by Jacob Singer on 2/14/20.
//  Copyright © 2020 RepoFinder Team. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    
    @IBOutlet weak var pmSegmentedControl: UISegmentedControl!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var creditsStack: UIStackView!
    
    
    var segmentIndex = 0
    @IBOutlet weak var moreReposSwitch: UISwitch!
    
    
    override func viewDidLoad() {
        
        var repoString = UserDefaults.standard.string(forKey: "pmURL")
        
        if repoString!.contains("cydia://url/https://cydia.saurik.com/api/share#?source=") {
            print("Cydia is selected")
            pmSegmentedControl.selectedSegmentIndex = 0
        } else if repoString!.contains("sileo://source/") {
            print("Sileo is selected")
            pmSegmentedControl.selectedSegmentIndex = 1
            
        }  else if repoString!.contains("zbra://sources/add/") {
            print("Zebra is selected")
            pmSegmentedControl.selectedSegmentIndex = 2
            
        }  else if repoString!.contains("installer://add/repo=") {
            print("Installer is selected")
            pmSegmentedControl.selectedSegmentIndex = 3
            
        }
        
        let moreReposBool: Bool = UserDefaults.standard.bool(forKey: "moreRepos")
        
        if moreReposBool == true {
            moreReposSwitch.isOn = true
        } else {
            moreReposSwitch.isOn = false
        }
        
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: scrollView.contentSize.height + (creditsStack.frame.origin.y + creditsStack.frame.size.height))
        
        /*containerView.frame.size = CGSize(width: self.containerView.frame.size.width, height: self.containerView.frame.size.height + (creditsStack.frame.origin.y + creditsStack.frame.size.height))*/
    }
    
    @IBAction func pmChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 { UserDefaults.standard.set("cydia://url/https://cydia.saurik.com/api/share#?source=", forKey: "pmURL")
            print("Cydia is selected")
        }
        else if sender.selectedSegmentIndex == 1 {
            UserDefaults.standard.set("sileo://source/", forKey: "pmURL")
            print("Sileo is selected")
        }
        else if sender.selectedSegmentIndex == 2 {
            UserDefaults.standard.set("zbra://sources/add/", forKey: "pmURL")
            print("Zebra is selected")
        }
        else if sender.selectedSegmentIndex == 3 {
            UserDefaults.standard.set("installer://add/repo=", forKey: "pmURL")
            print("Installer is selected")
        }
    }
    
    @IBAction func moreReposSwitchChanged(_ sender: Any) {
        if moreReposSwitch.isOn {
            UserDefaults.standard.set(true, forKey: "moreRepos")
            print("More repos are visible now")
        } else {
            UserDefaults.standard.set(false, forKey: "moreRepos")
            print("Only popular repos are visible now")
        }
    }
    @IBAction func twitterPressed(_ sender: UIButton) {
        
        var twitterURL: String = ""
        
        
        if sender.tag == 0 {
            twitterURL = "https://twitter.com/HomemadeToast57"
        }
        else if sender.tag == 1 {
            twitterURL = "https://twitter.com/QuixThe2nd"
        }
        else if sender.tag == 2 {
            twitterURL = "https://twitter.com/Jamie_Devvix"
        }
        
        guard let url = URL(string: twitterURL) else { return }
        UIApplication.shared.open(url)
        
        
    }
    
    @IBAction func requestRepoButtonPressed(_ sender: Any) {
        var url = URL(string: "https://forms.gle/9Y1N7Njzf4hycX2B7")!
        UIApplication.shared.open(url)
    }
    
    
}
