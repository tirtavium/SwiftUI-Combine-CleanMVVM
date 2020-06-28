//
//  NoteBookInteractor.swift
//  CleanMVVM
//
//  Created by Tirta A Gunawan on 22/06/20.
//  Copyright © 2020 iOS Dev Team. All rights reserved.
//

import Foundation

protocol NoteBookInteractorLogic: class {
    func fetchNotes()
    func saveNote(id: String?, note: String)
    func removeNote(id: String)
}

class NoteBookInteractor: NoteBookInteractorLogic{

    let noteService: NoteService
    var presenter: NoteBookPresenterLogic?
    
    init(noteService: NoteService) {
        self.noteService = noteService
    }
    
    
    func removeNote(id: String) {
        noteService.deleteNote(id: id) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(_):
                self.fetchNotes()
            case .failure(let error):
                print(error)
                if error == .data_not_found {
                    self.presenter?.presentError(error: NoteBookInteractorLogicError.data_not_found)
                }
            }
        }
    }
    
    
    
    func saveNote(id: String?, note: String) {
        var noteModel: Note!
        
        if note.count > 6 {
            noteModel = NoteBuilder.init(id: id, contain: note, title: String(note.prefix(6))).build()
        }else{
            self.presenter?.presentError(error: NoteBookInteractorLogicError.error_min_length)
            return
        }
        noteService.saveNote(note: noteModel) {[weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(_):
                self.fetchNotes()
            case .failure(let error):
                print(error)
            }
        }
    }

    func fetchNotes() {
        
        noteService.fetchNotes { [weak self] (notes, error) in
            guard let self = self else { return }
            if error == nil {
                self.presenter?.presentNotes(notes: notes)
            }else{
                
            }
        }
        
    }
}
enum NoteBookInteractorLogicError: Error {
    case error_min_length
    case data_not_found
}
