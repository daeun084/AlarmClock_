//
//  AlarmCell.swift
//  AlarmClock_
//
//  Created by 다은 on 2023/07/02.
//

import UIKit
class AlarmCell : UITableViewCell{
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
