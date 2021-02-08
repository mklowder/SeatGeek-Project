//
//  ViewController.swift
//  SeatGeek Project
//
//  Created by Molly Lowder on 02/05/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var events = [Event]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
        
        fetchAllEvents()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        if let index = self.tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: index, animated: true)
        }
        navigationController?.isNavigationBarHidden = false
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    //passes over data to DetailView from chosen Event object
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if
            let senderCell = sender as? EventTableViewCell,
            let newController = segue.destination as? DetailViewController {
                newController.eventTitle = senderCell.eventTitle.text ?? ""
            if #available(iOS 13.0, *) {
                newController.eventImage = senderCell.eventImage.image ?? UIImage(systemName: "camera")!
            } else {
                newController.eventImage = senderCell.eventImage.image ?? UIImage(named: "camera")!
            }
                newController.eventDate = senderCell.eventDate.text ?? ""
                newController.eventTime = senderCell.eventTime.text ?? ""
                newController.eventLocation = senderCell.eventLocation.text ?? ""
                if senderCell.isFavorited == false {
                    newController.isFavorited = false
                } else {
                    newController.isFavorited = true
                }
                newController.id = senderCell.eventID
            }
        
    }
   
//MARK: - Managing API Calls

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
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
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
        
        let isEventFavorited = UserDefaults.standard.bool(forKey: "\(events[indexPath.row].makeIDString(id: events[indexPath.row].id))")
        events[indexPath.row].isFavorited = isEventFavorited
        
        cell.favoriteIcon.image = UIImage(named: "smallFavorite")
        
        cell.eventTitle.text = events[indexPath.row].title
        cell.eventImage.image = events[indexPath.row].getImage(from: events[indexPath.row].performers[0].image)
        cell.eventLocation.text = events[indexPath.row].venue.display_location
        cell.eventDate.text = events[indexPath.row].getDate(datetime_local: events[indexPath.row].datetime_local)
        if events[indexPath.row].time_tbd == true {
            cell.eventTime.text = "TBD"
        } else {
            cell.eventTime.text = events[indexPath.row].getTime(datetime_local: events[indexPath.row].datetime_local)
        }
        if isEventFavorited == false {
            cell.favoriteIcon.isHidden = true
            cell.isFavorited = false
        } else {
            cell.isFavorited = true
            cell.favoriteIcon.isHidden = false
        }
        cell.eventID = events[indexPath.row].makeIDString(id: events[indexPath.row].id)

        cell.eventImage.layer.cornerRadius = cell.eventImage.frame.size.height / 5
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.reloadData()
    }
   
}

//MARK: - Search Bar Methods

extension ViewController: UISearchBarDelegate {
    
    //kicks off query for user's search criteria; dismisses keyboard once search is submitted
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if let searchInput = searchBar.text {
            fetchEventsForSearchBar(searchInput: searchInput)
        }
        searchBar.resignFirstResponder()
    }
    
    //searches every time text is changed within the search bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let searchInput = searchBar.text {
            fetchEventsForSearchBar(searchInput: searchInput)
        }
    }
    
}


