//
//  NoteService.swift
//  CleanMVVM
//
//  Created by Tirta A Gunawan on 22/06/20.
//  Copyright © 2020 iOS Dev Team. All rights reserved.
//

import Foundation

protocol NoteService {
    func fetchNotes(completionHandler: @escaping ([Note], NoteServiceError?) -> Void)
    func saveNote(note: Note, completionHandler: @escaping (Result<String,NoteServiceError>) -> Void)
    func deleteNote(id: String, completionHandler: @escaping (Result<String,NoteServiceError>) -> Void)
}

class NoteServiceDummy : NoteService {
    
    var dummyNotes = [Note(id: UUID().uuidString,title: "First Title", contain: "This is First", timestamp: Date()),Note(id: UUID().uuidString,title: "Second Title", contain: "This is Second", timestamp: Date())]
    
    func deleteNote(id: String, completionHandler: @escaping (Result<String, NoteServiceError>) -> Void) {
        DispatchQueue.main.async {
            
            let targetNote = self.dummyNotes.first { (note) -> Bool in
                note.id == id
            }
            if let noteToBeDelete = targetNote {
                if let idx = self.dummyNotes.firstIndex(of:noteToBeDelete) {
                    self.dummyNotes.remove(at: idx)
                    completionHandler(.success("note deleted"))
                }
            }else{
                completionHandler(.failure(NoteServiceError.data_not_found))
            }
            
        }
    }
    
    func saveNote(note: Note, completionHandler: @escaping (Result<String, NoteServiceError>) -> Void) {
        DispatchQueue.main.async {

            if let existingNote = self.dummyNotes.first(where: { (noteFromDummy) -> Bool in
                noteFromDummy.id == note.id
            }) {
                self.deleteNote(id: existingNote.id) { (result) in
                    if result == .success("note deleted") {
                        self.dummyNotes.append(note)
                        completionHandler(.success("success"))
                    }else{
                        completionHandler(result)
                    }
                }
            }else{
                self.dummyNotes.append(note)
                completionHandler(.success("success"))
            }}
    }
    
    
    func fetchNotes(completionHandler: @escaping ([Note], NoteServiceError?) -> Void) {
        
        DispatchQueue.main.async {
            completionHandler(self.dummyNotes,nil)
        }
    }
}

enum NoteServiceError: Error{
    case error_min_length
    case data_not_found
}
