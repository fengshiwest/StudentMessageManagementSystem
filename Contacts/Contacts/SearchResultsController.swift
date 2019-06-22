//
//  SearchResultsController.swift
//  Contacts
//
//  Created by fengshiwest on 2019/5/30.
//  Copyright © 2019 fengshiwest. All rights reserved.
//

import UIKit

class SearchResultsController: UITableViewController, UISearchResultsUpdating  {
  
    let studentInfoIdentifier = "StudentInfoIdentifier"
    var names:[String] = []
    var filteredNames: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self,forCellReuseIdentifier: studentInfoIdentifier)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Table View Data Source Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredNames.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: studentInfoIdentifier,for:indexPath)
        //let filteredName = cell.viewWithTag(1) as! UILabel
        //filteredName.text = filteredNames[indexPath.row]
        cell.textLabel?.text = filteredNames[indexPath.row]
        return cell
        
    }
    
    // MARK: UISearchResultsUpdating Conformance
    func updateSearchResults(for searchController: UISearchController) {
        if let searchString = searchController.searchBar.text {
        
            filteredNames.removeAll(keepingCapacity: true)
            
            if !searchString.isEmpty {
                let filter: (String) -> Bool = { name in
                    // Filter out long or short names depending on which
                    // scope button is selected.
                    
                    let range = name.range(of: searchString, options: NSString.CompareOptions.caseInsensitive, range: nil, locale: nil)
                    return range != nil
                }
                let matches = names.filter(filter)
                filteredNames += matches
            
            }
        }
        tableView.reloadData()
    }
    
}
