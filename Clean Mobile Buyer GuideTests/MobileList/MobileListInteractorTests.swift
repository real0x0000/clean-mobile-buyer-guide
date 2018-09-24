//
//  MobileListInteractorTests.swift
//  Clean Mobile Buyer Guide
//
//  Created by ANUWAT SITTICCHAK on 24/9/2561 BE.
//  Copyright (c) 2561 ANUWAT SITTICHAK. All rights reserved.
//

@testable import Clean_Mobile_Buyer_Guide
import XCTest

class MobileListInteractorTests: XCTestCase {

  // MARK: - Subject under test

  var interactor: MobileListInteractor!

  // MARK: - Test lifecycle

  override func setUp() {
    super.setUp()
    setupMobileListInteractor()
  }

  override func tearDown() {
    interactor = nil
    super.tearDown()
  }

  // MARK: - Test setup

  func setupMobileListInteractor() {
    interactor = MobileListInteractor(worker: MobileListWorker())
  }
    
    class MobileListWorkerSpy: MobileListWorker {
        var getFavoriteListCalled = false
        var sortListCalled = false
        
        override func getFavoriteList(list: [MobilePhone], sortType: SortType) -> [MobilePhone] {
            getFavoriteListCalled = true
            return []
        }
        
        override func sortList(list: [MobilePhone], sortType: SortType) -> [MobilePhone] {
            sortListCalled = true
            return []
        }
        
    }

    class MobileListPresenterSpy: MobileListPresentationInterface {
        var presentListCalled = false
        
        func presentList(response: MobileListModel.GetMobileList.Response) {
            presentListCalled = true
        }
    }
    
  // MARK: - Test doubles

  // MARK: - Tests                  

    func testGetListShouldAskPresenterToPresentList() {
        // Given
        let presenter = MobileListPresenterSpy()
        interactor.presenter = presenter

        // When
        interactor.getList(list: [], sortType: .none)

        // Then
        XCTAssert(presenter.presentListCalled, "getList() should ask presenter to presentList()")
    }
    
    func testGetFavoriteListWithSortTypeNoneShouldAskPresenterToPresentList() {
        // Given
        let presenter = MobileListPresenterSpy()
        let worker = MobileListWorkerSpy()
        interactor.presenter = presenter
        interactor.worker = worker
        
        // When
        interactor.getFavoriteList(list: [], sortType: .none)
        
        // Then
        XCTAssert(worker.getFavoriteListCalled, "getFavoriteList() should ask worker to getFavoriteList()")
        XCTAssert(presenter.presentListCalled, "getFavoriteList() should ask presenter to presentList()")
    }
    
    func testGetListWithSortTypeNoneShouldAskWorkerToSortList() {
        // Given
        let worker = MobileListWorkerSpy()
        interactor.worker = worker
        
        // When
        interactor.getList(list: [], sortType: .none)
        
        // Then
        XCTAssert(worker.sortListCalled, "getList() should ask worker to sortList() when sortType is none")
    }
    
    func testGetListWithSortTypeLowPriceShouldAskWorkerToSortList() {
        // Given
        let worker = MobileListWorkerSpy()
        interactor.worker = worker
        
        // When
        interactor.getList(list: [], sortType: .lowPrice)
        
        // Then
        XCTAssert(worker.sortListCalled, "getList() should ask worker to sortList() when sortType is lowPrice")
    }
    
    func testGetListWithSortTypeHighPriceShouldAskWorkerToSortList() {
        // Given
        let worker = MobileListWorkerSpy()
        interactor.worker = worker
        
        // When
        interactor.getList(list: [], sortType: .highPrice)
        
        // Then
        XCTAssert(worker.sortListCalled, "getList() should ask worker to sortList() when sortType is highPrice")
    }
    
    func testGetListWithSortTypeRatingShouldAskWorkerToSortList() {
        // Given
        let worker = MobileListWorkerSpy()
        interactor.worker = worker
        
        // When
        interactor.getList(list: [], sortType: .rating)
        
        // Then
        XCTAssert(worker.sortListCalled, "getList() should ask worker to sortList() when sortType is rating")
    }
    
    func testGetFavoriteListWithSortTypeNoneShouldAskWorkerToGetFavorite() {
        // Given
        let worker = MobileListWorkerSpy()
        interactor.worker = worker
        
        // When
        interactor.getFavoriteList(list: [], sortType: .none)
        
        // Then
        XCTAssert(worker.getFavoriteListCalled, "getFavorite() should ask worker to getFavorite() when sortType is none")
    }
    
    func testGetFavoriteListWithSortTypeLowPriceShouldAskWorkerToGetFavorite() {
        // Given
        let worker = MobileListWorkerSpy()
        interactor.worker = worker
        
        // When
        interactor.getFavoriteList(list: [], sortType: .lowPrice)
        
        // Then
        XCTAssert(worker.getFavoriteListCalled, "getFavorite() should ask worker to getFavorite() when sortType is lowPrice")
    }
    
    func testGetFavoriteListWithSortTypeHighPriceShouldAskWorkerToGetFavorite() {
        // Given
        let worker = MobileListWorkerSpy()
        interactor.worker = worker
        
        // When
        interactor.getFavoriteList(list: [], sortType: .highPrice)
        
        // Then
        XCTAssert(worker.getFavoriteListCalled, "getFavorite() should ask worker to getFavorite() when sortType is highPrice")
    }
    
    func testGetFavoriteListWithSortTypeRatingShouldAskWorkerToGetFavorite() {
        // Given
        let worker = MobileListWorkerSpy()
        interactor.worker = worker
        
        // When
        interactor.getFavoriteList(list: [], sortType: .rating)
        
        // Then
        XCTAssert(worker.getFavoriteListCalled, "getFavorite() should ask worker to getFavorite() when sortType is rating")
    }
    
}
