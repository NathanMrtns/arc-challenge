//
//  MoviesTableViewController.swift
//  ArcMovies
//
//  Created by Nathan on 28/08/2018.
//  Copyright © 2018 Nathan. All rights reserved.
//

import UIKit

class MoviesTableViewController: UITableViewController {

    var movieViewModels = [MovieViewModel]()
    var filteredMovieViewModels = [MovieViewModel]()
    var selectedIndexPath: IndexPath?
    var currentPage = 1
    var totalPages = 1
    let spinner = UIActivityIndicatorView(activityIndicatorStyle: .white)
    var searchController = UISearchController(searchResultsController: nil)
    let cellId = "movieCell"
    let detailsSegueId = "detailSegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
        spinner.hidesWhenStopped = true
        fetchMovies()
    }
    
    fileprivate func setupSearchController() {
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search movies"
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.tintColor = .white
        searchController.searchBar.barTintColor = .white
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    func fetchMovies() {
        Service.shared.fetchMovies( page: currentPage, completion: {  (upcomingMoviesResponse, error) in
            if upcomingMoviesResponse != nil && error == nil {
                let movies: [Movie] = upcomingMoviesResponse!.results!
                self.movieViewModels = movies.map({return MovieViewModel(movie: $0)})
                self.totalPages = upcomingMoviesResponse!.total_pages ?? 1
                self.tableView.reloadData()
            } else {
                self.showErrorAlert()
            }
        })
    }

    func loadMoreMovies() {
        Service.shared.fetchMovies( page: currentPage, completion: {  (upcomingMoviesResponse, error) in
            if upcomingMoviesResponse != nil {
                guard let newMovies = upcomingMoviesResponse!.results else { return }
                if newMovies.count > 0 {
                    let newMovieViewModels = newMovies.map({return MovieViewModel(movie: $0)})
                    self.movieViewModels.append(contentsOf: newMovieViewModels)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.spinner.stopAnimating()
                    }
                } else {
                    self.showErrorAlert()
                }
            }
        })
    }

    func showErrorAlert() {
        let alert = UIAlertController(title: "Error", message: "There was an error, check your connection!", preferredStyle: .alert)
        let okBtn = UIAlertAction(title: NSLocalizedString("ok", comment: "ok"),
                                  style: UIAlertActionStyle.cancel,
                                  handler: nil)
        alert.addAction(okBtn)
        self.present(alert, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == detailsSegueId {
            if let detailsVC = segue.destination as? MovieDetailsViewController {
                if isSearching() {
                    detailsVC.movieViewModel = filteredMovieViewModels[selectedIndexPath!.row]
                } else {
                    detailsVC.movieViewModel = movieViewModels[selectedIndexPath!.row]
                }
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
}

// MARK: - Table view data source
extension MoviesTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching() {
            return filteredMovieViewModels.count
        }
        return movieViewModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! MovieCell
        var movieViewModel: MovieViewModel?
        if isSearching() {
            movieViewModel = filteredMovieViewModels[indexPath.row]
        } else {
            movieViewModel = movieViewModels[indexPath.row]
        }
        cell.movieViewModel = movieViewModel!
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        performSegue(withIdentifier: detailsSegueId, sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell,
                            forRowAt indexPath: IndexPath) {
        if !isSearching() && (currentPage+1 <= totalPages) {
            let lastSectionIndex = tableView.numberOfSections - 1
            let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
            if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
                spinner.startAnimating()
                spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
                tableView.tableFooterView = spinner
                currentPage += 1
                self.loadMoreMovies()
            }
        } else {
            spinner.stopAnimating()
        }
    }
}

//MARK: - Search Delegates
extension MoviesTableViewController: UISearchResultsUpdating, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        filterMovies(searchController.searchBar.text!)
    }
    
    func filterMovies(_ searchText: String) {
        filteredMovieViewModels = movieViewModels.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        tableView.reloadData()
    }
    
    func isSearching() -> Bool {
        return searchController.isActive && searchController.searchBar.text != ""
    }
}
