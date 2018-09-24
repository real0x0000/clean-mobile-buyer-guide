//
//  MobileListViewControllerTests.swift
//  Clean Mobile Buyer Guide
//
//  Created by ANUWAT SITTICCHAK on 24/9/2561 BE.
//  Copyright (c) 2561 ANUWAT SITTICHAK. All rights reserved.
//

@testable import Clean_Mobile_Buyer_Guide
import XCTest

class MobileListViewControllerTests: XCTestCase {

  // MARK: - Subject under test

  var viewController: MobileListViewController!
  var window: UIWindow!

  // MARK: - Test lifecycle

  override func setUp() {
    super.setUp()
    window = UIWindow()
  }

  override func tearDown() {
    viewController = nil
    window = nil
    super.tearDown()
  }

  // MARK: - Test setup

  func setupMobileListViewController() {
    
  }

  func loadView() {
    window.addSubview(viewController.view)
    RunLoop.current.run(until: Date())
  }
    
    class MobileListInteractorSpy: MobileListInteractorInterface {
        
        var getListCalled = false
        var getFavoriteListCalled = false
        var updateFavoriteCalled = false
        
        func getList(list: [MobilePhone], sortType: SortType) {
            getListCalled = true
        }
        
        func getFavoriteList(list: [MobilePhone], sortType: SortType) {
            getFavoriteListCalled = true
        }
        
        func updateFavorite(itemIndex: Int, isFavorite: Bool) {
            updateFavoriteCalled = true
        }
        
    }

  // MARK: - Test doubles

  // MARK: - Tests

    func testFavoriteWithMobileListViewAndIsFavoriteShouldAskInteractorToUpdateFavorite() {
        // Given
        viewController = MobileListViewController(isFavorite: false)
        let interactor = MobileListInteractorSpy()
        viewController.interactor = interactor
        
        // When
        viewController.loadView()
        viewController.favoriteMobile(index: 0, isFavorite: true)
        
        // Then
        XCTAssert(interactor.updateFavoriteCalled, "favoriteMobile() should ask interactor to updateFavorite()")
    }
    
    func testFavoriteWithFavoriteListViewAndIsNotFavoriteShouldAskInteractorToUpdateFavorite() {
        // Given
        viewController = MobileListViewController(isFavorite: true)
        let interactor = MobileListInteractorSpy()
        viewController.interactor = interactor
        
        // When
        viewController.loadView()
        viewController.favoriteMobile(index: 0, isFavorite: false)
       
        // Then
        XCTAssert(interactor.updateFavoriteCalled, "favoriteMobile() should ask interactor to updateFavorite()")
    }
    
}
