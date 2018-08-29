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
    var selectedIndexPath: IndexPath?
    var currentPage = 1
    let spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)

    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.hidesWhenStopped = true
        fetchMovies()
    }

    func fetchMovies() {
        Service.shared.fetchMovies( page: currentPage, completion: {  (movies, error) in
            self.movieViewModels = movies?.map({return MovieViewModel(movie: $0)}) ?? []
            self.tableView.reloadData()
        })
    }
    
    func loadMoreMovies() {
        Service.shared.fetchMovies( page: currentPage, completion: {  (movies, error) in
            var newMovieViewModels = movies?.map({return MovieViewModel(movie: $0)}) ?? []
            self.movieViewModels.append(contentsOf: newMovieViewModels)
            self.tableView.reloadData()
            self.spinner.stopAnimating()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieViewModels.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieCell
        let movieViewModel = movieViewModels[indexPath.row]
        cell.movieViewModel = movieViewModel
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        performSegue(withIdentifier: "detailSegue", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
            tableView.tableFooterView = spinner
            currentPage += 1
            self.loadMoreMovies()
        }
    }
    
//    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        
//        // UITableView only moves in one direction, y axis
//        let currentOffset = scrollView.contentOffset.y
//        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
//        print(maximumOffset - currentOffset)
//        // Change 10.0 to adjust the distance from bottom
//        if maximumOffset - currentOffset <= 30.0 {
//            currentPage += 1
//            self.loadMoreMovies()
//        }
//    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            if segue.destination.isKind(of: MovieDetailsViewController.self) {
                let detailsVC = segue.destination as! MovieDetailsViewController
                detailsVC.movieViewModel = movieViewModels[selectedIndexPath!.row]
            }
        }
    }
}
