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
}
