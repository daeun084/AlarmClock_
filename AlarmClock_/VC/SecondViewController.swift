//
//  SecondViewController.swift
//  AlarmClock_
//
//  Created by 다은 on 2023/07/02.
//

import UIKit
class SecondViewController : UIViewController{
    /*
    let editView : EditView = {
       let editview = EditView()
        return editview
    }()
     */
    

    let DatePicker = UIDatePicker()
    
    func setDatePicker(){
        self.view.addSubview(DatePicker)
        DatePicker.timeZone = .autoupdatingCurrent
        //현재 시간으로 업데이트
        DatePicker.datePickerMode = .time
        
        DatePicker.locale = Locale(identifier: "ko_KR")
        //속성을 영어에서 한글로 변경
        DatePicker.addTarget(self, action: #selector(datePickFunc(_:)), for: .valueChanged)
        
        
        DatePicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            DatePicker.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
    ])
        
    }
    @objc func datePickFunc(_:UIDatePicker){
     let dateFormat = DateFormatter()
        dateFormat.timeStyle = .short
        let time = dateFormat.string(from: DatePicker.date)
        print(time)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setNavigation()
        overrideUserInterfaceStyle = .dark
        setDatePicker()
        
    
       
      
        
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
