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
    var eventsManager = EventsManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
        
        eventsManager.fetchAllEvents(tableView: tableView)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
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
}

//MARK: - Table View Methods

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsManager.events.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! EventTableViewCell
        
        cell.update(indexPath: indexPath, eventsManager: eventsManager)
        
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
            eventsManager.fetchEventsForSearchBar(searchInput: searchInput, tableView: tableView)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        searchBar.resignFirstResponder()
    }
    
    //searches every time text is changed within the search bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let searchInput = searchBar.text {
            eventsManager.fetchEventsForSearchBar(searchInput: searchInput, tableView: tableView)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
}


