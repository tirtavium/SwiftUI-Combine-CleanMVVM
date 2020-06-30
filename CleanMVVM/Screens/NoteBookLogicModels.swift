//
//  NoteBookLogicModels.swift
//  CleanMVVM
//
//  Created by Tirta A Gunawan on 30/06/20.
//  Copyright © 2020 iOS Dev Team. All rights reserved.
//

import Foundation

enum NoteBookLogicModel{
    
    enum RemoveNote {
        struct Request  {
            var id: String
        }
        struct Response {
            var error: NoteBookInteractorLogicError?
        }
        struct ViewModel {
            var errorMessage: String?
        }
    }
    enum SaveNote {
        struct Request {
            var id: String?
            var note: String
        }
        struct Response {
            var error: NoteBookInteractorLogicError?
        }
        struct ViewModel {
            var errorMessage: String?
        }
        
    }
    enum FetchNotes {
        struct Request {
        }
        struct Response {
            var notes: [Note]
            var error: NoteBookInteractorLogicError?
        }
        struct ViewModel {
            var models: [NoteRowModel]
            var errorMessage: String?
        }
    }
    
}

struct NoteRowModel {
    var title: String
    var id: String
    var contain: String
}
extension NoteRowModel: Hashable {
    static func == (lhs: NoteRowModel, rhs: NoteRowModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}

