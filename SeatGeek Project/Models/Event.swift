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
    var isFavorited: Bool?
    
    
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
