//
//  MovieDetailsViewController.swift
//  ArcMovies
//
//  Created by Nathan on 28/08/2018.
//  Copyright © 2018 Nathan. All rights reserved.
//

import UIKit
//(name, poster image, genre, overview and release date)
class MovieDetailsViewController: UIViewController {

    var movieViewModel: MovieViewModel?
    @IBOutlet var genre: UILabel!
    @IBOutlet var releaseDate: UILabel!
    @IBOutlet var overview: UITextView!
    @IBOutlet var poster: UIImageView!

    @IBOutlet var movieTitle: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = movieViewModel?.title
        setMovieDetails()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setMovieDetails() {
        movieTitle.text = movieViewModel?.title
        releaseDate.text = movieViewModel?.release_date
        overview.text = movieViewModel?.overview
        setPosterImage()
        setGenre()
    }
    
    func setPosterImage() {
        let url = URL(string: (movieViewModel?.posterFullPath)!)
        
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            if data != nil {
                DispatchQueue.main.async {
                    self.poster.image = UIImage(data: data!)
                }
            }
        }
    }
    
    func setGenre() {
        Service.shared.fetchGenres { (genres, error) in
            var genresString = "Genres: "
            for i in 0..<self.movieViewModel!.genre_ids.count {
                if i == self.movieViewModel!.genre_ids.count-1 {
                    genresString.append("\(genres![self.movieViewModel!.genre_ids[i]]!)")
                } else {
                    genresString.append("\(genres![self.movieViewModel!.genre_ids[i]]!), ")
                }
            }
            self.genre.text = genresString
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
