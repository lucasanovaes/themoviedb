//
//  Movie.swift
//  Hummingbird_movies
//
//  Created by iCasei Site on 25/04/17.
//  Copyright © 2017 iCasei Site. All rights reserved.
//

import Foundation
import UIKit

// Model class

struct Movie{
    
    var title : String
    var release_date : String
    var overview : String
    var poster_path : URL?
    var backdrop_path : URL?
    
    init(json : [String : Any]) {
        self.title = json["title"] as? String ?? ""
        self.release_date = (json["release_date"] as? String ?? "").formatedDate()
        self.overview = json["overview"] as! String
        if let url = URL(string: "https://image.tmdb.org/t/p/w500\(json["poster_path"] as? String ?? "")"){
            self.poster_path = url
        }
        if let url = URL(string: "https://image.tmdb.org/t/p/w500\(json["backdrop_path"] as? String ?? "")"){
            self.backdrop_path = url
        }
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
