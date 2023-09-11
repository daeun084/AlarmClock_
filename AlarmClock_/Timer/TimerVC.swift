//
//  TimerVC.swift
//  AlarmClock_
//
//  Created by 다은 on 2023/09/08.
//

import UIKit
class TimerVC : UIViewController {
    
    let DatePicker : UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .countDownTimer
        picker.preferredDatePickerStyle = .wheels
        //picker.countDownDuration =
        return picker
    }()
    
    let cancelBtn : UIButton = {
        let btn = UIButton()
        var title = AttributedString("Cancel")
        var config = UIButton.Configuration.filled()
        config.cornerStyle = .capsule
        config.attributedTitle = title
        config.baseBackgroundColor = #colorLiteral(red: 0.3781762719, green: 0.3781762719, blue: 0.3781762719, alpha: 1)
       // config.baseForegroundColor = .systemGray4
        btn.configuration = config
        return btn
    }()
    
    let startBtn : UIButton = {
        let btn = UIButton()
        var title = AttributedString("Start")
        var config = UIButton.Configuration.filled()
        config.cornerStyle = .capsule
        config.attributedTitle = title
        config.baseBackgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
        btn.configuration = config
        return btn
    }()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        makeSubView()
        makeConstraint()
        //makeAddTarget()
    }
    
}

extension TimerVC {
    func makeSubView(){
        view.addSubview(DatePicker)
        view.addSubview(cancelBtn)
        view.addSubview(startBtn)
        
    }
    
    func makeConstraint(){
        DatePicker.translatesAutoresizingMaskIntoConstraints = false
        cancelBtn.translatesAutoresizingMaskIntoConstraints = false
        startBtn.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            DatePicker.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            DatePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            DatePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            cancelBtn.topAnchor.constraint(equalTo: DatePicker.bottomAnchor, constant: 40),
            cancelBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            cancelBtn.widthAnchor.constraint(equalToConstant: 80),
            cancelBtn.heightAnchor.constraint(equalTo: cancelBtn.widthAnchor),
            
            startBtn.topAnchor.constraint(equalTo: cancelBtn.topAnchor),
            startBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            startBtn.widthAnchor.constraint(equalTo: cancelBtn.widthAnchor),
            startBtn.heightAnchor.constraint(equalTo: cancelBtn.heightAnchor)
            
        ])
        
    }
    
    func makeAddTarget(){
        cancelBtn.addTarget(self, action: #selector(cancelBtnFunc(sender:)), for: .touchUpInside)
        startBtn.addTarget(self, action: #selector(startBtnFunc(sender:)), for: .touchUpInside)
        
    }
    
    @objc func cancelBtnFunc(sender: UIButton){
        
    }
    
    @objc func startBtnFunc(sender:UIButton){
        
    }
    
}
