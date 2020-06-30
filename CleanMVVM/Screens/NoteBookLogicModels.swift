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
        struct Input  {
            var id: String
        }
        struct Present {
            var error: NoteBookInteractorLogicError?
        }
        struct Output {
            var errorMessage: String?
        }
    }
    enum SaveNote {
        struct Input {
            var id: String?
            var note: String
        }
        struct Present {
            var error: NoteBookInteractorLogicError?
        }
        struct Output {
            var errorMessage: String?
        }
        
    }
    enum FetchNotes {
        struct Input {
        }
        struct Present {
            var notes: [Note]
            var error: NoteBookInteractorLogicError?
        }
        struct Output {
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

