//
//  MovieCell.swift
//  ArcMovies
//
//  Created by Nathan on 28/08/2018.
//  Copyright © 2018 Nathan. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet var movieName: UILabel!
    @IBOutlet var genre: UILabel!
    @IBOutlet var releaseDate: UILabel!

    var movieViewModel: MovieViewModel! {
        didSet {
            movieName.text = movieViewModel.title
            genre.text = "\(movieViewModel.genre_ids.first)"
            releaseDate.text = movieViewModel.release_date
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    required init?(coder aDecoder: NSCoder) {
        self.movieViewModel = nil
        super.init(coder: aDecoder)
    }
}
