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
    
    override init(frame: CGRect) {
           super.init(frame: frame)
         
       }
       required init?(coder _: NSCoder) {
           fatalError("Error")
       }
    
}



extension AlarmView : AlarmDelegate{
    func alarmDelegate(data: String) {
        timeArray.append(data)
        self.tableView.reloadData()
    }
    //EditView에서 alarmtime을 전달 받음
    //프로토콜 채택해야 함
}

extension AlarmView : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.accessoryView = UISwitch(frame: .zero)
        cell.textLabel?.text = timeArray[indexPath.row]
        cell.detailTextLabel?.text = "알람"
        //subtitle 문자 지정
        
        cell.textLabel?.font = UIFont.systemFont(ofSize: 45, weight: .thin)
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 20)
        
               return cell
    }
    
    
    
}



