//
//  ViewController.swift
//  AlarmClock_
//
//  Created by 다은 on 2023/07/02.
//

import UIKit

class FirstViewController: UIViewController {
    
    let alarmView : AlarmView = {
        let alarmview = AlarmView()
        return alarmview
    }()

    override func viewDidLoad() {
        self.navigationController?.navigationBar.barStyle = .black
        //statusbar tint color 변경. viewdidload 전에 사용해야 함
        
        super.viewDidLoad()
        setNavigationBar()
        overrideUserInterfaceStyle = .dark
        //앱을 다크모드로 간주함
        
       
    }
    override func loadView() {
        super.loadView()
        view = alarmView
    }


}

extension FirstViewController{
    func setNavigationBar(){
        
        let navigationBar = navigationController!.navigationBar
        let appearance = UINavigationBarAppearance()
        appearance.backgroundEffect = UIBlurEffect(style: .dark)
        //tableview의 topAnchor을 view.topAnchor으로 설정해야 블러 효과가 나타남
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.boldSystemFont(ofSize: 20)]
        navigationBar.prefersLargeTitles = true
        
        
        navigationItem.title = "알람"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(LeftBtnPressed(_:)))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(RightBtnPressed(_:)))
        navigationItem.rightBarButtonItem?.tintColor = .orange
        navigationItem.leftBarButtonItem?.tintColor = .orange
        
        
        navigationBar.standardAppearance = appearance
        navigationBar.compactAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        
    }
    
    @objc func LeftBtnPressed(_: UIBarButtonItem){
        
    }
    @objc func RightBtnPressed(_:UIBarButtonItem){
        let EditVC = EditVC()
        navigationController?.pushViewController(EditVC, animated: true)
    }
}

