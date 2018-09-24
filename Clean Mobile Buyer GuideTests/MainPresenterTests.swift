//
//  MainPresenterTests.swift
//  Clean Mobile Buyer Guide
//
//  Created by ANUWAT SITTICCHAK on 24/9/2561 BE.
//  Copyright (c) 2561 ANUWAT SITTICHAK. All rights reserved.
//

@testable import Clean_Mobile_Buyer_Guide
import XCTest

class MainPresenterTests: XCTestCase {

  // MARK: - Subject under test

  var sut: MainPresenter!

  // MARK: - Test lifecycle

  override func setUp() {
    super.setUp()
    setupMainPresenter()
  }

  override func tearDown() {
    super.tearDown()
  }

  // MARK: - Test setup

  func setupMainPresenter() {
    sut = MainPresenter()
  }

  // MARK: - Test doubles

  // MARK: - Tests

  func testSomething() {
    // Given

    // When

    // Then
  }
}
