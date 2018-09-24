//
//  MainInteractorTests.swift
//  Clean Mobile Buyer Guide
//
//  Created by ANUWAT SITTICCHAK on 24/9/2561 BE.
//  Copyright (c) 2561 ANUWAT SITTICHAK. All rights reserved.
//

@testable import Clean_Mobile_Buyer_Guide
import XCTest

class MainInteractorTests: XCTestCase {

  // MARK: - Subject under test

  var interactor: MainInteractor!

  // MARK: - Test lifecycle

  override func setUp() {
    super.setUp()
    setupMainInteractor()
  }

  override func tearDown() {
    super.tearDown()
  }

  // MARK: - Test setup

  func setupMainInteractor() {
    interactor = MainInteractor(worker: MainWorker())
  }

  // MARK: - Test doubles

  // MARK: - Tests

    class MainInteractorOutputSpy: MainPresenterInterface {
        var presentGetListCalled = false
        var presentUpdateListCalled = false
        
        func presentGetListResults(response: MainModel.GetMobile.Response) {
            presentGetListCalled = true
        }
        
        func presentUpdateList() {
            presentUpdateListCalled = true
        }
    }
    
    class MainWorkerSpy: MainWorker {
        
        var getMobileListCalled = false
        var favoriteMobileCalled = false
        var forceFailed = false
        
        override func getMobileList(success: @escaping (([MobilePhone]) -> ()), failure: @escaping ((String) -> ())) {
            getMobileListCalled = true
            if forceFailed {
                failure("")
            }
            else {
                success([])
            }
        }
        
        override func favoriteMobile(list: [MobilePhone], id: Int, isFavorite: Bool) -> [MobilePhone] {
            favoriteMobileCalled = true
            return []
        }
    
    }
    
    func testGetMobileListShouldAskWorkerWithSuccessAndPresenterToPresentGetListResults() {
        // Given
        let presenterSpy = MainInteractorOutputSpy()
        let workerSpy = MainWorkerSpy()
        interactor.presenter = presenterSpy
        interactor.worker = workerSpy
        
        //When
        let request = MainModel.GetMobile.Request()
        interactor.getMobileList(request: request)
    
        //Then
        XCTAssert(workerSpy.getMobileListCalled, "getMobileList() should ask worker to getMobileList() with success")
        XCTAssert(presenterSpy.presentGetListCalled, "interactor should ask presenter to presentGetListResults()")
    }
    
    func testGetMobileListShouldAskWorkerWithFailureAndPresenterToPresentGetListResults() {
        //Given
        let presenterSpy = MainInteractorOutputSpy()
        let workerSpy = MainWorkerSpy()
        workerSpy.forceFailed = true
        interactor.presenter = presenterSpy
        interactor.worker = workerSpy
        
        //When
        let request = MainModel.GetMobile.Request()
        interactor.getMobileList(request: request)
        
        //Then
        XCTAssert(workerSpy.getMobileListCalled, "getMobileList() should ask worker to getMobileList() with failure")
        XCTAssert(presenterSpy.presentGetListCalled, "interactor should ask presenter to presentGetListResults()")
    }
    
    func testFavoriteMobileShouldAskWorkerToFavoriteMobileAndPresenterToPresentUpdateList() {
        //Given
        let presenterSpy = MainInteractorOutputSpy()
        let workerSpy = MainWorkerSpy()
        interactor.presenter = presenterSpy
        interactor.worker = workerSpy
        
        //When
        interactor.favoriteMobile(id: 0, isFavorite: false)
        
        //Then
        XCTAssert(workerSpy.favoriteMobileCalled, "favoriteMobile() should ask worker to favoriteMobile()")
        XCTAssert(presenterSpy.presentUpdateListCalled, "interactor should ask presenter to presentUpdateList()")
        
    }
    
}
