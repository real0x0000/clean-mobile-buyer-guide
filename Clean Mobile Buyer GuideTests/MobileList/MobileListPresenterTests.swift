//
//  MobileListPresenterTests.swift
//  Clean Mobile Buyer Guide
//
//  Created by ANUWAT SITTICCHAK on 24/9/2561 BE.
//  Copyright (c) 2561 ANUWAT SITTICHAK. All rights reserved.
//

@testable import Clean_Mobile_Buyer_Guide
import XCTest

class MobileListPresenterTests: XCTestCase {

  // MARK: - Subject under test

  var presenter: MobileListPresenter!

  // MARK: - Test lifecycle

  override func setUp() {
    super.setUp()
    setupMobileListPresenter()
  }

  override func tearDown() {
    presenter = nil
    super.tearDown()
  }

  // MARK: - Test setup

  func setupMobileListPresenter() {
    presenter = MobileListPresenter()
  }

    class MobileListViewControllerSpy: MobileListViewControllerInterface {
        var presentMobileListCalled = false
        
        func presentMobileList(viewModel: MobileListModel.GetMobileList.ViewModel) {
            presentMobileListCalled = true
        }
        
    }
    
  // MARK: - Test doubles

  // MARK: - Tests

  func testPresentListShouldAskViewControllerToPresentMobileList() {
    // Given
    let viewController = MobileListViewControllerSpy()
    presenter.viewController = viewController
    
    // When
    let response = MobileListModel.GetMobileList.Response(list: [])
    presenter.presentList(response: response)

    // Then
    XCTAssert(viewController.presentMobileListCalled, "presentList() should ask viewController to presentMobileList()")
  }
}
