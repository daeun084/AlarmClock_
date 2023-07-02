//
//  EditView.swift
//  AlarmClock_
//
//  Created by 다은 on 2023/07/02.
//

import UIKit

class EditView : UIView{
    let array : [String] = ["반복", "레이블", "사운드", "다시 알림"]
    var tableview = UITableView(frame: .zero, style: .insetGrouped)
    
  
    let DatePicker = UIDatePicker()
    
    func setDatePicker(){
        self.addSubview(DatePicker)
        DatePicker.timeZone = .autoupdatingCurrent
        //현재 시간으로 업데이트
        DatePicker.datePickerMode = .time
        DatePicker.preferredDatePickerStyle = .wheels
        
        DatePicker.locale = Locale(identifier: "ko_KR")
        //속성을 영어에서 한글로 변경
        DatePicker.addTarget(self, action: #selector(datePickFunc(_:)), for: .valueChanged)
        
        
        DatePicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            DatePicker.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40),
            DatePicker.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor)
    ])
        
    }
    @objc func datePickFunc(_:UIDatePicker){
     let dateFormat = DateFormatter()
        dateFormat.timeStyle = .short
        let time = dateFormat.string(from: DatePicker.date)
       
    }
   
 
    
    override init(frame: CGRect) {
           super.init(frame: frame)
        setDatePicker()
        setTableView()
         
       }
       required init?(coder _: NSCoder) {
           fatalError("Error")
       }
    
}

extension EditView : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! EditCell
        cell.textLabel?.text = array[indexPath.row]
        return cell
    }
    
    func setTableView(){
        addSubview(tableview)
        self.tableview.dataSource = self
        self.tableview.delegate=self
        
        tableview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableview.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            tableview.topAnchor.constraint(equalTo: DatePicker.bottomAnchor, constant: 20),
            tableview.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 50),
            tableview.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 50)])
        
    }
}
