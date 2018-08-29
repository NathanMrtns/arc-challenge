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
            setGenre()
            setPosterImage()
        }
    }
    
    func setPosterImage() {
        DispatchQueue.global().async {
            self.poster.sd_setImage(with: URL(string: self.movieViewModel!.posterFullPath))
        }
    }
    
    //TODO: Refactor
    func setGenre() {
        Service.shared.fetchGenres { (genres, error) in
            var genresString = ""
            for i in 0..<self.movieViewModel.genre_ids.count {
                if i == self.movieViewModel.genre_ids.count-1 {
                    genresString.append("\(genres![self.movieViewModel.genre_ids[i]]!)")
                } else {
                    genresString.append("\(genres![self.movieViewModel.genre_ids[i]]!), ")
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
