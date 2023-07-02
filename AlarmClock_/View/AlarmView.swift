//
//  AlarmView.swift
//  AlarmClock_
//
//  Created by 다은 on 2023/07/02.
//

import UIKit
class AlarmView : UIView{
    
    var timeArray : [String] = []
    //DatePicker로 고른 시간 배열로 저장
    var tableview = UITableView(frame: .zero, style: .plain)
    
    override init(frame: CGRect) {
           super.init(frame: frame)
        setTableView()
         
       }
       required init?(coder _: NSCoder) {
           fatalError("Error")
       }
    
}



extension AlarmView : AlarmDelegate{
    func alarmDelegate(data: String) {
        timeArray.append(data)
        self.tableview.reloadData()
    }
    //EditView에서 alarmtime을 전달 받음
    //프로토콜 채택해야 함
}

extension AlarmView : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Alarm") as! AlarmCell
        cell.accessoryView = UISwitch(frame: .zero)
        cell.textLabel?.text = timeArray[indexPath.row]
        cell.detailTextLabel?.text = "알람"
        //subtitle 문자 지정
        
        cell.textLabel?.font = UIFont.systemFont(ofSize: 45, weight: .thin)
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 20)
        
               return cell
    }
    
    func setTableView(){
        addSubview(tableview)
        self.tableview.dataSource = self
        self.tableview.delegate=self
        tableview.register(AlarmCell.self, forCellReuseIdentifier: "Alarm")
        
        tableview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableview.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            tableview.topAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            tableview.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableview.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableview.bottomAnchor.constraint(equalTo: self.bottomAnchor)])
        
    }
    
    
    
}



