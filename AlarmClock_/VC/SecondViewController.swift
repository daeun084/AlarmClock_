//
//  SecondViewController.swift
//  AlarmClock_
//
//  Created by 다은 on 2023/07/02.
//

import UIKit
class SecondViewController : UIViewController{
    
    let editView : EditView = {
       let editview = EditView()
        return editview
    }()

    
    override func loadView() {
        super.loadView()
        view = editView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        overrideUserInterfaceStyle = .dark
       
        
    }

}



extension SecondViewController{
    
    func setNavigation(){
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.boldSystemFont(ofSize: 20)]
        navigationController!.navigationBar.prefersLargeTitles = false
        
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAlarmEdit(_:)))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveAlarm(_:)))
        navigationItem.rightBarButtonItem?.tintColor = .orange
        navigationItem.leftBarButtonItem!.tintColor = .orange
        navigationItem.title = "알람 추가"
        
      
    }
    @objc func cancelAlarmEdit(_:UIBarButtonItem){
        navigationController?.popViewController(animated: true)
    }
    @objc func saveAlarm(_:UIBarButtonItem){
        
    }
}
