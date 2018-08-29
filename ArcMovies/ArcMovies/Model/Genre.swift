//
//  Genre.swift
//  ArcMovies
//
//  Created by Nathan on 28/08/18.
//  Copyright © 2018 Nathan. All rights reserved.
//

import Foundation

struct ListOfGenre: Decodable {
    let genres : [Genre]?
}

struct Genre: Decodable {
    let id: Int?
    let name: String?
}
