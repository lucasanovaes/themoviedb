//
//  WebResponse.swift
//  Hummingbird_movies
//
//  Created by iCasei Site on 25/04/17.
//  Copyright © 2017 iCasei Site. All rights reserved.
//

import Foundation

final class WebResponse{
    
    var json : [String:Any]?
    var error : Error?
    var isError : Bool{
        return error != nil
    }
    var messageError : String{
        guard let error = error else { return "Error"}
        return error.localizedDescription
    }
    
    convenience init(json : [String:Any]?, error : Error?) {
        self.init()
        self.json = json
        self.error = error
    }
}
