import Foundation

//TODO: Refactor
final class Constant {
    static let baseURL = "https://api.themoviedb.org/3/movie/upcoming?api_key=1f54bd990f1cdfb230adb312546d765d&language=en-US&page="
    static let genreURL = "https://api.themoviedb.org/3/genre/movie/list?api_key=1f54bd990f1cdfb230adb312546d765d&language=en-US"
}

class Service: NSObject {
    static let shared = Service()

    func fetchMovies(page: Int, completion: @escaping ([Movie]?, Error?) -> ()) {
        let url = URL(string: "\(Constant.baseURL)\(page)")

        let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
            do {
                let jsonResult: NSDictionary = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                var upcomingMovies = [Movie]()
                if let movies = jsonResult["results"] as? [[String: Any]] {
                    movies.forEach { upcomingMovies.append(Movie(data:$0)) }
                }
                DispatchQueue.main.async {
                    completion(upcomingMovies, nil)
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func fetchGenres(completion: @escaping ([Int: String]?, Error?) -> ()) {
        let url = URL(string: "\(Constant.genreURL)")
        let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
            do {
                let jsonResult: NSDictionary = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
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
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}
