//
//  EventManager.swift
//  SeatGeek Project
//
//  Created by Molly Lowder on 02/07/21.
//

import Foundation


//struct EventManager {
//    let eventsURL = "https://api.seatgeek.com/2/events"
//    let clientID = "client_id=MjE1MzUxODN8MTYxMjczMjM0NC45NDAyMTY1#"
//
//    func fetchEventsForSearchBar(searchInput: String) {
//        let urlString = "\(eventsURL)?q=\(searchInput)&\(clientID)"
//        performRequest(urlString: urlString)
//    }
//
//    func fetchAllEvents() {
//        let urlString = "\(eventsURL)?\(clientID)"
//        performRequest(urlString: urlString)
//    }
//
//    func performRequest(urlString: String) {
//        if let url = URL(string: urlString) {
//            let session = URLSession(configuration: .default)
//            let task = session.dataTask(with: url) { (data, response, error) in
//                if error != nil {
//                    print(error!)
//                    return
//                }
//                if let safeData = data  {
//                    self.parseJSON(eventData: safeData)
//                }
//            }
//            task.resume()
//        }
//    }
//
//   func parseJSON(eventData: Data) {
//        let decoder = JSONDecoder()
//
//        do {
//            let decodedData: [Event] = try decoder.decode([Event].self, from: eventData)
//            print(decodedData.count)
//        } catch {
//            print(error)
//        }
//    }
    
    
//}
