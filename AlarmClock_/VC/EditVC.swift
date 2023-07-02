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

class EditVC : UIViewController{
        let array : [String] = ["반복", "레이블", "사운드", "다시 알림"]
        var tableview = UITableView(frame: .zero, style: .insetGrouped)
        
    let alarmtime : String
       weak var delegate : AlarmDelegate?
        //Delegate를 위한 변수 생성 -> func 으로 data 넘기기 위함
        
      
        let DatePicker = UIDatePicker()
        
    
        func setDatePicker(){
            view.addSubview(DatePicker)
            DatePicker.timeZone = .autoupdatingCurrent
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
         let dateFormat = DateFormatter()
            dateFormat.timeStyle = .short
            alarmtime = dateFormat.string(from: DatePicker.date)
         
           
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        overrideUserInterfaceStyle = .dark
        setTableView()
        setDatePicker()
    }

}

extension EditVC{
    
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
        self.delegate?.alarmDelegate(data: alarmtime)
        //delegate(AlarmDelegate)의 func 호출해 alarmtime을 넘김
        //메인 뷰에 데이터 넘김
        
    }
}

extension EditVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Edit") as! EditCell
        cell.textLabel?.text = array[indexPath.row]
        
        if indexPath.row == 3{
            cell.accessoryView = UISwitch()
            //switch 추가
        }
        else{
            cell.accessoryType = .disclosureIndicator
        }
        
        return cell
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
