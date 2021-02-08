//
//  DetailViewController.swift
//  SeatGeek Project
//
//  Created by Molly Lowder on 02/06/21.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var eventDateLabel: UILabel!
    @IBOutlet weak var eventTimeLabel: UILabel!
    @IBOutlet weak var eventLocationLabel: UILabel!
    @IBOutlet weak var eventFavoriteIcon: UIButton!
    var eventTitle: String = ""
    var eventImage: UIImage = UIImage(named: "testImage")!
    var eventDate: String = ""
    var eventTime: String = ""
    var eventLocation: String = ""
    var isFavorited: Bool = false
    var id: String = ""

    //changes appearance of the heart icon when tapped, saves the 'favorite' into User Defaults
    @IBAction func isFavorited(_ sender: UIButton) {
        
        isFavorited = !isFavorited
        
        if isFavorited == true {
            sender.setImage(UIImage(named: "smallFavorite"), for: .normal)
            UserDefaults.standard.set(isFavorited, forKey: "\(id)")
            print(isFavorited)
        } else {
            sender.setImage(UIImage(named: "smallNotFavorite"), for: .normal)
            UserDefaults.standard.set(isFavorited, forKey: "\(id)")
        }
    }

    //sends the user back to the main view
    @IBAction func backButton(_ sender: UIButton) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
        eventImageView.layer.cornerRadius = eventImageView.frame.size.height / 10
        
        eventTitleLabel?.text = eventTitle
        eventImageView?.image = eventImage
        eventDateLabel?.text = eventDate
        eventTimeLabel?.text = eventTime
        eventLocationLabel?.text = eventLocation
        if isFavorited == true {
            eventFavoriteIcon?.setImage(UIImage(named: "smallFavorite"), for: .normal)
        } else {
            eventFavoriteIcon?.setImage(UIImage(named: "smallNotFavorite"), for: .normal)
        }
        
    }
    
}
