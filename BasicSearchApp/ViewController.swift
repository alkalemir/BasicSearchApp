//
//  ViewController.swift
//  BasicSearchApp
//
//  Created by Emir Alkal on 31.05.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var datas = [String]()
    var filteredArr: [String]?
    
    var isSearching: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        
        datas.append(contentsOf: ["Emir", "Badem", "Ozge"])
    }
}


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isSearching {
            return filteredArr?.count ?? 0
        } else {
            return datas.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        
        if isSearching {
            cell.textLabel?.text = filteredArr?[indexPath.row]
        } else {
            cell.textLabel?.text = datas[indexPath.row]
        }
        
        return cell
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            isSearching = false
            tableView.reloadData()
        } else {
            isSearching = true
            filteredArr = datas.filter({ str in
                str.lowercased().contains(searchText.lowercased())
            })
            tableView.reloadData()
        }
    }
}
