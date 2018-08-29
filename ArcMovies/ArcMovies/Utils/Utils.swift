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
            if genres != nil && error == nil {
                var genresString = ""
                for i in 0..<movieVM.genreIds.count {
                    if i == movieVM.genreIds.count-1 {
                        genresString.append("\(genres![movieVM.genreIds[i]]!)")
                    } else {
                        genresString.append("\(genres![movieVM.genreIds[i]]!), ")
                    }
                }
                label.attributedText = Utils.shared.getGenreAttributedString(genresString)
            } else {
                label.text = "Genre: -"
            }
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
