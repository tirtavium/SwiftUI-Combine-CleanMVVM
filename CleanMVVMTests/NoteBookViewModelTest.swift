//
//  NoteBookViewModelTest.swift
//  CleanMVVMTests
//
//  Created by Tirta A Gunawan on 28/06/20.
//  Copyright © 2020 iOS Dev Team. All rights reserved.
//

import Foundation
import XCTest
@testable import CleanMVVM

class NoteBookViewModelTest: XCTestCase{
    
    var viewModel: NoteBookViewModel!
    var interactorSpy: NoteBookInteractorSpy!
    
    override func setUp() {
        interactorSpy = NoteBookInteractorSpy()
        viewModel = NoteBookViewModel()
        viewModel.interactor = interactorSpy
        viewModel.dataSource = [NoteRowModel(title: "", id: "", contain: "")]
    }
    
    func test_FetchNotes_Success() {
        viewModel.fetchNotes()
        XCTAssertTrue(interactorSpy.fetchNotesCalled)
    }
    
    func test_SaveNote_Success() {
        viewModel.saveNote()
        XCTAssertTrue(interactorSpy.saveNoteCalled)
    }
    
    func test_RemoveNote_Success() {
        viewModel.deleteNote(index: 0)
        XCTAssertTrue(interactorSpy.removeNoteCalled)

    }
    
    
}

class NoteBookInteractorSpy: NoteBookInteractorLogic {
    var fetchNotesCalled = false
    var saveNoteCalled = false
    var removeNoteCalled = false
    
    func fetchNotes() {
        fetchNotesCalled = true
    }
    
    func saveNote(id: String?, note: String) {
        saveNoteCalled = true
    }
    
    func removeNote(id: String) {
        removeNoteCalled = true
    }
    
    
}
