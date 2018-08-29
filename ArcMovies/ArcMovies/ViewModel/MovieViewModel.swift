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
    let vote_count: Int
    let id: Int
    let video: Bool
    let vote_average: NSNumber
    let title: String
    let popularity: NSNumber
    let poster_path: String
    let original_language: String
    let original_title: String
    let genre_ids: [Int]
    let backdrop_path: String
    let adult: Bool
    let overview: String
    let release_date: String

    init(movie: Movie) {
        self.vote_count = movie.vote_count
        self.id = movie.id
        self.video = movie.video
        self.vote_average = movie.vote_average
        self.title = movie.title
        self.popularity = movie.popularity
        self.poster_path = movie.poster_path
        self.original_language = movie.original_language
        self.original_title = movie.original_title
        self.genre_ids = movie.genre_ids
        self.backdrop_path = movie.backdrop_path
        self.adult = movie.adult
        self.overview = movie.overview
        self.release_date = movie.release_date
    }

    var posterFullPath: String {
        return URLS.imageURL + poster_path
    }
    
    var formattedDate: String {
        let df = DateFormatter()
        df.dateFormat = "YYYY-MM-DD"
        let date = df.date(from: release_date)
        df.dateStyle = .medium
        if date != nil {
            return df.string(from: date!)
        }
        return release_date
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
