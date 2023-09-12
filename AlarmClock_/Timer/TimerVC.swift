//
//  TimerVC.swift
//  AlarmClock_
//
//  Created by 다은 on 2023/09/08.
//

import UIKit
class TimerVC : UIViewController {
    
    
    var stopWatchTimer : Timer?
    var elapsedTime : TimeInterval = 0
    var tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    
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
        makeAddTarget()
        setTableView()
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
        //timer가 runnig 중이라면 Cancel
        if let timer = stopWatchTimer {
            
            //초기화면으로 돌아감
            startBtn.configuration?.baseBackgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
            startBtn.setTitle("Start", for: .normal)

        }
        else{
            //timer가 설정되어 있지 않다면 cancel 비활성화, Start
            
            
            
        }
        
    }
    
    @objc func startBtnFunc(sender:UIButton){
                
        
        //timer가 running 중이라면 일시정지 -> 재개
        if let timer = stopWatchTimer {
            startBtn.configuration?.baseBackgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
            startBtn.setTitle("Continue", for: .normal)
        }
        else{
            //timer가 일시정지되었다면 Continue -> 일시정지

            startBtn.configuration?.baseBackgroundColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
            startBtn.setTitle("Stop", for: .normal)
        }
        
    }
    
}

extension TimerVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "TimerCell")
        cell.textLabel?.text = "타이머 종료 시"
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.textColor = .white
        return cell
    }
    
    func setTableView(){
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TimerCell")

        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: cancelBtn.bottomAnchor, constant: 50),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
    
    
}
