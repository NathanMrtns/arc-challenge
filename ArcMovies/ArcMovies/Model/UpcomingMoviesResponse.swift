//
//  UpcomingMoviesResponse.swift
//  ArcMovies
//
//  Created by Nathan on 29/08/2018.
//  Copyright © 2018 Nathan. All rights reserved.
//

import Foundation
struct UpcomingMovieResponse: Decodable {
    let results: [Movie]?
    let page: Int?
    let total_results: Int?
    let total_pages: Int?
}
