//
//  MovieTableViewCell.swift
//  Hummingbird_movies
//
//  Created by iCasei Site on 26/04/17.
//  Copyright © 2017 iCasei Site. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var overview: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func fill(movie : Movie){
        DispatchQueue.main.async {
            self.title.text = movie.title
            self.releaseDate.text = movie.release_date
            self.overview.text = movie.overview
        }
        
        self.poster.image = UIImage()
        self.spinner.startAnimating()
        WebApi.instance.getImageFromUrl(url: movie.poster_path!) { (data, response, error) in
            DispatchQueue.main.async {
                self.spinner.stopAnimating()
                self.poster.image = data == nil ? #imageLiteral(resourceName: "movie_placeholder") : UIImage(data: data!)
            }
        }

    }
    
}
