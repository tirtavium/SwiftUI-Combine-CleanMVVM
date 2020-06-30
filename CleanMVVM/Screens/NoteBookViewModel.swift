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
    
    func displayFetchNotes(viewModel: NoteBookLogicModel.FetchNotes.ViewModel) {
        self.dataSource = viewModel.models
    }
    
    func displaySaveNote(viewModel: NoteBookLogicModel.SaveNote.ViewModel) {
        if let message = viewModel.errorMessage {
            errorMessage = message
            showErrorMessage = true
        }
    }
    
    func displayRemoveNote(viewModel: NoteBookLogicModel.RemoveNote.ViewModel) {
        if let message = viewModel.errorMessage {
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
        interactor?.removeNote(request: NoteBookLogicModel.RemoveNote.Request(id: deletedData.id))
    }
    
    func fetchNotes(){
        interactor?.fetchNotes(request: NoteBookLogicModel.FetchNotes.Request())
    }
    func saveNote(){
        if editedNote == nil {
            interactor?.saveNote(request: NoteBookLogicModel.SaveNote.Request(id: nil, note: note))
        }else{
            interactor?.saveNote(request: NoteBookLogicModel.SaveNote.Request(id: editedNote?.id, note: note))
        }
        
    }
}




