import Foundation

final class Constant {
    static let baseURL = "https://api.themoviedb.org/3/movie/upcoming?api_key=1f54bd990f1cdfb230adb312546d765d&language=en-US&page=1"
}

//Singleton to call API Services
final class API {
    static let shared = API()

    init() {
    }

    func getUpcomingMovies(completion: @escaping ([[String: Any]]) -> Void) {
        let url = URL(string: "\(Constant.baseURL)")

        let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
            do {
                let jsonResult: NSDictionary = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                    print(jsonResult)
                if let movies = jsonResult["results"] as? [[String: Any]] {
                    completion(movies)
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}
