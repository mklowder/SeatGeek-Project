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
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if
            let senderCell = sender as? EventTableViewCell,
            let newController = segue.destination as? DetailViewController {
                newController.eventTitle = senderCell.eventTitle.text ?? ""
                newController.eventImage = senderCell.eventImage.image ?? UIImage(systemName: "camera")!
                newController.eventDate = senderCell.eventDate.text ?? ""
                newController.eventTime = senderCell.eventTime.text ?? ""
                newController.eventLocation = senderCell.eventLocation.text ?? ""
                newController.isFavorited = true
            }
        
    }
   
//MARK: - Managing API Calls

    let eventsURL = "https://api.seatgeek.com/2/events"
    let clientID = "client_id=MjE1MzUxODN8MTYxMjczMjM0NC45NDAyMTY1#"
    let fullEventsURL = "https://api.seatgeek.com/2/events?client_id=MjE1MzUxODN8MTYxMjczMjM0NC45NDAyMTY1#"
    
    func fetchEventsForSearchBar(searchInput: String) {
        let urlString = "\(eventsURL)?q=\(searchInput)&\(clientID)"
        performRequest(urlString: urlString)
    }
    
    func fetchAllEvents() {
        let urlString = fullEventsURL
        performRequest(urlString: urlString)
    }
    
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
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let decodedData = try? decoder.decode(Events.self, from: json) {
            events = decodedData.events
            print(events)
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
        
        cell.eventTitle.text = events[indexPath.row].title
        cell.eventImage.image = events[indexPath.row].getImage(from: events[indexPath.row].performers[0].image)
        cell.eventLocation.text = events[indexPath.row].venue.display_location
        cell.eventDate.text = events[indexPath.row].datetime_local
       // cell.eventTime.text = events[indexPath.row].time
        
        cell.eventImage.layer.cornerRadius = cell.eventImage.frame.size.height / 5
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//
//    }
   
}

//MARK: - Search Bar Methods

extension ViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if let searchInput = searchBar.text {
            fetchEventsForSearchBar(searchInput: searchInput)
        }
    }
    
}


