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
    @IBOutlet weak var poster: UIImageView!
    
    var movieViewModel: MovieViewModel! {
        didSet {
            movieName.text = movieViewModel.title
            releaseDate.text = "Release date: \(movieViewModel.release_date)"
            setGenre()
            setPosterImage()
        }
    }
    
    func setPosterImage() {
        let url = URL(string: (movieViewModel?.posterFullPath)!)
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            if data != nil {
                DispatchQueue.main.async {
                    self.poster.image = UIImage(data: data!)
                }
            }
        }
    }
    
    func setGenre() {
        Service.shared.fetchGenres { (genres, error) in
            var genresString = "Genres: "
            for i in 0..<self.movieViewModel.genre_ids.count {
                if i == self.movieViewModel.genre_ids.count-1 {
                    genresString.append("\(genres![self.movieViewModel.genre_ids[i]]!)")
                } else {
                    genresString.append("\(genres![self.movieViewModel.genre_ids[i]]!), ")
                }
            }
            self.genre.text = genresString
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

    required init?(coder aDecoder: NSCoder) {
        self.movieViewModel = nil
        super.init(coder: aDecoder)
    }
}
