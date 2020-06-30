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
        presenter.presentNotes(response: NoteBookLogicModel.FetchNotes.Response(
            notes: [NoteBuilder.init(id: nil, contain: "Test", title: "Title").build()],
            error: nil))
        XCTAssertTrue(viewModelSpy.retrieveNotesCalled)
    }
    
    func test_PresentError_Success(){
        
        presenter.presentRemoveNote(response: NoteBookLogicModel.RemoveNote.Response(error: NoteBookInteractorLogicError.data_not_found))
        XCTAssertTrue(viewModelSpy.displayErrorCalled)
        XCTAssertTrue(viewModelSpy.errorMessage == "Note Not Found")
        
        presenter.presentSaveNote(response: NoteBookLogicModel.SaveNote.Response(error: NoteBookInteractorLogicError.error_min_length))
        XCTAssertTrue(viewModelSpy.displayErrorCalled)
        XCTAssertTrue(viewModelSpy.errorMessage == "Minimum Note Length is 6")
        
    }
    
}

class NoteBookPresenterOutSpy: NoteBookPresenterOut{
    var retrieveNotesCalled = false
    var displayErrorCalled = false
    var errorMessage = ""
    
    
    func displayFetchNotes(viewModel: NoteBookLogicModel.FetchNotes.ViewModel) {
        retrieveNotesCalled = true
    }
    
    func displaySaveNote(viewModel: NoteBookLogicModel.SaveNote.ViewModel) {
        if let message = viewModel.errorMessage  {
            displayErrorCalled = true
            errorMessage = message
        }
    }
    
    func displayRemoveNote(viewModel: NoteBookLogicModel.RemoveNote.ViewModel) {
        if let message = viewModel.errorMessage  {
            displayErrorCalled = true
            errorMessage = message
        }
    }
    
    
    
    
}
