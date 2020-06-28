//
//  NoteTest.swift
//  CleanMVVMTests
//
//  Created by Tirta A Gunawan on 28/06/20.
//  Copyright © 2020 iOS Dev Team. All rights reserved.
//

import Foundation
import XCTest
@testable import CleanMVVM

class NoteTest: XCTestCase {
    
    func test_Create_Note(){
        let note = NoteBuilder.init(id: nil, contain: "test contain", title: "title").build()
        XCTAssertNotNil(note)
        XCTAssertNotNil(note.timestamp)
    }
}
