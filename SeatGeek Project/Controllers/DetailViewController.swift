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
    var eventTitle: String = ""
    var eventImage: UIImage = UIImage(named: "testImage")!
    var eventDate: String = ""
    var eventTime: String = ""
    var eventLocation: String = ""
    var isFavorited = false

    @IBAction func isFavorited(_ sender: UIButton) {
        
        isFavorited = !isFavorited
        
        if isFavorited == true {
            sender.setImage(UIImage(named: "smallFavorite"), for: .normal)
            
        } else {
            sender.setImage(UIImage(named: "smallNotFavorite"), for: .normal)
        }
    }

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
    }
    
}
