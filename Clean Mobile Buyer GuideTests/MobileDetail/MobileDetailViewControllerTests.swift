//
//  MobileDetailViewControllerTests.swift
//  Clean Mobile Buyer Guide
//
//  Created by ANUWAT SITTICCHAK on 24/9/2561 BE.
//  Copyright (c) 2561 ANUWAT SITTICHAK. All rights reserved.
//

@testable import Clean_Mobile_Buyer_Guide
import XCTest

class MobileDetailViewControllerTests: XCTestCase {

  // MARK: - Subject under test

  var viewController: MobileDetailViewController!
  var window: UIWindow!

  // MARK: - Test lifecycle

  override func setUp() {
    super.setUp()
    window = UIWindow()
    setupMobileDetailViewController()
  }

  override func tearDown() {
    window = nil
    viewController = nil
    super.tearDown()
  }

  // MARK: - Test setup

  func setupMobileDetailViewController() {
    let bundle = Bundle.main
    let storyboard = UIStoryboard(name: "MobileDetail", bundle: bundle)
    viewController = storyboard.instantiateViewController(withIdentifier: "MobileDetail") as! MobileDetailViewController
  }

  func loadView() {
    window.addSubview(viewController.view)
    RunLoop.current.run(until: Date())
  }

    class MobileDetailInteractorSpy: MobileDetailInteractorInterface {
        
        var mobileData: MobilePhone?
        var getMobileImagesCalled = false
        var getMobileDataCalled = false
        
        func getMobileImages(request: MobileDetail.GetMobileImages.Request) {
            getMobileImagesCalled = true
        }
        
        func getMobileData() {
            getMobileDataCalled = true
        }
        
    }
    
  // MARK: - Test doubles

  // MARK: - Tests

    func testLoadViewShouldAskInteractorToGetMobileData() {
        // Given
        let interactor = MobileDetailInteractorSpy()
        viewController.interactor = interactor

        // When
        loadView()

        // Then
        XCTAssert(interactor.getMobileDataCalled, "getMobileData() should ask interactor to getMobileData()")
    }
    
    func testLoadViewShouldAskInteractorToGetMobileImages() {
        // Given
        let interactor = MobileDetailInteractorSpy()
        viewController.interactor  = interactor
        
        // When
        interactor.mobileData = MobilePhone(name: "", id: 0, desc: "", thumbnailUrl: nil, rating: 0, price: 0, brand: "", isFavorite: false)
        loadView()
        
        // Then
        XCTAssert(interactor.getMobileImagesCalled, "getMobileImages should ask interactor to getMobileImages()")
    }
    
}
