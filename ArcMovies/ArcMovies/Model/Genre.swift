//
//  Genre.swift
//  ArcMovies
//
//  Created by Nathan on 28/08/18.
//  Copyright © 2018 Nathan. All rights reserved.
//

import Foundation
struct Genre {
    let id: Int
    let name: String
    
    init(data: [String: Any]) {
        self.id = data["id"] as! Int
        self.name = data["name"] as! String
    }
}
