//
//  ViewController.swift
//  Project-32-Swift-Searcher
//
//  Created by verebes on 06/03/2019.
//  Copyright © 2019 A&D Progress. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var projects = [[String]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addProjects()
    }
    
    private func addProjects() {
        projects.append(["Project 1: Storm Viewer", "Constants and variables, UITableView, UIImageView, FileManager, storyboards"])
            projects.append(["Project 2: Guess the Flag", "@2x and @3x images, asset catalogs, integers, doubles, floats, operators (+= and -=), UIButton, enums, CALayer, UIColor, random numbers, actions, string interpolation, UIAlertController"])
            projects.append(["Project 3: Social Media", "UIBarButtonItem, UIActivityViewController, the Social framework, URL"])
            projects.append(["Project 4: Easy Browser", "loadView(), WKWebView, delegation, classes and structs, URLRequest, UIToolbar, UIProgressView., key-value observing"])
            projects.append(["Project 5: Word Scramble", "Closures, method return values, booleans, NSRange"])
            projects.append(["Project 6: Auto Layout", "Get to grips with Auto Layout using practical examples and code"])
            projects.append(["Project 7: Whitehouse Petitions", "JSON, Data, UITabBarController"])
            projects.append(["Project 8: 7 Swifty Words", "addTarget(), enumerated(), count, index(of:), property observers, range operators."])
    }
    
    private func makeAttributedString(title: String, subTitle: String) -> NSAttributedString {
        let tittleAtributes = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .headline), NSAttributedString.Key.foregroundColor: UIColor.purple]
        
        let subtitleAttributes = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .subheadline)]
        
        let titleString = NSMutableAttributedString(string: "\(title)\n", attributes: tittleAtributes)
        let subtitleString = NSAttributedString(string: subTitle, attributes: subtitleAttributes)
        
        titleString.append(subtitleString)
        
        return titleString
    }
    
    //MARK:- TableView methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.attributedText = makeAttributedString(title: projects[indexPath.row][0], subTitle: projects[indexPath.row][1])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

