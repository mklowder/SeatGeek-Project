//
//  ViewController.swift
//  SeatGeek Project
//
//  Created by Molly Lowder on 02/05/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var events: [Event] = [
        Event(image: UIImage(named: "testImage")!, eventTitle: "Los Angeles Rams at Tampa Bay Buccaneers", location: "Tampa, FL", date: "Tuesday, 24 Nov 2020", time: "01:15 AM", isFavorited: false),
        Event(image: UIImage(named: "testImage")!, eventTitle: "Atlanta Falcons at New Orleans Saints", location: "New Orleans, LA", date: "Tuesday, 24 Nov 2020", time: "06:00 PM", isFavorited: false),
        Event(image: UIImage(named: "testImage")!, eventTitle: "New Mexico Lobos at Utah State Aggies Football", location: "Logan, UT", date: "Thursday, 26 Nov 2020", time: "10:30 AM", isFavorited: false)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
   }

    
}

//MARK: - Table View Methods

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return events.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! EventTableViewCell
        
        cell.eventTitle.text = events[indexPath.row].eventTitle
        cell.eventImage.image = events[indexPath.row].image
        cell.eventLocation.text = events[indexPath.row].location
        cell.eventDate.text = events[indexPath.row].date
        cell.eventTime.text = events[indexPath.row].time
        
        cell.eventImage.layer.cornerRadius = cell.eventImage.frame.size.height / 5
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        var selectedEvent = events[indexPath.row]
//    }
   
}

//MARK: - Search Bar Methods

extension ViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("the search bar button has been clicked")
        //query from realm 
    }
    
}
