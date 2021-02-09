//
//  MainViewController.swift
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
import WebKit

protocol MainDisplayLogic: class
{
    func displayGetList(viewModel: Main.GetList.ViewModel)
}

class MainViewController: UIViewController, MainDisplayLogic
{    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.contentInset = UIEdgeInsets(top: headerContentView.frame.height, left: 0, bottom: 0, right: 0)
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    @IBOutlet weak var dimView: UIView!
    @IBOutlet weak var swipeView: UIView!
    @IBOutlet weak var swipeViewBottom: NSLayoutConstraint!
    @IBOutlet weak var swipeViewHeight: NSLayoutConstraint!
    @IBOutlet weak var headerView: UIView!{
        didSet{
            headerView.layer.applySketchShadow(color: .black, alpha: 0.1, x: 0, y: 20, blur: 20, spread: 0)
        }
    }
    @IBOutlet weak var headerContentView: UIView!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var benefitLabel: UILabel!
    @IBOutlet weak var bankingLabel: UILabel!
    @IBOutlet weak var appcardLabel: UILabel!
    lazy var SWIPE_TOP_LIMIT: CGFloat = headerView.frame.height
    lazy var SWIPE_BOTTOM_LIMIT: CGFloat = view.frame.height - (swipeViewHeight.constant - swipeViewBottom.constant)
    var interactor: MainBusinessLogic?
    var router: (NSObjectProtocol & MainRoutingLogic & MainDataPassing)?
    lazy var prePosition: CGFloat = swipeView.frame.origin.y
    var list = Main.List(list: [])
    private var lastScrollY: CGFloat = 0    
    private var getListDone = false
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup()
    {
        let viewController = self
        let interactor = MainInteractor()
        let presenter = MainPresenter()
        let router = MainRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        setupSwipeView()
        webViewLoadUrl()
        interactor?.getList()
    }
    
    // MARK: Display
    func displayGetList(viewModel: Main.GetList.ViewModel)
    {
        getListDone = true
        self.list = viewModel.list
        tableView.reloadData()
    }
    
}

// MARK: ScrollView
extension MainViewController{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        swipeView(scrollView)
        nextPage()
    }
    
    func nextPage(){
        guard getListDone, let visibleRow = tableView.indexPathsForVisibleRows?.last?.row, visibleRow + Main.GetList.PAGE_SIZE > list.count else {return}
        print("visibleRow=\(visibleRow) list.count=\(list.count)")
        getListDone = false
        interactor?.getList()
    }
    
}

// MARK: WebView
extension MainViewController{
    func webViewLoadUrl(){
        let urlString:String = "https://www.hyundaicard.com"
        let url = URL(string: urlString)!
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
    }
}

