import Foundation

//TODO: Refactor
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

    func fetchMovies(page: Int, completion: @escaping ([Movie]?, Error?) -> ()) {
        let url = URL(string: "\(URLS.baseURL)\(URLS.upcomingMovies)\(page)")
        let task = session.dataTask(with: url!) {(data, response, error) in
            if let err = error {
                completion(nil, err)
                print("Failed to fetch movies:", err)
                return
            }
            do {
                let jsonResult: NSDictionary =
                    try JSONSerialization.jsonObject(with: data!,
                                                     options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                var upcomingMovies = [Movie]()
                if let movies = jsonResult["results"] as? [[String: Any]] {
                    movies.forEach { upcomingMovies.append(Movie(data:$0)) }
                }
                DispatchQueue.main.async {
                    completion(upcomingMovies, nil)
                }
            } catch let error as NSError {
                NSLog("Failed to parse movies")
                NSLog(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func fetchGenres(completion: @escaping ([Int: String]?, Error?) -> ()) {
        let url = URL(string: "\(URLS.baseURL)\(URLS.genreURL)")
        let task = session.dataTask(with: url!) {(data, response, error) in
            if let err = error {
                completion(nil, err)
                print("Failed to fetch genres:", err)
                return
            }
            do {
                let jsonResult: NSDictionary =
                    try JSONSerialization.jsonObject(with: data!,
                                                     options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                var genres: [Int: String] = [:]
                if let jsonGenres = jsonResult["genres"] as? [[String: Any]] {
                    for genre in jsonGenres {
                        let genre = Genre(data: genre)
                        genres[genre.id] = genre.name
                    }
                }
                DispatchQueue.main.async {
                    completion(genres, nil)
                }
            } catch let error as NSError {
                NSLog("Failed to parse genres")
                NSLog(error.localizedDescription)
            }
        }
        task.resume()
    }
}
