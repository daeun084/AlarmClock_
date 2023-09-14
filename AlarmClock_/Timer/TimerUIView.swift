//
//  TimerUIView.swift
//  AlarmClock_
//
//  Created by 다은 on 2023/09/13.
//

import UIKit
class TimerUIView : UIView {
    
    var timeLabel : UILabel {
        let label = UILabel()
        
        return label
    }
    /*
    private let backgroundLayer = CAShapeLayer()
     private let progressLayer = CAShapeLayer()
     private let animationName = "progressAnimation"
     private var timer: Timer?
     private var remainingSeconds: TimeInterval? {
       didSet {
         guard let remainingSeconds = self.remainingSeconds else { return }
         self.timeLabel.text = String(format: "%02ds", Int(remainingSeconds))
       }
     }*/
    
    private var circularPath: UIBezierPath {
       UIBezierPath(
         arcCenter: CGPoint(x: self.frame.size.width / 2.0, y: self.frame.size.height / 2.0),
         radius: 80,
         startAngle: CGFloat(-Double.pi / 2),
         endAngle: CGFloat(3 * Double.pi / 2),
         clockwise: true
       )
     }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeSubView()
        makeConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TimerUIView {
    func makeSubView(){
        self.addSubview(timeLabel)
    }
    
    func makeConstraint(){
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            timeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            timeLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
}
