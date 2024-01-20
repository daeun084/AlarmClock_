//
//  BaseViewController.swift
//  AlarmClock_
//
//  Created by 김다은 on 1/20/24.
//

import UIKit
class BaseViewController : UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark

        makeSubViews()
        makeConstraints()
        setNavigationBar()
        setTabBar()
        view.backgroundColor = .white
    }
    
    // MARK: Configuration
    func makeSubViews()
    {
        
    }
    
    // MARK: Layout
    func makeConstraints()
    {
        
    }
    
    // MARK: NavigationBar
    func setNavigationBar(){
        let navigationBar = navigationController?.navigationBar
        navigationBar?.topItem?.backButtonTitle = ""
        navigationBar?.tintColor = .white
        navigationBar?.prefersLargeTitles = false
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundEffect = UIBlurEffect(style: .dark)
        //tableview의 topAnchor을 view.topAnchor으로 설정해야 블러 효과가 나타남
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.boldSystemFont(ofSize: 20)]
        
        navigationBar?.standardAppearance = appearance
        navigationBar?.compactAppearance = appearance
        navigationBar?.scrollEdgeAppearance = appearance
    }
    
    // MARK: TabBar
    func setTabBar(){
        let tabBar = tabBarController?.tabBar
        
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundEffect = UIBlurEffect(style: .dark)
        
        tabBar?.standardAppearance = tabBarAppearance
        tabBar?.scrollEdgeAppearance = tabBarAppearance
    }
}
