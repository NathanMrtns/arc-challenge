//
//  Utils.swift
//  ArcMovies
//
//  Created by Nathan on 29/08/2018.
//  Copyright © 2018 Nathan. All rights reserved.
//

import Foundation
import UIKit

class Utils: NSObject {
    static let shared = Utils()

    func getGenreAttributedString(_ genresString: String) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: "")
        let genresAttString = NSMutableAttributedString(string: genresString)
        let attrs = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 17)]
        let boldString = NSMutableAttributedString(string: "Genre: ", attributes:attrs)
        attributedString.append(boldString)
        attributedString.append(genresAttString)
        return attributedString
    }

    func setGenre(label: UILabel, movieVM: MovieViewModel) {
        Service.shared.fetchGenres { (genres, error) in
            guard let genres = genres else {
                label.text = "Genre: -"
                return
            }
            var genresString = ""
            var movieGenres = genres.filter { movieVM.genre_ids.contains($0.id!) }
            for i in 0..<movieGenres.count {
                if i < movieGenres.count - 1 {
                    genresString.append("\(movieGenres[i].name!), ")
                } else {
                    genresString.append("\(movieGenres[i].name!)")
                }
            }
            label.attributedText = Utils.shared.getGenreAttributedString(genresString)
        }
    }

    //Using SDWebImage to easy cache images
    func setPosterImage(poster: UIImageView, imageURL: String) {
        DispatchQueue.global().async {
            poster.sd_setImage(with: URL(string: imageURL),
                                    completed: {(image, error, cached, url) in
                                        if error != nil {
                                            poster.image = UIImage.init(named: "posterPlaceholder")
                                        }
            })
        }
    }
}
