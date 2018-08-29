//
//  MovieCell.swift
//  ArcMovies
//
//  Created by Nathan on 28/08/2018.
//  Copyright © 2018 Nathan. All rights reserved.
//

import UIKit
import SDWebImage

class MovieCell: UITableViewCell {

    @IBOutlet var movieName: UILabel!
    @IBOutlet var genre: UILabel!
    @IBOutlet var releaseDate: UILabel!
    @IBOutlet weak var poster: UIImageView!

    var movieViewModel: MovieViewModel! {
        didSet {
            movieName.text = movieViewModel.title
            releaseDate.attributedText = movieViewModel.attributedReleaseDate
            Utils.shared.setGenre(label: genre, movieVM: movieViewModel)
            Utils.shared.setPosterImage(poster: poster, imageURL: self.movieViewModel!.posterFullPath)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        self.genre.text = ""
        self.movieName.text = ""
        self.poster.image = nil
        self.releaseDate.text = ""
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        contentView.backgroundColor = isHighlighted ? UIColor.darkGray : UIColor.init(named: "Grey")
    }

    required init?(coder aDecoder: NSCoder) {
        self.movieViewModel = nil
        super.init(coder: aDecoder)
    }
}
