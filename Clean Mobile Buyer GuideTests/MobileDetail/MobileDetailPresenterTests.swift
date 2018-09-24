//
//  MobileDetailPresenterTests.swift
//  Clean Mobile Buyer Guide
//
//  Created by ANUWAT SITTICCHAK on 24/9/2561 BE.
//  Copyright (c) 2561 ANUWAT SITTICHAK. All rights reserved.
//

@testable import Clean_Mobile_Buyer_Guide
import XCTest

class MobileDetailPresenterTests: XCTestCase {

  // MARK: - Subject under test

  var presenter: MobileDetailPresenter!

  // MARK: - Test lifecycle

  override func setUp() {
    super.setUp()
    setupMobileDetailPresenter()
  }

  override func tearDown() {
    presenter = nil
    super.tearDown()
  }

  // MARK: - Test setup

  func setupMobileDetailPresenter() {
    presenter = MobileDetailPresenter()
  }

    class MobileDetailViewControllerSpy: MobileDetailViewControllerInterface {
        
        var presentMobileDataCalled = false
        var presentGetMobileImagesCalled = false
        
        func presentMobileData(data: MobilePhone) {
            presentMobileDataCalled = true
        }
        
        func presentGetMobileImages(viewModel: MobileDetail.GetMobileImages.ViewModel) {
            presentGetMobileImagesCalled = true
        }
        
    }
    
  // MARK: - Test doubles

  // MARK: - Tests

    func testPresentMobileDataShouldAskViewControllerToPresentMobileData() {
        // Given
        let viewController = MobileDetailViewControllerSpy()
        presenter.viewController = viewController

        // When
        let mobilePhone = MobilePhone(name: "", id: 0, desc: "", thumbnailUrl: nil, rating: 0, price: 0, brand: "", isFavorite: false)
        presenter.presentMobileData(data: mobilePhone)

        // Then
        XCTAssert(viewController.presentMobileDataCalled, "presentMobileData() should ask viewController to presentMobileData")
    }
    
    func testPresentGetImageResultWithSuccessShouldAskViewControllerToPresentGetMobileImages() {
        // Given
        let viewController = MobileDetailViewControllerSpy()
        presenter.viewController = viewController
        
        // When
        let response = MobileDetail.GetMobileImages.Response(imageUrls: [], isError: false, errorMsg: nil)
        presenter.presentGetImagesResult(response: response)
        
        // Then
        XCTAssert(viewController.presentGetMobileImagesCalled, "presentGetImageResult() should ask viewController to presentGetMobileImages()")
    }
    
    func testPresentGetImageResultWithFailureShouldAskViewControllerToPresentGetMobileImages() {
        // Given
        let viewController = MobileDetailViewControllerSpy()
        presenter.viewController = viewController
        
        // When
        let response = MobileDetail.GetMobileImages.Response(imageUrls: [], isError: true, errorMsg: "")
        presenter.presentGetImagesResult(response: response)
        
        // Then
        XCTAssert(viewController.presentGetMobileImagesCalled, "presentGetImageResult() should ask viewController to presentGetMobileImages()")
    }
    
}
