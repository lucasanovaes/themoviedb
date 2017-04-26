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
    
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    fileprivate var movies = [Movie]()
    fileprivate var state : State = .discoverySearch
    
    enum State {
        case regularSearch
        case notregularSearchYet
        case noResults
        case discoverySearch
    }
    
    fileprivate struct TableViewCellIdentifiers{
        static var movie = "MovieCell"
        static var nothingFound = "NothingFoundCell"
        static var movieSearch = "MovieSearchCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSearchController()
        getTopMovies()
    }
    
    // MARK: Services
    fileprivate func getTopMovies(page : Int = 1){
        WebApi.instance.getTopMovies(page: page)  { [weak self] (movies, webResponse) in
            if !webResponse.isError{
                self?.movies = self!.mergeMovies(currentMovies: self!.movies, newMovies: movies, page: page)
                self?.state = movies.count > 0 ? .discoverySearch : .noResults
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    fileprivate func searchMovieWith(title : String, page : Int = 1){
        WebApi.instance.searchMovie(movieTitle: title, page: 1){ [weak self] (movies, webResponse) in
            if !webResponse.isError{
                self?.movies = self!.mergeMovies(currentMovies: self!.movies, newMovies: movies, page: page)
                self?.state = movies.count > 0 ? .regularSearch : .noResults
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    private func mergeMovies(currentMovies : [Movie], newMovies : [Movie], page : Int) -> [Movie]{
        if page == 1{
            return newMovies
        }else{
            return currentMovies + newMovies
        }
    }
    
}

// MARK: SearchResultsUpdating
extension MoviesViewController : UISearchResultsUpdating{
    
    fileprivate func setupSearchController(){
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.isActive{
            guard let searchText = searchController.searchBar.text else { return }
            
            if !searchText.isEmpty{
                searchMovieWith(title: searchText)
            }else{
                state = .notregularSearchYet
                tableView.reloadData()
            }
            
        }else{ // Closing search bar
            state = .discoverySearch
            getTopMovies()
        }
    }
    
}


// MARK: TableViewDelegate & DataSource
extension MoviesViewController : UITableViewDelegate, UITableViewDataSource{
    
    fileprivate func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: TableViewCellIdentifiers.movie)
        tableView.register(UINib(nibName: "NothingFoundTableViewCell", bundle: nil), forCellReuseIdentifier: TableViewCellIdentifiers.nothingFound)
        tableView.register(UINib(nibName: "MovieSearchTableViewCell", bundle: nil), forCellReuseIdentifier: TableViewCellIdentifiers.movieSearch)
        tableView.estimatedRowHeight = 187 // Just estimated value!
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.setNeedsLayout()
        tableView.layoutIfNeeded()
        tableView.tableHeaderView = searchController.searchBar
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch state{
            case .discoverySearch, .regularSearch:
                return movies.count
            case .notregularSearchYet, .noResults:
                return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch state{
            case .discoverySearch, .regularSearch:
                let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.movie) as! MovieTableViewCell
                cell.fill(movie: movies[indexPath.row])
                return cell
            
            case .notregularSearchYet:
                return tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.movieSearch) as! MovieSearchTableViewCell
            
            case .noResults:
                return tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.nothingFound) as! NothingFoundTableViewCell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if state == .discoverySearch || state == .regularSearch{
            if indexPath.row == movies.count - 1{
                if state == .discoverySearch{
                    getTopMovies(page: 2)
                }else if state == .regularSearch{
                    searchMovieWith(title: searchController.searchBar.text!, page: 2)
                }
            }
        }
    }
    
}
