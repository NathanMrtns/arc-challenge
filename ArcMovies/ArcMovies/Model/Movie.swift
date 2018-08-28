//
//  Movie.swift
//  ArcMovies
//
//  Created by Nathan on 28/08/2018.
//  Copyright © 2018 Nathan. All rights reserved.
//

import Foundation
struct Movie {
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

    init(data: [String: Any]) {
        self.vote_count = data["vote_count"] as! Int
        self.id = data["id"] as! Int
        self.video = data["video"] as! Bool
        self.vote_average = data["vote_average"] as! NSNumber
        self.title = data["title"] as! String
        self.popularity = data["popularity"] as! NSNumber
        self.poster_path = data["poster_path"] as! String
        self.original_language = data["original_language"] as! String
        self.original_title = data["original_title"] as! String
        self.genre_ids = data["genre_ids"] as! [Int]
        self.backdrop_path = data["backdrop_path"] as! String
        self.adult = data["adult"] as! Bool
        self.overview = data["overview"] as! String
        self.release_date = data["release_date"] as! String
    }
}
