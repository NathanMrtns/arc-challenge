//
//  Movie.swift
//  ArcMovies
//
//  Created by Nathan on 28/08/2018.
//  Copyright © 2018 Nathan. All rights reserved.
//

import Foundation
struct Movie {
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

    init(data: [String: Any]) {
        self.voteCount = data["vote_count"] as! Int
        self.id = data["id"] as! Int
        self.video = data["video"] as! Bool
        self.voteAverage = data["vote_average"] as! NSNumber
        self.title = data["title"] as! String
        self.popularity = data["popularity"] as! NSNumber
        self.posterPath = data["poster_path"] as? String ?? ""
        self.originalLanguage = data["original_language"] as! String
        self.originalTitle = data["original_title"] as! String
        self.genreIds = data["genre_ids"] as! [Int]
        self.backdropPath = data["backdrop_path"] as? String ?? ""
        self.adult = data["adult"] as! Bool
        self.overview = data["overview"] as! String
        self.releaseDate = data["release_date"] as! String
    }
}
