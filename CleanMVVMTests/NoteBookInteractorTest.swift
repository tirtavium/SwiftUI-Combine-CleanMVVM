//
//  NoteBookInteractorTest.swift
//  CleanMVVMTests
//
//  Created by Tirta A Gunawan on 28/06/20.
//  Copyright © 2020 iOS Dev Team. All rights reserved.
//

import Foundation
import XCTest
@testable import CleanMVVM

class NoteBookInteractorTest: XCTestCase{
    
    var interactor: NoteBookInteractor!
    var noteServiceSpy: NoteServiceSpy!
    var presenterSpy: NoteBookPresenterSpy!
    
    override func setUp() {
        super.setUp()
        // This is the setUp() instance method.
        // It is called before each test method begins.
        // Set up any per-test state here.
        
        noteServiceSpy = NoteServiceSpy()
        presenterSpy = NoteBookPresenterSpy()
        interactor = NoteBookInteractor(noteService: noteServiceSpy)
        interactor.presenter = presenterSpy
    }
    override func tearDown() {
        super.tearDown()
        // This is the tearDown() instance method.
        // It is called after each test method completes.
        // Perform any per-test cleanup here.

    }
    
    func test_SaveNote_Failed() {
        
        interactor.saveNote(id: nil, note: "12345")
        XCTAssertTrue(presenterSpy.presentError)

    }
    
    func test_SaveNote_Success(){
        
        interactor.saveNote(id: nil, note: "1234567")
        XCTAssertTrue(presenterSpy.presentNotes)
        
    }
    
    func test_DeleteNote_Success() {
        interactor.removeNote(id: "123")
        XCTAssertTrue(presenterSpy.presentNotes)
    }
    
    func test_fetch_Notes_Success() {
        interactor.fetchNotes()
        XCTAssertTrue(presenterSpy.presentNotes)
    }
}

class NoteServiceSpy: NoteService {
    
    var fetchNotesCalled = false
    var saveNoteCalled = false
    var deleteNote = false
    
    func fetchNotes(completionHandler: @escaping ([Note], NoteServiceError?) -> Void) {
        fetchNotesCalled = true
        completionHandler([],nil)
    }
    
    func saveNote(note: Note, completionHandler: @escaping (Result<String, NoteServiceError>) -> Void) {
        saveNoteCalled = true
        completionHandler(.success(""))
        
    }
    
    func deleteNote(id: String, completionHandler: @escaping (Result<String, NoteServiceError>) -> Void) {
        deleteNote = true
        completionHandler(.success(""))
    }
    
}

class  NoteBookPresenterSpy: NoteBookPresenterLogic {
    var presentNotes = false
    var presentError = false
    
    func presentNotes(notes: [Note]) {
        presentNotes = true
    }
    
    func presentError(error: NoteBookInteractorLogicError) {
        presentError = true
    }
    
    
}
