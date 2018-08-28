import Foundation

final class Constant {
    static let baseURL = "https://api.themoviedb.org/3/movie/upcoming?api_key=1f54bd990f1cdfb230adb312546d765d&language=en-US&page=1"
}

class Service: NSObject {
    static let shared = Service()

    func fetchMovies(completion: @escaping ([Movie]?, Error?) -> ()) {
        let url = URL(string: "\(Constant.baseURL)")

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
}
