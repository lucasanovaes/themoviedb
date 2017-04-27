//
//  WebApi.swift
//  Hummingbird_movies
//
//  Created by iCasei Site on 25/04/17.
//  Copyright © 2017 iCasei Site. All rights reserved.
//

import Foundation

/*
 
 Class acting as an 'interface' for the WebClient, providing all parameters scheme, data parse, url compose and more.
 
 */


final class WebApi{
    
    static let instance = WebApi()
    var nextPage = 1
    
    private enum Path : String{
        case discover_movies = "/discover/movie"
        case search_movies = "/search/movie"
    }
    
    private struct Parameters{
        static let language = ["language" : "pt-BR"]
        static let api_key = ["api_key" : "70b1a97dd18bf106f5031f0f34558789"]
        static let sort_by = ["sort_by" : "popularity.desc"]
        static let page = ["page" : "1"]
    }
    
    private struct Parameter{
        var rawValue : Dictionary<String, String>
        init(parameter : Dictionary<String, String>){
            self.rawValue = parameter
        }
    }
    
    private struct Url{
        let baseUrl = "https://api.themoviedb.org/3"
        var path : Path
        var parameters : [Parameter]
        
        init(path : Path, parameters : [Parameter]) {
            self.path = path
            self.parameters = parameters
        }
    }
    
    private func fillUrl(url : Url) -> URL?{
        var urlComponents = URLComponents(string: url.baseUrl + url.path.rawValue)
        var queryItens = [URLQueryItem]()
        
        url.parameters.forEach({ (parameter) in
            queryItens.append(URLQueryItem(name: (parameter.rawValue.first?.key)!, value: parameter.rawValue.first?.value))
        })
        
        urlComponents?.queryItems = queryItens
        return urlComponents?.url
    }
    
    // MARK: Methods that calls API
    typealias getTopMoviesOnComplete = ([Movie], WebResponse) -> Void
    func getTopMovies(page : Int = 1, onComplete : @escaping getTopMoviesOnComplete){
        
        let url = Url(path: .discover_movies, parameters: [Parameter(parameter: Parameters.language), Parameter(parameter: Parameters.api_key), Parameter(parameter: Parameters.sort_by), Parameter(parameter : ["page" : "\(page)"])])
        
        WebClient().request(url: fillUrl(url: url)) { (webResponse) in
            onComplete(Movie.returnMovies(json: webResponse.json!), webResponse)
        }
    }
    
    typealias searchMovieOnComplete = ([Movie], WebResponse) -> Void
    func searchMovie(movieTitle : String, page : Int = 1, onComplete : @escaping searchMovieOnComplete){
        
        let url = Url(path: .search_movies, parameters: [Parameter(parameter: Parameters.language), Parameter(parameter: Parameters.api_key), Parameter(parameter: ["query" : movieTitle]), Parameter(parameter : ["page" : "\(page)"])])
        
        WebClient().request(url: fillUrl(url: url)) { (webResponse) in
            onComplete(Movie.returnMovies(json: webResponse.json!), webResponse)
        }
    }
    
    func getImageFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
        }.resume()
    }
    
}
