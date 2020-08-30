//
//  SearchViewController.swift
//  I-TVShow
//
//  Created by Fuego on 8/29/20.
//  Copyright © 2020 Kobi Cook. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: ShowCell.identifier, bundle: Bundle.main), forCellReuseIdentifier: ShowCell.identifier)
            
            tableView.tableFooterView = UIView(frame: .zero) //remove empty cells
            
            tableView.separatorStyle = .none //remove the dividing lines
            
            tableView.backgroundColor = UIColor.white
            
            tableView.estimatedRowHeight = 300
            
        }
    }
    
    //MARK: Properties
    let viewModel = ViewModel()
    let searchController = UISearchController(searchResultsController: nil)
    
    var noShowView: NoShowView? {
        return viewModel.show == nil ? NoShowView().getInstance() : nil
    }
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
  
    //MARK: Functionality
    private func setup() {
        viewModel.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        setBackgroundView()
    }
    
    
    private func setBackgroundView() {
        tableView.backgroundView = noShowView
    }

}

//MARK: TableView
extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.show == nil ? 0 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ShowCell.identifier, for: indexPath) as! ShowCell
        cell.selectionStyle = .none
        cell.show = viewModel.show
        return cell
    }
    
}

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: ViewModel Delegate
extension SearchViewController: ShowDelegate {
    
    func update() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.setBackgroundView()
            if (self.viewModel.show == nil) {
                self.showAlert(title: "Show Not Found", message: "oops, looks like we don't know about that one! Try and search for a different show.")
            }
        }
    }
}

//MARK: Search Delegate
extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let search = searchBar.text,
            let sanitized = search.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        searchBar.text = ""
        viewModel.getShow(called: sanitized)
    }
}
