//
//  StringExtension.swift
//  Hummingbird_movies
//
//  Created by iCasei Site on 27/04/17.
//  Copyright © 2017 iCasei Site. All rights reserved.
//

import Foundation

extension String{
    
    func formatedDate() -> String{
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale
        dateFormatter.locale = Locale(identifier: "pt_BR")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: self) else { return ""}
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.locale = tempLocale
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
}
