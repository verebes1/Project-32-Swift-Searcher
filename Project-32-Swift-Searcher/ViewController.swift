//
//  ViewController.swift
//  Project-32-Swift-Searcher
//
//  Created by verebes on 06/03/2019.
//  Copyright © 2019 A&D Progress. All rights reserved.
//

import UIKit
import SafariServices
import CoreSpotlight
import MobileCoreServices

class ViewController: UITableViewController {
    
//    var projects = [[String]]()
    var projects = [(title: String, subTitle: String)]()
    var favorites = [Int]() {
        didSet {
            defaults.set(favorites, forKey: "favorites")
            print("FAVORITES SAVED")
        }
    }
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addProjects()
        loadFavorites()
        
        tableView.isEditing = true
        tableView.allowsSelectionDuringEditing = true
    }
    
    private func addProjects() {
        projects.append(("Project 1: Storm Viewer", "Constants and variables, UITableView, UIImageView, FileManager, storyboards"))
            projects.append(("Project 2: Guess the Flag", "@2x and @3x images, asset catalogs, integers, doubles, floats, operators (+= and -=), UIButton, enums, CALayer, UIColor, random numbers, actions, string interpolation, UIAlertController"))
            projects.append(("Project 3: Social Media", "UIBarButtonItem, UIActivityViewController, the Social framework, URL"))
            projects.append(("Project 4: Easy Browser", "loadView(), WKWebView, delegation, classes and structs, URLRequest, UIToolbar, UIProgressView., key-value observing"))
            projects.append(("Project 5: Word Scramble", "Closures, method return values, booleans, NSRange"))
            projects.append(("Project 6: Auto Layout", "Get to grips with Auto Layout using practical examples and code"))
            projects.append(("Project 7: Whitehouse Petitions", "JSON, Data, UITabBarController"))
            projects.append(("Project 8: 7 Swifty Words", "addTarget(), enumerated(), count, index(of:), property observers, range operators."))
    }
    
    private func loadFavorites() {
        if let savedFavorites = defaults.object(forKey: "favorites") as? [Int] {
            favorites = savedFavorites
        }
    }
    
    private func makeAttributedString(title: String, subTitle: String) -> NSAttributedString {
        let tittleAtributes = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .headline), NSAttributedString.Key.foregroundColor: UIColor.purple]
        
        let subtitleAttributes = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .subheadline)]
        
        let titleString = NSMutableAttributedString(string: "\(title)\n", attributes: tittleAtributes)
        let subtitleString = NSAttributedString(string: subTitle, attributes: subtitleAttributes)
        
        titleString.append(subtitleString)
        
        return titleString
    }
    
    func showTutorial(_ which: Int) {
        if let url = URL(string: "https://www.hackingwithswift.com/read/\(which + 1)") {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true
            
            let safariVC = SFSafariViewController(url: url, configuration: config)
            present(safariVC, animated: true)
        }
    }
    
    //MARK:- TableView methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.attributedText = makeAttributedString(title: projects[indexPath.row].title, subTitle: projects[indexPath.row].subTitle)
        
        cell.editingAccessoryType = favorites.contains(indexPath.row) ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return favorites.contains(indexPath.row) ? .delete : .insert
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showTutorial(indexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .insert {
            favorites.append(indexPath.row)
            index(item: indexPath.row)
        } else {
            if let index = favorites.index(of: indexPath.row) {
                favorites.remove(at: index)
                deIndex(item: indexPath.row)
            }
        }
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
    private func index(item: Int) {
        let project = projects[item]
        
        let attributeSet = CSSearchableItemAttributeSet(itemContentType: kUTTypeText as String)
        attributeSet.title = project.title
        attributeSet.contentDescription = project.subTitle
        
        let item = CSSearchableItem(uniqueIdentifier: "\(item)", domainIdentifier: "com.hackingwithswift", attributeSet: attributeSet)
        item.expirationDate = Date.distantFuture
        
        CSSearchableIndex.default().indexSearchableItems([item]) { error in
            if let error = error {
                print("Indexing error: \(error.localizedDescription)")
            } else {
                print("Search item successfully indexed!")
            }
        }
    }
    
    private func deIndex(item: Int) {
        CSSearchableIndex.default().deleteSearchableItems(withIdentifiers: ["\(item)"]) { error in
            if let error = error {
                print("Deindex error: \(error.localizedDescription)")
            } else {
                print("Search item successfully removed!")
            }
        }
    }
    
}

