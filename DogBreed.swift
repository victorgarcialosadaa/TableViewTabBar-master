//
//  Pokemon.swift
//  TableViewTabBar
//
//  Created by dmorenoar on 22/12/18.
//  Copyright © 2018 DAM. All rights reserved.
//
// id,name,section,provisional,country,url,image,pdf

import Foundation
import UIKit

class dogBreed : CustomStringConvertible{
    var id:String
    var name:String
    var country:String
    var image:String
    
    init(id:String, name:String, country:String, image:String) {
        self.id = id
        self.name = name
        self.country = country
        self.image = image
    }
    func getName() -> String {
        return name}
    
    var description : String {
        return "Id:\(id),Name:\(name),Country:\(country),Image:\(image)"
    }
    
}


