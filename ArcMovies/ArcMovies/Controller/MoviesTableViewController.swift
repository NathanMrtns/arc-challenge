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

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMovies()
    }

    fileprivate func fetchMovies() {
        Service.shared.fetchMovies { (movies, error) in
            self.movieViewModels = movies?.map({return MovieViewModel(movie: $0)}) ?? []
            self.tableView.reloadData()
        }
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
