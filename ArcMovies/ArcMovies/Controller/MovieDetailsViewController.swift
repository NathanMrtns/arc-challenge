//
//  MovieDetailsViewController.swift
//  ArcMovies
//
//  Created by Nathan on 28/08/2018.
//  Copyright © 2018 Nathan. All rights reserved.
//

import UIKit
//(name, poster image, genre, overview and release date)
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
            self.poster.sd_setImage(with: URL(string: self.movieViewModel!.posterFullPath))
        }
    }
    
    func setGenre() {
        Service.shared.fetchGenres { (genres, error) in
            var genresString = ""
            for i in 0..<self.movieViewModel!.genre_ids.count {
                if i == self.movieViewModel!.genre_ids.count-1 {
                    genresString.append("\(genres![self.movieViewModel!.genre_ids[i]]!)")
                } else {
                    genresString.append("\(genres![self.movieViewModel!.genre_ids[i]]!), ")
                }
            }
            let attributedString = NSMutableAttributedString(string: "")
            let genresAttString = NSMutableAttributedString(string: genresString)
            let attrs = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 17)]
            let boldString = NSMutableAttributedString(string: "Genre: ", attributes:attrs)
            attributedString.append(boldString)
            attributedString.append(genresAttString)
            self.genre.attributedText = attributedString
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }

}
