//
//  Event.swift
//  SeatGeek Project
//
//  Created by Molly Lowder on 02/05/21.
//

import Foundation
import UIKit

struct Event: Codable {
    
    let title: String
    let performers: [Performers]
    let datetime_local:  String
    let datetime_tbd: Bool
    let venue: Venue
    let id: Int
    var isFavorited: Bool? = false
    
    //converts url for image received from JSON to UIImage
    func getImage(from string: String) -> UIImage? {
        
        guard let url = URL(string: string)
        else {
            print("unable to create URL")
            return nil
        }
        
        var image: UIImage? = nil
        do {
            let data = try Data(contentsOf: url, options: [])
            image = UIImage(data: data)
        } catch {
            print(error.localizedDescription)
        }
        
        return image
    }
    
    //formats the date from the datetime_local received from the JSON
    func getDate(datetime_local: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"

        let date = dateFormatter.date(from: datetime_local)!

        let newDateFormatter = DateFormatter()
        newDateFormatter.locale = Locale(identifier: "en_US_POSIX")
        newDateFormatter.dateFormat = "EEEE, MMM d, yyyy"

        return newDateFormatter.string(from: date)
    }
    
    //formats the time from the datetime_local recieved from the JSON
    func getTime(datetime_local: String) -> String {
        
        let timeFormatter = DateFormatter()
        timeFormatter.locale = Locale(identifier: "en_US_POSIX")
        timeFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"

        let date = timeFormatter.date(from: datetime_local)!

        let newTimeFormatter = DateFormatter()
        newTimeFormatter.locale = Locale(identifier: "en_US_POSIX")
        newTimeFormatter.dateFormat = "h:mm a"

        return newTimeFormatter.string(from: date)
    }
    
    //converts event ID received from JSON into String data type
    func makeIDString(id: Int) -> String {
        return String(id)
    }
}

struct Performers: Codable {
    let image: String
}

struct Venue: Codable {
    let display_location: String
}

struct Events: Codable {
    var events: [Event]
}
    





