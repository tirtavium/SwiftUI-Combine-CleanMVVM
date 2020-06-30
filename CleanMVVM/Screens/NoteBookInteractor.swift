//
//  NoteBookInteractor.swift
//  CleanMVVM
//
//  Created by Tirta A Gunawan on 22/06/20.
//  Copyright © 2020 iOS Dev Team. All rights reserved.
//

import Foundation

protocol NoteBookInteractorLogic: class {
    func fetchNotes(input: NoteBookLogicModel.FetchNotes.Input)
    func saveNote(input: NoteBookLogicModel.SaveNote.Input)
    func removeNote(input: NoteBookLogicModel.RemoveNote.Input)
}

class NoteBookInteractor: NoteBookInteractorLogic{
    
    
    let noteService: NoteService
    var presenter: NoteBookPresenterLogic?
    
    init(noteService: NoteService) {
        self.noteService = noteService
    }
    
    func fetchNotes(input: NoteBookLogicModel.FetchNotes.Input) {
        
        noteService.fetchNotes { [weak self] (notes, error) in
                 guard let self = self else { return }
                 if error == nil {
                     self.presenter?.presentNotes(present: NoteBookLogicModel.FetchNotes.Present(notes: notes, error: nil))
                 }else{
                     
                 }
             }
    }
    
    func saveNote(input: NoteBookLogicModel.SaveNote.Input) {
        var noteModel: Note!
        
        if input.note.count > 6 {
            noteModel = NoteBuilder.init(id: input.id, contain: input.note, title: String(input.note.prefix(6))).build()
        }else{
            self.presenter?.presentSaveNote(present: NoteBookLogicModel.SaveNote.Present(error: NoteBookInteractorLogicError.error_min_length))
            return
        }
        noteService.saveNote(note: noteModel) {[weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(_):
                self.fetchNotes(input: NoteBookLogicModel.FetchNotes.Input())
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func removeNote(input: NoteBookLogicModel.RemoveNote.Input) {
        
        noteService.deleteNote(id: input.id) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(_):
                self.fetchNotes(input: NoteBookLogicModel.FetchNotes.Input())
            case .failure(let error):
                print(error)
                if error == .data_not_found {
                    self.presenter?.presentRemoveNote(present: NoteBookLogicModel.RemoveNote.Present(error: NoteBookInteractorLogicError.data_not_found))
                }
            }
        }
    }
    
    
}
enum NoteBookInteractorLogicError: Error {
    case error_min_length
    case data_not_found
}
