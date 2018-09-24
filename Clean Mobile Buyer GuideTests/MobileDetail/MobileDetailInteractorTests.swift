//
//  MobileDetailInteractorTests.swift
//  Clean Mobile Buyer Guide
//
//  Created by ANUWAT SITTICCHAK on 24/9/2561 BE.
//  Copyright (c) 2561 ANUWAT SITTICHAK. All rights reserved.
//

@testable import Clean_Mobile_Buyer_Guide
import XCTest

class MobileDetailInteractorTests: XCTestCase {

  // MARK: - Subject under test

  var interactor: MobileDetailInteractor!

  // MARK: - Test lifecycle

  override func setUp() {
    super.setUp()
    setupMobileDetailInteractor()
  }

  override func tearDown() {
    interactor = nil
    super.tearDown()
  }

  // MARK: - Test setup

  func setupMobileDetailInteractor() {
    interactor = MobileDetailInteractor(worker: MobileDetailWorker())
  }
    
    class MobileDetailPresenterSpy: MobileDetailPresenterInterface {
        
        var presentMobileDataCalled = false
        var presentGetImageResultCalled = false
        
        func presentMobileData(data: MobilePhone) {
            presentMobileDataCalled = true
        }
        
        func presentGetImagesResult(response: MobileDetail.GetMobileImages.Response) {
            presentGetImageResultCalled = true
        }
        
    }
    
    class MobileDetailWorkerSpy: MobileDetailWorker {
        
        var forceFailure = false
        var getMobileImagesCalled = false
        
        override func getMobileImages(_ id: Int, success: @escaping (([String]) -> ()), failure: @escaping ((String) -> ())) {
            getMobileImagesCalled = true
            if forceFailure {
                failure("")
            }
            else {
                success([])
            }
        }

    }

  // MARK: - Test doubles

  // MARK: - Tests

    func testGetMobileDataShouldAskPresenterToPresentMobileData() {
        // Given
        let presenter = MobileDetailPresenterSpy()
        interactor.presenter = presenter

        // When
        interactor.mobileData = MobilePhone(name: "", id: 0, desc: "", thumbnailUrl: nil, rating: 0, price: 0, brand: "", isFavorite: false)
        interactor.getMobileData()

        // Then
        XCTAssert(presenter.presentMobileDataCalled, "getMobileData() should ask presenter to presentMobileData()")
    }
    
    func testGetMobileImagesShouldAskWorkerWithSuccessAndPresenterToPresentGetImageResult() {
        // Given
        let presenter = MobileDetailPresenterSpy()
        let worker = MobileDetailWorkerSpy()
        worker.forceFailure = false
        interactor.presenter = presenter
        interactor.worker = worker
        
        // When
        let request = MobileDetail.GetMobileImages.Request()
        interactor.mobileData = MobilePhone(name: "", id: 0, desc: "", thumbnailUrl: nil, rating: 0, price: 0, brand: "", isFavorite: false)
        interactor.getMobileImages(request: request)
        
        // Then
        XCTAssert(worker.getMobileImagesCalled, "getMobileImages() should ask worker to getMobileImages with success")
        XCTAssert(presenter.presentGetImageResultCalled, "getMobileImages() should ask presenter to presentGetImageResult() when success")
    }
    
    func testGetMobileImagesShouldAskWorkerWithFaiulureAndPresenterToPresentGetImageResult() {
        // Given
        let presenter = MobileDetailPresenterSpy()
        let worker = MobileDetailWorkerSpy()
        worker.forceFailure = true
        interactor.presenter = presenter
        interactor.worker = worker
        
        // When
        let request = MobileDetail.GetMobileImages.Request()
        interactor.mobileData = MobilePhone(name: "", id: 0, desc: "", thumbnailUrl: nil, rating: 0, price: 0, brand: "", isFavorite: false)
        interactor.getMobileImages(request: request)
        
        // Then
        XCTAssert(worker.getMobileImagesCalled, "getMobileImages() should ask worker to getMobileImages with failure")
        XCTAssert(presenter.presentGetImageResultCalled, "getMobileImages() should ask presenter to presentGetImageResult() when failure")
    }
    
}
