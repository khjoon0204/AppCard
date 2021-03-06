//
//  MainPresenterTests.swift
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

class MainPresenterTests: XCTestCase
{
    // MARK: - Subject under test
    
    var sut: MainPresenter!
    
    // MARK: - Test lifecycle
    
    override func setUp()
    {
        super.setUp()
        setupMainPresenter()
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupMainPresenter()
    {
        sut = MainPresenter()
    }
    
    // MARK: - Test doubles
    
    class MainDisplayLogicSpy: MainDisplayLogic
    {
        // MARK: Method call expectations
        
        var displayGetListCalled = false
        
        // MARK: Argument expectations
        
        var viewModel: Main.GetList.ViewModel!
        
        // MARK: Spied methods
        
        func displayGetList(viewModel: Main.GetList.ViewModel)
        {
            displayGetListCalled = true
            self.viewModel = viewModel
        }
    }
    
    // MARK: - Tests
    
    func testPresentGetListShouldFormatGetListForDisplay()
    {
        // Given
        let mainDisplayLogicSpy = MainDisplayLogicSpy()
        sut.viewController = mainDisplayLogicSpy
        
        // When
        let response = Main.GetList.Response(list: Seeds.GetList.mock)
        sut.presentGetList(response: response)
        
        // Then
        let displayedGetList = mainDisplayLogicSpy.viewModel.list        
        if let first = displayedGetList.list.first{
            XCTAssertEqual(first.category, .noti, "Presenting된 list의 category가 일치해야한다")
        }
        XCTAssertEqual(displayedGetList.count, 46, "Presenting된 list의 count가 일치해야한다")
    }
    
    func testPresentGetListShouldAskViewControllerToDisplayGetList()
    {
        // Given
        let mainDisplayLogicSpy = MainDisplayLogicSpy()
        sut.viewController = mainDisplayLogicSpy
        
        // When
        let list = Seeds.GetList.mock
        let response = Main.GetList.Response(list: list)
        sut.presentGetList(response: response)
        
        // Then
        XCTAssert(mainDisplayLogicSpy.displayGetListCalled, "Presenting된 list가 view controller에 보여져야 한다")
        
    }
}

