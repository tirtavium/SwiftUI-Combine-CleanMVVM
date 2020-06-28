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
    
    func retrieveNotes(models: [NoteRowModel]) {
        self.dataSource = models
    }
    
    func displayError(message: String) {
        errorMessage = message
        showErrorMessage = true
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
        interactor?.removeNote(id: deletedData.id)
    }
    
    func fetchNotes(){
        interactor?.fetchNotes()
    }
    func saveNote(){
        if editedNote == nil {
            interactor?.saveNote(id: nil, note: note)
        }else{
            interactor?.saveNote(id: editedNote?.id, note: note)
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