// MARK: Swipe View
extension MainViewController{
    func swipeView(_ scrollView: UIScrollView){
        guard case let y = scrollView.contentOffset.y,
              y > 0,
              y < (scrollView.contentSize.height - scrollView.frame.height)
        else {return}
        let up = (lastScrollY >= y)
        lastScrollY = y
        
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut]) {
            self.swipeView.frame.origin.y = up ? self.SWIPE_BOTTOM_LIMIT : self.view.frame.height
//            self.headerView.backgroundColor = UIColor(white: 1, alpha: y / self.SWIPE_TOP_LIMIT)
            self.headerView.backgroundColor = UIColor(white: 1, alpha: y < self.SWIPE_TOP_LIMIT ? 0 : 1)
        } completion: { (success) in
        }
    }
    
    func setupSwipeView(){
        swipeView.layer.applySketchShadow(color: .black, alpha: 0.1, x: 0, y: -30, blur: 30, spread: 0)
        let swipe = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        swipeView.addGestureRecognizer(swipe)
    }
    
    @objc func handlePan(_ recognizer: UIPanGestureRecognizer){
        let div = (swipeView.frame.origin.y - SWIPE_TOP_LIMIT) / (SWIPE_BOTTOM_LIMIT - SWIPE_TOP_LIMIT)
        moveSwipeView(recognizer)
        dimView.alpha = 1 - div
        let headerAlpha = tableView.contentOffset.y > self.SWIPE_TOP_LIMIT ? div : 0
        headerView.backgroundColor = UIColor(white: 1, alpha: headerAlpha)
        headerLabelAnimation(toColor: UIColor(white: 1 - div, alpha: 1))
        benefitLabel.layerAnimation(toColor: UIColor(white: 1 - div, alpha: 1), animationKey: "key\(benefitLabel.tag)")
        moveToEdge(recognizer, div: div)
    }
    
    private func moveToEdge(_ recognizer: UIPanGestureRecognizer, div: CGFloat){
        guard recognizer.state == .ended else {return}
        let toTop = swipeView.frame.origin.y < (view.frame.height)/2
        var headerAlpha: CGFloat = toTop ? 0 : 1
        headerAlpha = tableView.contentOffset.y < self.SWIPE_TOP_LIMIT ? 0 : headerAlpha
        UIView.animate(withDuration: 0.5) {
            self.swipeView.frame.origin.y = toTop ? self.SWIPE_TOP_LIMIT : self.SWIPE_BOTTOM_LIMIT
            self.dimView.alpha = toTop ? 1 : 0
            self.headerView.backgroundColor = UIColor(white: 1, alpha: headerAlpha)
        } completion: { (success) in
        }
        headerLabelAnimation(toColor: toTop ? .white : .black)
    }
    
    func headerLabelAnimation(toColor to: UIColor){
        benefitLabel.layerAnimation(toColor: to, animationKey: "key\(benefitLabel.tag)")
        bankingLabel.layerAnimation(toColor: to, animationKey: "key\(bankingLabel.tag)")
        appcardLabel.layerAnimation(toColor: to, animationKey: "key\(appcardLabel.tag)")
    }
    
    private func moveSwipeView(_ recognizer: UIPanGestureRecognizer){
        let y = swipeView.frame.origin.y
        //        let isUP = prePosition > y
        let isTopOver = (y < SWIPE_TOP_LIMIT)
        let isBotBelow = (y > SWIPE_BOTTOM_LIMIT)
        defer{
            prePosition = y
            recognizer.setTranslation(.zero, in: swipeView)
        }
        guard !isBotBelow else {swipeView.frame.origin.y = SWIPE_BOTTOM_LIMIT;return}
        guard !isTopOver else {swipeView.frame.origin.y = SWIPE_TOP_LIMIT;return}
        let moveY = swipeView.frame.origin.y + recognizer.translation(in: swipeView).y
        //        print("swipeView.y=\(swipeView.frame.origin.y) moveY=\(moveY) isUP=\(isUP) isTopOver=\(isTopOver) isBotBelow=\(isBotBelow)")
        guard moveY <= SWIPE_BOTTOM_LIMIT else {return}
        guard moveY >= SWIPE_TOP_LIMIT else {return}
        swipeView.frame.origin.y = moveY
    }
}

// MARK: - TableView
extension MainViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let displayType = list.object(indexOf: indexPath.row)?.displayType else { return UITableViewCell() }
        switch displayType{
        case .displayTypeDefault:
            return MainListCell.config(delegateTargetTo: self, tableView, cellForItemAt: indexPath, dataSource: list)
        case .noBack:
            return MainNoBackCell.config(delegateTargetTo: self, tableView, cellForItemAt: indexPath, dataSource: list)
        case .none:
            return MainNotiCell.config(delegateTargetTo: self, tableView, cellForItemAt: indexPath, dataSource: list)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let sizeString = list.object(indexOf: indexPath.row)?.display?.size,
              case let sizeArray = sizeString.split(separator: "x"),
              //              let width = NumberFormatter().number(from: String(sizeArray[0])),
              let height = NumberFormatter().number(from: String(sizeArray[1]))
        else { return UITableView.automaticDimension }
        return CGFloat(truncating: height)
    }
    
}

private extension UILabel{
    func layerAnimation(toColor to: UIColor, animationKey key: String) {
        let changeColor = CATransition()
        changeColor.type = .fade
        changeColor.duration = 0.5
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            self.textColor = to
            self.layer.add(changeColor, forKey: key)
        }
        self.textColor = to
        self.layer.add(changeColor, forKey: key)
        CATransaction.commit()
    }
    
}
