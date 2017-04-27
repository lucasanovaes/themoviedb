//
//  MovieDetailViewController.swift
//  Hummingbird_movies
//
//  Created by Lucas Antonelli Novaes on 26/04/17.
//  Copyright © 2017 iCasei Site. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var backdropPoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var overview: UILabel!

    var movie : Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillMovieDetail()
    }

    private func fillMovieDetail(){
        DispatchQueue.main.async {
            self.movieTitle.text = self.movie.title
            self.releaseDate.text = self.movie.release_date
            self.overview.text = self.movie.overview
        }
        
        WebApi.instance.getImageFromUrl(url: movie.backdrop_path!) { (data, response, error) in
            DispatchQueue.main.async {
                if let data = data{
                    self.backdropPoster.image = UIImage(data: data)
                }
            }
        }
    }
    
}
