//
//  EventDetailView.swift
//  SeatGeek Project
//
//  Created by Molly Lowder on 02/06/21.
//

import Foundation
import UIKit

class EventDetailView: UIView {
    
    @IBAction func favoriteButtonPressed(_ sender: UIBarButtonItem) {
        if sender.image == UIImage(named: "smallFavorite") {
            sender.image = UIImage(named: "smallNotFavorite")
        }
        if sender.image == UIImage(named: "smallNotFavorite") {
            sender.image = UIImage(named: "smallFavorite")
        }
    }
    
}

