//
//  Service.swift
//  ArcMovies
//
//  Created by Nathan on 28/08/18.
//  Copyright © 2018 Nathan. All rights reserved.
//

import Foundation

final class URLS {
    static let baseURL = "https://api.themoviedb.org/3/"
    static let imageURL = "https://image.tmdb.org/t/p/w500"
    static let upcomingMovies = "movie/upcoming?api_key=1f54bd990f1cdfb230adb312546d765d&region=US&language=en-US&page="
    static let genreURL = "genre/movie/list?api_key=1f54bd990f1cdfb230adb312546d765d&language=en-US"
}

class Service: NSObject {
    static let shared = Service()
    var session = URLSession()

    override init() {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .returnCacheDataElseLoad
        session = URLSession.init(configuration: config)
    }

    func fetchMovies(page: Int, completion: @escaping (UpcomingMovieResponse?, Error?) -> ()) {
        let url = URL(string: "\(URLS.baseURL)\(URLS.upcomingMovies)\(page)")
        let task = session.dataTask(with: url!) {(data, response, error) in
            if let err = error {
                completion(nil, err)
                print("Failed to fetch movies:", err)
                return
            }
            guard let data = data else { return }
            do {
                let upcomingMoviesResponse = try JSONDecoder().decode(UpcomingMovieResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(upcomingMoviesResponse, nil)
                }
            } catch let error as NSError {
                NSLog("Failed to parse movies")
                NSLog(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func fetchGenres(completion: @escaping ([Genre]?, Error?) -> ()) {
        let url = URL(string: "\(URLS.baseURL)\(URLS.genreURL)")
        let task = session.dataTask(with: url!) {(data, response, error) in
            if let err = error {
                completion(nil, err)
                print("Failed to fetch genres:", err)
                return
            }
            guard let data = data else { return }
            do {
                let listGenres = try JSONDecoder().decode(ListOfGenre.self, from: data)
                DispatchQueue.main.async {
                    completion(listGenres.genres, nil)
                }
            } catch let error as NSError {
                NSLog("Failed to parse genres")
                NSLog(error.localizedDescription)
            }
        }
        task.resume()
    }
}
