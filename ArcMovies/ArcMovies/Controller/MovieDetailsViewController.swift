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
        setMovieDetails()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    func setMovieDetails() {
        movieTitle.text = movieViewModel?.title
        movieTitle.textAlignment = .center
        releaseDate.attributedText = movieViewModel!.attributedReleaseDate
        overview.text = movieViewModel?.overview
        overview.textAlignment = .justified
        setPosterImage()
        setGenre()
    }
    
    func setPosterImage() {
        DispatchQueue.global().async {
            self.poster.sd_setImage(with: URL(string: self.movieViewModel!.posterFullPath),
                                    completed: {(image, error, cached, url) in
                if error != nil {
                    self.poster.image = UIImage.init(named: "posterPlaceholder")
                }
            })
        }
    }
    
    func setGenre() {
        if movieViewModel != nil {
            Service.shared.fetchGenres { (genres, error) in
                if genres != nil && error == nil {
                    var genresString = ""
                    for i in 0..<self.movieViewModel!.genre_ids.count {
                        if i == self.movieViewModel!.genre_ids.count-1 {
                            genresString.append("\(genres![self.movieViewModel!.genre_ids[i]]!)")
                        } else {
                            genresString.append("\(genres![self.movieViewModel!.genre_ids[i]]!), ")
                        }
                    }
                    self.genre.attributedText = Utils.shared.getGenreAttributedString(genresString)
                } else {
                    self.genre.text = "Genre: -"
                }
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }

}
