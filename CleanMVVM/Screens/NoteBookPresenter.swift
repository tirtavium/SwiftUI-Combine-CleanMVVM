//
//  NoteBookPresenter.swift
//  CleanMVVM
//
//  Created by Tirta A Gunawan on 22/06/20.
//  Copyright © 2020 iOS Dev Team. All rights reserved.
//

import Foundation

protocol NoteBookPresenterLogic: class {
    func presentNotes(notes: [Note])
    func presentError(error: NoteBookInteractorLogicError)
}
protocol NoteBookPresenterOut: class {
    func retrieveNotes(models: [NoteRowModel])
    func displayError(message: String)
}
class NoteBookPresenter: NoteBookPresenterLogic {
    
    var viewModel: NoteBookPresenterOut?
    
    func presentNotes(notes: [Note]) {
        let models = notes.map { (note) -> NoteRowModel in
            NoteRowModel(title: note.title, id: note.id, contain: note.contain)
        }
        viewModel?.retrieveNotes(models: models)
    }
    
    func presentError(error: NoteBookInteractorLogicError) {
        switch error {
        case .data_not_found:
            viewModel?.displayError(message: "Note Not Found")
        case .error_min_length:
            viewModel?.displayError(message: "Minimum Length is 6")
        }
    }
    
}
