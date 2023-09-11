//
//  StopWatchVC.swift
//  AlarmClock_
//
//  Created by 다은 on 2023/09/08.
//

import UIKit
class StopWatchVC : UIViewController {
        
    var timeLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 85, weight: .ultraLight)
        label.textAlignment = .center
        return label
    }()
    
    var stopWatchTimer : Timer?
    var elapsedTime : TimeInterval = 0
    var tableView = UITableView(frame: .zero, style: .plain)
    var labArray : [Double] = []
    
    
    
    let labBtn : UIButton = {
        let btn = UIButton()
        var title = AttributedString("Lab")
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
        setTableView()
        makeAddTarget()
        
        timeLabel.text = "00:00:00"
    }
    
}

extension StopWatchVC {
    func makeSubView(){
        view.addSubview(timeLabel)
        view.addSubview(labBtn)
        view.addSubview(startBtn)
    }
    
    func makeConstraint(){
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        labBtn.translatesAutoresizingMaskIntoConstraints = false
        startBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            timeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70),
            timeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            timeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            labBtn.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 70),
            labBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            labBtn.widthAnchor.constraint(equalToConstant: 80),
            labBtn.heightAnchor.constraint(equalTo: labBtn.widthAnchor),
            
            startBtn.topAnchor.constraint(equalTo: labBtn.topAnchor),
            startBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            startBtn.widthAnchor.constraint(equalTo: labBtn.widthAnchor),
            startBtn.heightAnchor.constraint(equalTo: labBtn.heightAnchor)
        
        ])
    }
    
    func makeAddTarget(){
        startBtn.addTarget(self, action: #selector(setStartBtnFunc(sender:)), for: .touchUpInside)
        labBtn.addTarget(self, action: #selector(setlabBtnFunc(sender: )), for: .touchUpInside)
    }
    
    @objc func setStartBtnFunc(sender : UIButton){
        if let timer = stopWatchTimer {
            //timer가 running중이면 멈추기
            stopWatchTimer = nil
            timer.invalidate()
            sender.configuration?.baseBackgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
            sender.setTitle("Start", for: .normal)
            labBtn.setTitle("Reset", for: .normal)
            
        }
        else{
            //timer가 running중이지 않다면 watch 활성화
            stopWatchTimer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { [weak self] timer in
                self?.elapsedTime += timer.timeInterval

                let minutes = Int(self!.elapsedTime) / 60 % 60
                let seconds = Int(self!.elapsedTime) % 60
                let milliseconds = Int(self!.elapsedTime * 100) % 100
                               
                self?.timeLabel.text = String(format: "%02d:%02d:%02d", minutes, seconds, milliseconds)
                           
            })
            sender.configuration?.baseBackgroundColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
            sender.setTitle("Stop", for: .normal)
            labBtn.setTitle("Lab", for: .normal)
    }
        
    
    }
    
    @objc func setlabBtnFunc(sender : UIButton) {
        if let timer = stopWatchTimer {
            //Timer가 running중이라면
            //Lab
           labArray.append(elapsedTime)
            print(labArray[labArray.count - 1])
            
        }
        else{
            //Timer가 running중이 아니라면
            //Reset
            elapsedTime = 0
            timeLabel.text = "00:00:00"
            labBtn.setTitle("Lab", for: .normal)
            labArray = []
            
        }
        tableView.reloadData()

    }
}

extension StopWatchVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return labArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stopWatchCell", for: indexPath)
        
        let accessoryLabel : UILabel = {
           let label = UILabel()
            
            let time = (Int)(labArray[indexPath.row])
            
            let minutes = time / 60 % 60
            let seconds = time % 60
            let milliseconds = Int(labArray[indexPath.row] * 100) % 100
                           
            label.text = String(format: "%02d:%02d:%02d", minutes, seconds, milliseconds)
            return label
        }()
        
        cell.accessoryView = accessoryLabel
        cell.textLabel?.text = "Lab \(indexPath.row + 1)"
        cell.tintColor = .white

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func setTableView(){
        tableView.backgroundColor = .black
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "stopWatchCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: labBtn.bottomAnchor, constant: 50),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])

        
    }
    
    
}
