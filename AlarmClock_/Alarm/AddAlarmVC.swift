//
//  SecondViewController.swift
//  AlarmClock_
//
//  Created by 다은 on 2023/07/02.
//

import UIKit

protocol AlarmDelegate: AnyObject {
    func alarmDelegate(data: String)
}

class AddAlarmVC : BaseViewController{
    // MARK: UI
        var tableview = UITableView(frame: .zero, style: .insetGrouped)
        
        var alarmtime : String = "오전 12:00"
       weak var delegate : AlarmDelegate?
        //Delegate를 위한 변수 생성 -> func 으로 data 넘기기 위함
        
        let DatePicker = UIDatePicker()
        let dateFormat : DateFormatter = {
            let format = DateFormatter()
            format.timeStyle = .short
            return format
        }()
    
    // MARK: LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setDatePicker()
        setTableView()
    }
    
    // MARK: DATEPICKER
    func setDatePicker(){
        view.addSubview(DatePicker)
        DatePicker.timeZone = .autoupdatingCurrent
        alarmtime = dateFormat.string(from: DatePicker.date)
        //현재 시간으로 업데이트
        DatePicker.datePickerMode = .time
        DatePicker.preferredDatePickerStyle = .wheels
        
        DatePicker.locale = Locale(identifier: "ko_KR")
        //속성을 영어에서 한글로 변경
        DatePicker.addTarget(self, action: #selector(datePickFunc(_:)), for: .valueChanged)
        
        
        DatePicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            DatePicker.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            DatePicker.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
    ])
        
    }
    @objc func datePickFunc(_:UIDatePicker){
        alarmtime = dateFormat.string(from: DatePicker.date)
        print("addTime : \(alarmtime)")
     //save 버튼 누르면 데이터 전송
    }
    
    // MARK: NAVIGATION
    override func setNavigationBar(){
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
        self.delegate?.alarmDelegate(data: alarmtime)
        //delegate(AlarmDelegate)의 func 호출해 alarmtime을 넘김
        //메인 뷰에 데이터 넘김
        navigationController?.popViewController(animated: true)
    }
}

// MARK: TABLEVIEW
extension AddAlarmVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Edit") as! EditCell
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "반복"
            cell.accessoryType = .disclosureIndicator
        case 1:
            cell.textLabel?.text = "레이블"
            cell.accessoryType = .disclosureIndicator
        case 2:
            cell.textLabel?.text = "사운드"
            cell.accessoryType = .disclosureIndicator
        case 3:
            cell.textLabel?.text = "다시 알림"
            cell.accessoryView = UISwitch()
        default:
            break;
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            print("\(indexPath.row)  push")
            navigationController?.pushViewController(SetRepeatVC(), animated: true)
        default:
            break;
        }
    }
    
    func setTableView(){
        view.addSubview(tableview)
        self.tableview.dataSource = self
        self.tableview.delegate=self
        tableview.register(EditCell.self, forCellReuseIdentifier: "Edit")
        //cell 생성 코드에서 Identifier 통일시키기
        
        tableview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableview.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            tableview.topAnchor.constraint(equalTo: DatePicker.bottomAnchor, constant: -20),
            tableview.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableview.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100)])
        
    }
}
