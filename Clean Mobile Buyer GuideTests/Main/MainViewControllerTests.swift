//
//  MainViewControllerTests.swift
//  Clean Mobile Buyer Guide
//
//  Created by ANUWAT SITTICCHAK on 24/9/2561 BE.
//  Copyright (c) 2561 ANUWAT SITTICHAK. All rights reserved.
//

@testable import Clean_Mobile_Buyer_Guide
import XCTest

class MainViewControllerTests: XCTestCase {

  // MARK: - Subject under test

  var viewController: MainViewController!
  var window: UIWindow!

  // MARK: - Test lifecycle

  override func setUp() {
    super.setUp()
    window = UIWindow()
    setupMainViewController()
  }

  override func tearDown() {
    viewController = nil
    window = nil
    super.tearDown()
  }

  // MARK: - Test setup

  func setupMainViewController() {
    let bundle = Bundle.main
    let storyboard = UIStoryboard(name: "Main", bundle: bundle)
    viewController = storyboard.instantiateViewController(withIdentifier: "MainVC") as! MainViewController
//    viewController.mobileVC = MobileListViewController()
//    viewController.favoriteVC = MobileListViewController()
  }

  func loadView() {
    window.addSubview(viewController.view)
    RunLoop.current.run(until: Date())
  }

  // MARK: - Test doubles
    
    class MainViewInteractorSpy: MainInteractorInterface {
        var getMobileListCalled = false
        var favoriteMobileCalled = false
        
        var mobileList: [MobilePhone] = []
        
        var sortType: SortType = .none
        
        func getMobileList(request: MainModel.GetMobile.Request) {
            getMobileListCalled = true
        }
        
        func favoriteMobile(id: Int, isFavorite: Bool) {
            favoriteMobileCalled = true
        }
    }

  // MARK: - Tests

  func testLoadViewShouldAskInteractorToGetMobileList() {
    // Given
    let mainViewInteractorSpy = MainViewInteractorSpy()
    viewController.interactor = mainViewInteractorSpy
    // When
    loadView()
    // Then
    XCTAssert(mainViewInteractorSpy.getMobileListCalled, "viewDidLoad() should ask interactor to getMobileList()")
  }
}
