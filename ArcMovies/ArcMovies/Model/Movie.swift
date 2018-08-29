//
//  Movie.swift
//  ArcMovies
//
//  Created by Nathan on 28/08/2018.
//  Copyright © 2018 Nathan. All rights reserved.
//

import Foundation
struct Movie: Decodable {
    let vote_count: Int?
    let id: Int?
    let video: Bool?
    let vote_average: Float?
    let title: String?
    let popularity: Float?
    let poster_path: String?
    let original_language: String?
    let original_title: String?
    let genre_ids: [Int]?
    let backdrop_path: String?
    let adult: Bool?
    let overview: String?
    let release_date: String?
}
