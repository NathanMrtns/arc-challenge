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
        genre.text = "\(movieViewModel?.genre_ids.first)"
        releaseDate.text = movieViewModel?.release_date
        overview.text = movieViewModel?.overview
        
        let url = URL(string: (movieViewModel?.posterFullPath)!)

        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            DispatchQueue.main.async {
                self.poster.image = UIImage(data: data!)
            }
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
