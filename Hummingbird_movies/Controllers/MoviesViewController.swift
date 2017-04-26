//
//  MoviesViewController.swift
//  Hummingbird_movies
//
//  Created by iCasei Site on 24/04/17.
//  Copyright © 2017 iCasei Site. All rights reserved.
//

import UIKit
import Foundation

final class MoviesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    var movies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSearchController()
        getTopMovies()
    }
    
    // MARK: Services
    private func getTopMovies(){
        WebApi.instance.getTopMovies { [weak self] (movies, webResponse) in
            if !webResponse.isError{
                self?.movies = movies
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    fileprivate func searchMovieWith(title : String){
        WebApi.instance.searchMovie(movieTitle: title) { [weak self] (movies, webResponse) in
            if !webResponse.isError{
                self?.movies = movies
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }
}

extension MoviesViewController : UISearchResultsUpdating{
    
    fileprivate func setupSearchController(){
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        searchMovieWith(title: searchController.searchBar.text!)
    }
}


extension MoviesViewController : UITableViewDelegate, UITableViewDataSource{
    
    fileprivate func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
        tableView.estimatedRowHeight = 187 // Just estimated value!
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.setNeedsLayout()
        tableView.layoutIfNeeded()
        tableView.separatorStyle = .none
        tableView.tableHeaderView = searchController.searchBar
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieTableViewCell
        cell.fill(movie: movies[indexPath.row])
        return cell
    }
    
}
