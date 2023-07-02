//
//  EditView.swift
//  AlarmClock_
//
//  Created by 다은 on 2023/07/02.
//

import UIKit

protocol AlarmDelegate: AnyObject {
    func alarmDelegate(data: String)
}

class EditView : UIView{
    let array : [String] = ["반복", "레이블", "사운드", "다시 알림"]
    var tableview = UITableView(frame: .zero, style: .insetGrouped)
    
    var delegate : AlarmDelegate?
    //Delegate를 위한 변수 생성 -> func 으로 data 넘기기 위함
    
  
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
        let alarmtime = dateFormat.string(from: DatePicker.date)
        
        self.delegate?.alarmDelegate(data: alarmtime)
        //delegate(AlarmDelegate)의 func 호출해 alarmtime을 넘김
        //메인 뷰에 데이터 넘김
       
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




