//
//  EventTableViewswift
//  SeatGeek Project
//
//  Created by Molly Lowder on 02/05/21.
//

import Foundation
import UIKit

class EventTableViewCell: UITableViewCell {

    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventLocation: UILabel!
    @IBOutlet weak var eventDate: UILabel!
    @IBOutlet weak var eventTime: UILabel!
    @IBOutlet weak var favoriteIcon: UIImageView!
    var eventID: String = ""
    var isFavorited: Bool = false
    var indexPath: IndexPath = []
    var eventsManager: EventsManager?
    
    func update(indexPath: IndexPath, eventsManager: EventsManager) {
        
        self.indexPath = indexPath
        self.eventsManager = eventsManager
        
        let isEventFavorited = UserDefaults.standard.bool(forKey: "\(eventsManager.events[indexPath.row].makeIDString(id: eventsManager.events[indexPath.row].id))")
        
        eventsManager.events[indexPath.row].isFavorited = isEventFavorited
        
        favoriteIcon.image = UIImage(named: "smallFavorite")
        
        eventTitle.text = eventsManager.events[indexPath.row].title
        eventImage.image = eventsManager.events[indexPath.row].getImage(from: eventsManager.events[indexPath.row].performers[0].image)
        eventLocation.text = eventsManager.events[indexPath.row].venue.display_location
        eventDate.text = eventsManager.events[indexPath.row].getDate(datetime_local: eventsManager.events[indexPath.row].datetime_local)
        if eventsManager.events[indexPath.row].time_tbd == true {
            eventTime.text = "TBD"
        } else {
            eventTime.text = eventsManager.events[indexPath.row].getTime(datetime_local: eventsManager.events[indexPath.row].datetime_local)
        }
        if isEventFavorited == false {
            favoriteIcon.isHidden = true
            isFavorited = false
        } else {
            isFavorited = true
            favoriteIcon.isHidden = false
        }
        eventID = eventsManager.events[indexPath.row].makeIDString(id: eventsManager.events[indexPath.row].id)

        eventImage.layer.cornerRadius = eventImage.frame.size.height / 5
    }

}
