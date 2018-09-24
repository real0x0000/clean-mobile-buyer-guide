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

  var presenter: MainPresenter!

  // MARK: - Test lifecycle

  override func setUp() {
    super.setUp()
    setupMainPresenter()
  }

  override func tearDown() {
    presenter = nil
    super.tearDown()
  }

  // MARK: - Test setup

  func setupMainPresenter() {
    presenter = MainPresenter()
  }

  // MARK: - Test doubles

  // MARK: - Tests

    class MainViewControllerSpy: MainViewControllerInterface {
        
        var presentGetMobileCalled = false
        var updateListCalled = false
        
        func presentGetMobileList(viewModel: MainModel.GetMobile.ViewModel) {
            presentGetMobileCalled = true
        }
        
        func updateList() {
            updateListCalled = true
        }
        
    }
    
    func testPresentGetListResultsWithSuccessCase() {
        //Given
        let viewControllerSpy = MainViewControllerSpy()
        presenter.viewController = viewControllerSpy
        
        //When
        let response = MainModel.GetMobile.Response(list: [], isError: false, message: nil)
        presenter.presentGetListResults(response: response)
        
        //Then
        XCTAssert(viewControllerSpy.presentGetMobileCalled, "presentList() should ask viewController to presentGetListResults() when response is success()")
    }
    
    func testPresentGetListResultsWithFailureCase() {
        // Given
        let viewControllerSpy = MainViewControllerSpy()
        presenter.viewController = viewControllerSpy

        // When
        let response = MainModel.GetMobile.Response(list: [], isError: true, message: "")
        presenter.presentGetListResults(response: response)

        // Then
        XCTAssert(viewControllerSpy.presentGetMobileCalled, "presentList() should ask viewController to presentGetListResults() when response is failure()")
    }
    
    func testPresentUpdateList() {
        //Given
        let viewControllerSpy = MainViewControllerSpy()
        presenter.viewController = viewControllerSpy
        
        //When
        presenter.presentUpdateList()
        
        //Then
        XCTAssert(viewControllerSpy.updateListCalled, "presentUpdateList() should ask viewController to updateList()")
    }
    
}
