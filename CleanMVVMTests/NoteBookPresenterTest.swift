//
//  NoteBookPresenterTest.swift
//  CleanMVVMTests
//
//  Created by Tirta A Gunawan on 28/06/20.
//  Copyright © 2020 iOS Dev Team. All rights reserved.
//

import Foundation
import XCTest
@testable import CleanMVVM

class NoteBookPresenterTest: XCTestCase{
    
    var presenter: NoteBookPresenter!
    var viewModelSpy: NoteBookPresenterOutSpy!
    
    override func setUp() {
        viewModelSpy = NoteBookPresenterOutSpy()
        presenter = NoteBookPresenter()
        presenter.viewModel = viewModelSpy
    }
    
    func test_PresentNotes_Success() {
        presenter.presentNotes(present: NoteBookLogicModel.FetchNotes.Present(
            notes: [NoteBuilder.init(id: nil, contain: "Test", title: "Title").build()],
            error: nil))
        XCTAssertTrue(viewModelSpy.retrieveNotesCalled)
    }
    
    func test_PresentError_Success(){
        
        presenter.presentRemoveNote(present: NoteBookLogicModel.RemoveNote.Present(error: NoteBookInteractorLogicError.data_not_found))
        XCTAssertTrue(viewModelSpy.displayErrorCalled)
        XCTAssertTrue(viewModelSpy.errorMessage == "Note Not Found")
        
        presenter.presentSaveNote(present: NoteBookLogicModel.SaveNote.Present(error: NoteBookInteractorLogicError.error_min_length))
        XCTAssertTrue(viewModelSpy.displayErrorCalled)
        XCTAssertTrue(viewModelSpy.errorMessage == "Minimum Note Length is 6")
        
    }
    
}

class NoteBookPresenterOutSpy: NoteBookPresenterOut{
    var retrieveNotesCalled = false
    var displayErrorCalled = false
    var errorMessage = ""
    
    
    func displayFetchNotes(output: NoteBookLogicModel.FetchNotes.Output) {
        retrieveNotesCalled = true
    }
    
    func displaySaveNote(output: NoteBookLogicModel.SaveNote.Output) {
        if let message = output.errorMessage  {
            displayErrorCalled = true
            errorMessage = message
        }
    }
    
    func displayRemoveNote(output: NoteBookLogicModel.RemoveNote.Output) {
        if let message = output.errorMessage  {
            displayErrorCalled = true
            errorMessage = message
        }
    }
    
    
    
    
}
