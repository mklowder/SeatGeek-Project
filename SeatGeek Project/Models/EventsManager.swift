//
//  EventsManager.swift
//  SeatGeek Project
//
//  Created by Molly Lowder on 03/02/21.
//

import Foundation

class EventsManager {
    var events = [Event]()
    let eventsURL = "https://api.seatgeek.com/2/events"
    let clientID = "client_id=MjE1MzUxODN8MTYxMjczMjM0NC45NDAyMTY1#"
    let fullEventsURL = "https://api.seatgeek.com/2/events?client_id=MjE1MzUxODN8MTYxMjczMjM0NC45NDAyMTY1#"
    
    //queries the SeatGeek API for the user's search criteria
    func fetchEventsForSearchBar(searchInput: String) {
        let urlString = "\(eventsURL)?q=\(searchInput)&\(clientID)"
        performRequest(urlString: urlString)
    }
    
    //queries the SeatGeek API only using the assigned clientID
    func fetchAllEvents() {
        let urlString = fullEventsURL
        performRequest(urlString: urlString)
    }
    
    //starts networking session
    func performRequest(urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data  {
                    self.parse(json: safeData)
                }
            }
            task.resume()
        }
    }
    
    //parse data from the JSON
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let decodedData = try? decoder.decode(Events.self, from: json) {
            events = decodedData.events
        }
    }
}
