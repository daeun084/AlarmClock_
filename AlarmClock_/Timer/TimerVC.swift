//
//  TimerVC.swift
//  AlarmClock_
//
//  Created by 다은 on 2023/09/08.
//

import UIKit
class TimerVC : UIViewController {
    
    
    var stopWatchTimer : Timer?
 //  var elapsedTime : TimeInterval = 0
    var tableView = UITableView(frame: .zero, style: .insetGrouped)
    var remainTime : Int = 0
    
    let TimerView : TimerUIView = {
       let view = TimerUIView()
        return view
    }()
    
    
    let DatePicker : UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .countDownTimer
        picker.preferredDatePickerStyle = .wheels
        picker.countDownDuration = 60
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
        DatePicker.addTarget(self, action: #selector(datePickFunc(_:)), for: .valueChanged)
        cancelBtn.addTarget(self, action: #selector(cancelBtnFunc(sender:)), for: .touchUpInside)
        startBtn.addTarget(self, action: #selector(startBtnFunc(sender:)), for: .touchUpInside)
        
    }
    
    @objc func datePickFunc(_: UIDatePicker) {
        let dateFormat = DateFormatter()
           dateFormat.timeStyle = .short
        
        //DatePicker의 시간 .countDownDuration 통해 얻어냄
        remainTime = (Int)(DatePicker.countDownDuration)
        print(remainTime)
    }
    
    @objc func cancelBtnFunc(sender: UIButton){
        let timer = stopWatchTimer
            remainTime = 0
            print("Reset / remainTime = \(remainTime)")
        timer?.invalidate()
            
            //vezeri view 대신 datepicker
            
            //초기화면으로 돌아감
            startBtn.configuration?.baseBackgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
            startBtn.setTitle("Start", for: .normal)
    }
    
    @objc func startBtnFunc(sender:UIButton){
        //timer가 running 중이라면 일시정지 -> 재개
        if let timer = stopWatchTimer {
            stopWatchTimer = nil
            timer.invalidate()
            print("remainTime = \(remainTime)")
            
            startBtn.configuration?.baseBackgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
            startBtn.setTitle("Continue", for: .normal)
        }
        else{
            //timer가 일시정지되었다면 Continue -> 일시정지
       
            stopWatchTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                self.remainTime -= Int(timer.timeInterval)
                
                
                let hours = self.remainTime / 60 / 60
                let minutes = self.remainTime / 60 % 60
                let seconds = self.remainTime % 60
                               
               // self?.countdownLabel.text = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
                print("\(self.remainTime), \(hours)시간 \(minutes)분 \(seconds)초")
                
                //timer 종료
                    if self.remainTime == 0 {
                       timer.invalidate()
                        print("remainTime == 0")
                    }
                }

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
