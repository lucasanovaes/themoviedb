//
//  Movie.swift
//  Hummingbird_movies
//
//  Created by iCasei Site on 25/04/17.
//  Copyright © 2017 iCasei Site. All rights reserved.
//

import Foundation
import UIKit

struct Movie{
    
    var title : String
    var release_date : String
    var overview : String
    var poster_path : String
    var poster : UIImage?
    
    init(json : [String : Any]) {
        self.title = json["title"] as? String ?? ""
        self.release_date = json["release_date"] as! String 
        self.overview = json["overview"] as! String 
        self.poster_path = json["poster_path"] as? String ?? ""
    }
    
    static func returnMovies(json : [String : Any]) -> [Movie]{
        let results = json["results"] as? NSArray
        var movies = [Movie]()
        results?.forEach({ (movie) in
            let parsedMovie = movie as! [String : Any]
            movies.append(Movie(json: parsedMovie))
        })
        return movies
    }
    
}
