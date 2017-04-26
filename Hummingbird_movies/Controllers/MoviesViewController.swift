//
//  MoviesViewController.swift
//  Hummingbird_movies
//
//  Created by iCasei Site on 24/04/17.
//  Copyright © 2017 iCasei Site. All rights reserved.
//

import UIKit
import Foundation

class MoviesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        WebApi.instance.getTopMovies { (asd, webResponse) in
            print(webResponse.json)
        }
        
    }


}
