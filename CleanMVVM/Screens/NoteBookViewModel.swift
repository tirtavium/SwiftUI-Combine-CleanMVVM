//
//  NoteBookViewModel.swift
//  CleanMVVM
//
//  Created by Tirta A Gunawan on 22/06/20.
//  Copyright © 2020 iOS Dev Team. All rights reserved.
//
import Combine
import Foundation


protocol NoteBookViewModelCommand: class {
    func fetchNotes()
    func saveNote()
    func deleteNote(index: Int)
    func refreshNoteTo(id: String?)
}
protocol NoteBookViewModelObservable: ObservableObject {
    var dataSource: [NoteRowModel] {get set}
    var note: String {get set}
    var showErrorMessage: Bool {get set}
    var errorMessage: String {get set}
}
class NoteBookViewModel: NoteBookPresenterOut, NoteBookViewModelObservable {
    
    
    @Published var note = ""
    @Published var showErrorMessage = false
    @Published var errorMessage = ""
    @Published var dataSource: [NoteRowModel] = []
    private var disposables = Set<AnyCancellable>()
    var interactor: NoteBookInteractorLogic?
    var editedNote: NoteRowModel?
    
    func displayFetchNotes(output: NoteBookLogicModel.FetchNotes.Output) {
        self.dataSource = output.models
    }
    
    func displaySaveNote(output: NoteBookLogicModel.SaveNote.Output) {
        if let message = output.errorMessage {
            errorMessage = message
            showErrorMessage = true
        }
    }
    
    func displayRemoveNote(output: NoteBookLogicModel.RemoveNote.Output) {
        if let message = output.errorMessage {
            errorMessage = message
            showErrorMessage = true
        }
    }
    
    
}

extension NoteBookViewModel: NoteBookViewModelCommand {
    
    func refreshNoteTo(id: String?){
        if let idNote = id {
            editedNote = dataSource.first(where: { (noteRowModel) -> Bool in
                noteRowModel.id == idNote
            })
            note = editedNote?.contain ?? ""
        }else{
            editedNote = nil
            note = ""
        }
    }
    
    func deleteNote(index: Int) {
        let deletedData = dataSource[index]
        interactor?.removeNote(input: NoteBookLogicModel.RemoveNote.Input(id: deletedData.id))
    }
    
    func fetchNotes(){
        interactor?.fetchNotes(input: NoteBookLogicModel.FetchNotes.Input())
    }
    func saveNote(){
        if editedNote == nil {
            interactor?.saveNote(input: NoteBookLogicModel.SaveNote.Input(id: nil, note: note))
        }else{
            interactor?.saveNote(input: NoteBookLogicModel.SaveNote.Input(id: editedNote?.id, note: note))
        }
        
    }
}




