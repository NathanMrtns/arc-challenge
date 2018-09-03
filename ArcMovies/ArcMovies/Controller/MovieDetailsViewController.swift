//
//  MovieDetailsViewController.swift
//  ArcMovies
//
//  Created by Nathan on 28/08/2018.
//  Copyright © 2018 Nathan. All rights reserved.
//

import UIKit
class MovieDetailsViewController: UIViewController {

    var movieViewModel: MovieViewModel?
    @IBOutlet var genre: UILabel!
    @IBOutlet var releaseDate: UILabel!
    @IBOutlet var overview: UITextView!
    @IBOutlet var poster: UIImageView!
    @IBOutlet var movieTitle: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = movieViewModel?.title
        if movieViewModel != nil {
            setMovieDetails()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    func setMovieDetails() {
        Utils.shared.setPosterImage(poster: poster, imageURL: self.movieViewModel!.posterFullPath)
        Utils.shared.setGenre(label: genre, movieVM: self.movieViewModel!)
        movieTitle.text = movieViewModel?.title
        movieTitle.textAlignment = .center
        releaseDate.attributedText = movieViewModel!.attributedReleaseDate
        overview.text = movieViewModel?.overview
        overview.textAlignment = .justified
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }

}
