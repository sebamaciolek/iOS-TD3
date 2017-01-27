//
//  Event.swift
//  Pods
//
//  Created by MACIOLEK Sebastian and LANDRAUDIE Marine on 23/01/2017.
//
//

import Foundation

class Event {
    var id = Int()
    var dateHeure = Date()
    var nom = String()
    var flyer = URL(string: "")
    
    init(id: Int, dateHeure: Date, nom: String, flyer: URL){
        self.id = id
        self.dateHeure = dateHeure
        self.nom = nom
        self.flyer = flyer
    }
}

