//
//  MainInteractorTests.swift
//  AppCard
//
//  Created by Raymond Law on 10/31/15.
//  Copyright (c) 2015 Raymond Law. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

@testable import AppCard
import XCTest
import Firebase

class MainInteractorTests: XCTestCase
{
    // MARK: - Subject under test
    
    var sut: MainInteractor!
    
    // MARK: - Test lifecycle
    
    override func setUp()
    {
        super.setUp()
        FirebaseApp.configure()
        setupMainInteractor()
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupMainInteractor()
    {
        sut = MainInteractor()
    }
    
    // MARK: - Test doubles
    
    class MainPresentationLogicSpy: MainPresentationLogic
    {
        // MARK: Method call expectations
        
        var presentGetListCalled = false
        
        // MARK: Spied methods
        
        func presentGetList(response: Main.GetList.Response)
        {
            presentGetListCalled = true
        }
    }
    
    class MainWorkerSpy: MainWorker
    {
        // MARK: Method call expectations
        
        var getListCalled = false
        
        // MARK: Spied methods
        
        override func listPagination(startingAt key: String, size: Int, completion: ((Main.List?) -> Void)?) {
            completion?(Seeds.GetList.mock())
            getListCalled = true
            //        FBDatabase.listPagination(startingAt: key, size: UInt(size)) { (objs) in
            //            if let objs = objs{ // list.list.count > 0
            //                Main.List(imageDownloadCompletion: { list in
            //                    print("imageDownloadCompletion!")
            //                    completion?(list)
            //                }, objs: objs)
            //            }
            //            else{ print("아이템 갯수=0"); completion?(nil) }
            //        }
        }
        
        func getData(name: String, withExtension: String = "json") -> Data {
            let bundle = Bundle(for: type(of: self))
            let fileUrl = bundle.url(forResource: name, withExtension: withExtension)
            let data = try! Data(contentsOf: fileUrl!)
            return data
        }
        
    }
    
    // MARK: - Tests
    
    func testFetchOrdersShouldAskMainWorkerToFetchOrdersAndPresenterToFormatResult()
    {
        // Given
        let mainPresentationLogicSpy = MainPresentationLogicSpy()
        sut.presenter = mainPresentationLogicSpy
        let mainWorkerSpy = MainWorkerSpy()
        sut.worker = mainWorkerSpy
        
        // When
        sut.getList()
        
        // Then
        XCTAssert(mainWorkerSpy.getListCalled, "GetList는 worker 에게 get list 를 요청한다")
        XCTAssert(mainPresentationLogicSpy.presentGetListCalled, "GetList는 presenter에게 list결과를 view model형식으로 만들도록 요청한다")
    }
}
