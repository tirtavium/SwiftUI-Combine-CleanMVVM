//
//  NoteBookPresenter.swift
//  CleanMVVM
//
//  Created by Tirta A Gunawan on 22/06/20.
//  Copyright © 2020 iOS Dev Team. All rights reserved.
//

import Foundation

protocol NoteBookPresenterLogic: class {
    func presentNotes(present: NoteBookLogicModel.FetchNotes.Present)
    func presentRemoveNote(present: NoteBookLogicModel.RemoveNote.Present)
    func presentSaveNote(present: NoteBookLogicModel.SaveNote.Present)
}
protocol NoteBookPresenterOut: class {
    func displayFetchNotes(output: NoteBookLogicModel.FetchNotes.Output)
    func displaySaveNote(output: NoteBookLogicModel.SaveNote.Output)
    func displayRemoveNote(output: NoteBookLogicModel.RemoveNote.Output)
}
class NoteBookPresenter: NoteBookPresenterLogic {
    
    var viewModel: NoteBookPresenterOut?
    
    
    func presentRemoveNote(present: NoteBookLogicModel.RemoveNote.Present) {
        switch present.error {
        case .data_not_found:
            viewModel?.displayRemoveNote(output: NoteBookLogicModel.RemoveNote.Output(errorMessage: "Note Not Found"))
        default:
            break
        }
    }
    
    func presentSaveNote(present: NoteBookLogicModel.SaveNote.Present) {
        switch present.error {
               case .error_min_length:
                   viewModel?.displaySaveNote(output: NoteBookLogicModel.SaveNote.Output(errorMessage: "Minimum Note Length is 6"))
               default:
                   break
               }
    }
    
    
    func presentNotes(present: NoteBookLogicModel.FetchNotes.Present) {
        
        let models = present.notes.map { (note) -> NoteRowModel in
                   NoteRowModel(title: note.title, id: note.id, contain: note.contain)
               }
               viewModel?.displayFetchNotes(output: NoteBookLogicModel.FetchNotes.Output(models: models, errorMessage: nil))
    }
    
    
    

    
}
