//
//  WebClient.swift
//  Hummingbird_movies
//
//  Created by iCasei Site on 25/04/17.
//  Copyright © 2017 iCasei Site. All rights reserved.
//

import Foundation

/*
 
 Class responsable for communicate with API, requesting asynchrony, handling and returning data
 
 */

final class WebClient{
    
    typealias requestOnComplete = (WebResponse) -> Void
    func request(url : URL?, onComplete : @escaping requestOnComplete){
        
        guard let url = url else { return }
        print("-----------\n\nRequest URL: \(url)\n\n-----------")
        
        let task = URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
            if let error = error{
                print("Error = \(error)")
            }
            
            guard let data = data else{
                print("Empty data")
                onComplete(WebResponse(json: nil, error: error))
                return
            }
            
            let json = try? JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
            print(json ?? "Cant parse JSON")
            
            onComplete(WebResponse(json: json, error: error))
        }
        
        task.resume()
    }

    
}
