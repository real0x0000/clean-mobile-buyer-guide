//
//  MainWorkerTests.swift
//  Clean Mobile Buyer Guide
//
//  Created by ANUWAT SITTICCHAK on 24/9/2561 BE.
//  Copyright (c) 2561 ANUWAT SITTICHAK. All rights reserved.
//

@testable import Clean_Mobile_Buyer_Guide
import XCTest

class MainWorkerTests: XCTestCase {

  // MARK: - Subject under test

  var sut: MainWorker!

  // MARK: - Test lifecycle

  override func setUp() {
    super.setUp()
    setupMainWorker()
  }

  override func tearDown() {
    super.tearDown()
  }

  // MARK: - Test setup

  func setupMainWorker() {
    sut = MainWorker()
  }

  // MARK: - Test doubles

  // MARK: - Tests

  func testSomething() {
    // Given

    // When

    // Then
  }
}
