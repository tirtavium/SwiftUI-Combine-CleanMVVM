//
//  Note.swift
//  CleanMVVM
//
//  Created by Tirta A Gunawan on 22/06/20.
//  Copyright © 2020 iOS Dev Team. All rights reserved.
//

import Foundation
struct Note: Codable, Equatable {
    var id: String
    var title: String
    var contain: String
    var timestamp: Date
    
}

class NoteBuilder{
    func build() -> Note{
       return Note(id: id, title: title, contain: contain, timestamp: Date())
    }
    
    let title: String
    let id: String
    let contain: String
    init(id: String?, contain: String, title: String) {
        self.id = id ?? UUID().uuidString
        self.contain = contain
        self.title = title
    }
   
    
}
