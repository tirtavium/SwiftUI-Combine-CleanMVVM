//
//  NoteBookInteractor.swift
//  CleanMVVM
//
//  Created by Tirta A Gunawan on 22/06/20.
//  Copyright © 2020 iOS Dev Team. All rights reserved.
//

import Foundation

protocol NoteBookInteractorLogic: class {
    func fetchNotes(request: NoteBookLogicModel.FetchNotes.Request)
    func saveNote(request: NoteBookLogicModel.SaveNote.Request)
    func removeNote(request: NoteBookLogicModel.RemoveNote.Request)
}

class NoteBookInteractor: NoteBookInteractorLogic{
    
    
    let noteService: NoteService
    var presenter: NoteBookPresenterLogic?
    
    init(noteService: NoteService) {
        self.noteService = noteService
    }
    
    func fetchNotes(request: NoteBookLogicModel.FetchNotes.Request) {
        
        noteService.fetchNotes { [weak self] (notes, error) in
                 guard let self = self else { return }
                 if error == nil {
                     self.presenter?.presentNotes(response: NoteBookLogicModel.FetchNotes.Response(notes: notes, error: nil))
                 }else{
                     
                 }
             }
    }
    
    func saveNote(request: NoteBookLogicModel.SaveNote.Request) {
        var noteModel: Note!
        
        if request.note.count > 6 {
            noteModel = NoteBuilder.init(id: request.id, contain: request.note, title: String(request.note.prefix(6))).build()
        }else{
            self.presenter?.presentSaveNote(response: NoteBookLogicModel.SaveNote.Response(error: NoteBookInteractorLogicError.error_min_length))
            return
        }
        noteService.saveNote(note: noteModel) {[weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(_):
                self.fetchNotes(request: NoteBookLogicModel.FetchNotes.Request())
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func removeNote(request: NoteBookLogicModel.RemoveNote.Request) {
        
        noteService.deleteNote(id: request.id) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(_):
                self.fetchNotes(request: NoteBookLogicModel.FetchNotes.Request())
            case .failure(let error):
                print(error)
                if error == .data_not_found {
                    self.presenter?.presentRemoveNote(response: NoteBookLogicModel.RemoveNote.Response(error: NoteBookInteractorLogicError.data_not_found))
                }
            }
        }
    }
    
    
}
enum NoteBookInteractorLogicError: Error {
    case error_min_length
    case data_not_found
}
