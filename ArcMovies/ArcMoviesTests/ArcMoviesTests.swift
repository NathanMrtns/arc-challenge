//
//  ArcMoviesTests.swift
//  ArcMoviesTests
//
//  Created by Nathan on 28/08/2018.
//  Copyright © 2018 Nathan. All rights reserved.
//

import XCTest
@testable import ArcMovies

class ArcMoviesTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMovieModel() {
        let movie = Movie(vote_count: 0, id: 1, video: false, vote_average: 0, title: "Test Movie", popularity: 0, poster_path: "testPath", original_language: nil, original_title: nil, genre_ids: [1], backdrop_path: nil, adult: false, overview: "This is the movie overview", release_date: "2018-04-06")
        XCTAssertEqual(movie.id, 1)
        XCTAssertEqual(movie.title, "Test Movie")
        XCTAssertEqual(movie.release_date, "2018-04-06")
        XCTAssertEqual(movie.overview, "This is the movie overview")
    }
    
    func testMovieViewModel() {
        let movie = Movie(vote_count: 0, id: 1, video: false, vote_average: 0, title: "Test Movie", popularity: 0, poster_path: "testPath", original_language: nil, original_title: nil, genre_ids: [1], backdrop_path: nil, adult: false, overview: "This is the movie overview", release_date: "2018-04-06")
        
        let movieViewModel = MovieViewModel(movie: movie)
        XCTAssertEqual(movie.title, movieViewModel.title)
        XCTAssertEqual(movie.overview, movieViewModel.overview)
        XCTAssertEqual(movieViewModel.posterFullPath, "\(URLS.imageURL)\(movie.poster_path!)")
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        let newDate = df.date(from: movie.release_date!)
        df.dateStyle = .medium
        let releaseDateFormatted = df.string(from: newDate!)
        XCTAssertEqual(movieViewModel.formattedDate, releaseDateFormatted)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
