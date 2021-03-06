//
//  MainPresenter.swift
//  AppCard
//
//  Created by N17430 on 2021/02/03.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol MainPresentationLogic
{
    func presentGetList(response: Main.GetList.Response)
}

class MainPresenter: MainPresentationLogic
{
    weak var viewController: MainDisplayLogic?
    
    // MARK: Do something
    
    func presentGetList(response: Main.GetList.Response)
    {
        let notiEle = Main.ListElement(category: .noti, displayType: Main.ListElement.DisplayType.none)
        let list = response.list
        list.insertOnce(element: notiEle, at: 0)
        let viewModel = Main.GetList.ViewModel(list: list)
        viewController?.displayGetList(viewModel: viewModel)
    }
    
}
