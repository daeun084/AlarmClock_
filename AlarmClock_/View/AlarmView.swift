//
//  AlarmView.swift
//  AlarmClock_
//
//  Created by 다은 on 2023/07/02.
//

import UIKit
class AlarmView : UIView{
    
    override init(frame: CGRect) {
           super.init(frame: frame)
         
       }
       required init?(coder _: NSCoder) {
           fatalError("Error")
       }
    
}

extension AlarmView : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.accessoryView = UISwitch(frame: .zero)
        
        cell.detailTextLabel?.text = "알람"
        //subtitle 문자 지정
        
        cell.textLabel?.font = UIFont.systemFont(ofSize: 45, weight: .thin)
        //cell 글씨 크기 수정
        //글씨 두께 지정 - weight 속성
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 20)
        
               return cell
    }
    
    
}



