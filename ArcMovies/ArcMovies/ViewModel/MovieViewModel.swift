//
//  MovieViewModel.swift
//  ArcMovies
//
//  Created by Nathan on 28/08/2018.
//  Copyright © 2018 Nathan. All rights reserved.
//

import Foundation
import UIKit

struct MovieViewModel {
    let voteCount: Int
    let id: Int
    let video: Bool
    let voteAverage: NSNumber
    let title: String
    let popularity: NSNumber
    let posterPath: String
    let originalLanguage: String
    let originalTitle: String
    let genreIds: [Int]
    let backdropPath: String
    let adult: Bool
    let overview: String
    let releaseDate: String

    init(movie: Movie) {
        self.voteCount = movie.voteCount
        self.id = movie.id
        self.video = movie.video
        self.voteAverage = movie.voteAverage
        self.title = movie.title
        self.popularity = movie.popularity
        self.posterPath = movie.posterPath
        self.originalLanguage = movie.originalLanguage
        self.originalTitle = movie.originalTitle
        self.genreIds = movie.genreIds
        self.backdropPath = movie.backdropPath
        self.adult = movie.adult
        self.overview = movie.overview
        self.releaseDate = movie.releaseDate
    }

    var posterFullPath: String {
        return URLS.imageURL + posterPath
    }
    
    var formattedDate: String {
        let df = DateFormatter()
        df.dateFormat = "YYYY-MM-DD"
        let date = df.date(from: releaseDate)
        df.dateStyle = .medium
        if date != nil {
            return df.string(from: date!)
        }
        return releaseDate
    }
    
    var attributedReleaseDate: NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: "")
        let releaseDateString = NSMutableAttributedString(string: self.formattedDate)
        let attrs = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 17)]
        let boldString = NSMutableAttributedString(string: "Release date: ", attributes:attrs)
        attributedString.append(boldString)
        attributedString.append(releaseDateString)
        return attributedString
    }
}
