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
        presenter.presentNotes(notes: [NoteBuilder.init(id: nil, contain: "Test", title: "Title").build()])
        XCTAssertTrue(viewModelSpy.retrieveNotesCalled)
    }
    
    func test_PresentError_Success(){
        
        presenter.presentError(error: NoteBookInteractorLogicError.data_not_found)
        XCTAssertTrue(viewModelSpy.displayErrorCalled)
        XCTAssertTrue(viewModelSpy.errorMessage == "Note Not Found")
        
        presenter.presentError(error: NoteBookInteractorLogicError.error_min_length)
        XCTAssertTrue(viewModelSpy.displayErrorCalled)
        XCTAssertTrue(viewModelSpy.errorMessage == "Minimum Length is 6")
        
    }
    
}

class NoteBookPresenterOutSpy: NoteBookPresenterOut{
    var retrieveNotesCalled = false
    var displayErrorCalled = false
    var errorMessage = ""
    func retrieveNotes(models: [NoteRowModel]) {
        retrieveNotesCalled = true
    }
    
    func displayError(message: String) {
        displayErrorCalled = true
        errorMessage = message
    }
    
    
}
