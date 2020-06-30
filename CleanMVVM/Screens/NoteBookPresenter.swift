//
//  NoteBookPresenter.swift
//  CleanMVVM
//
//  Created by Tirta A Gunawan on 22/06/20.
//  Copyright © 2020 iOS Dev Team. All rights reserved.
//

import Foundation

protocol NoteBookPresenterLogic: class {
    func presentNotes(response: NoteBookLogicModel.FetchNotes.Response)
    func presentRemoveNote(response: NoteBookLogicModel.RemoveNote.Response)
    func presentSaveNote(response: NoteBookLogicModel.SaveNote.Response)
}
protocol NoteBookPresenterOut: class {
    func displayFetchNotes(viewModel: NoteBookLogicModel.FetchNotes.ViewModel)
    func displaySaveNote(viewModel: NoteBookLogicModel.SaveNote.ViewModel)
    func displayRemoveNote(viewModel: NoteBookLogicModel.RemoveNote.ViewModel)
}
class NoteBookPresenter: NoteBookPresenterLogic {
    
    var viewModel: NoteBookPresenterOut?
    
    
    func presentRemoveNote(response: NoteBookLogicModel.RemoveNote.Response) {
        switch response.error {
        case .data_not_found:
            viewModel?.displayRemoveNote(viewModel: NoteBookLogicModel.RemoveNote.ViewModel(errorMessage: "Note Not Found"))
        default:
            break
        }
    }
    
    func presentSaveNote(response: NoteBookLogicModel.SaveNote.Response) {
        switch response.error {
               case .error_min_length:
                   viewModel?.displaySaveNote(viewModel: NoteBookLogicModel.SaveNote.ViewModel(errorMessage: "Minimum Note Length is 6"))
               default:
                   break
               }
    }
    
    
    func presentNotes(response: NoteBookLogicModel.FetchNotes.Response) {
        
        let models = response.notes.map { (note) -> NoteRowModel in
                   NoteRowModel(title: note.title, id: note.id, contain: note.contain)
               }
               viewModel?.displayFetchNotes(viewModel: NoteBookLogicModel.FetchNotes.ViewModel(models: models, errorMessage: nil))
    }
    
    
    

    
}
