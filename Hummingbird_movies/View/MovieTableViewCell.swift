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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func fill(movie : Movie){
        title.text = movie.title
        releaseDate.text = movie.release_date
        overview.text = movie.overview
    }
    
}
