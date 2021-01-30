//
//  Date.swift
//  Todo App
//
//  Created by Blankz on 30/1/2564 BE.
//

import Foundation

extension String {
    func getDate() -> String {
        let time = String(self.split(separator: ".").first ?? "")
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        guard let date = dateFormatter.date(from: time) else { return time }

        dateFormatter.dateFormat = "dd MMMM YYYY HH:mm:ss"
        
        return dateFormatter.string(from: date)
    }
}
