//
//  PlaceModel.swift
//  vnlook
//
//  Created by Nguyễn Minh Tâm on 09/01/2024.
//

import UIKit
class PlaceModel {
    var name: String = ""
    var location: String = ""
    var description: String = ""
    var rating: Double = 0
    var price: Double = 0
    
    init() {
        self.name = "Dragon Bridge"
        self.location = "Da Nang"
        self.description = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi egestas et nunc eget elementum. Nunc eros metus, suscipit quis lorem eget, interdum pellentesque elit. Nulla nisi justo, fringilla non congue ut, hendrerit a arcu. Maecenas interdum eros lectus"
        self.rating = 5.0
        self.price = 100
    }
    
}
