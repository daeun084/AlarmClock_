//
//  TimerUIView.swift
//  AlarmClock_
//
//  Created by 다은 on 2023/09/13.
//

import UIKit
class TimerUIView : UIView {
    
    var timeLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 70, weight: .ultraLight)
        label.textAlignment = .center
        label.text = "00:00:00"
        return label
    }()

    
    private let backgroundLayer = CAShapeLayer()
    private let progressLayer = CAShapeLayer()
    private let animationName = "progressAnimation"

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
        backgroundColor = .black
        makeSubView()
        makeConstraint()
        setBezierPath()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSublayers(of layer: CALayer) {
      super.layoutSublayers(of: layer)
      self.backgroundLayer.path = self.circularPath.cgPath
      self.progressLayer.path = self.circularPath.cgPath
    }
}

extension TimerUIView {
    func makeSubView(){
        self.addSubview(timeLabel)
        self.layer.addSublayer(self.backgroundLayer)
        self.layer.addSublayer(self.progressLayer)

    }
    
    func makeConstraint(){
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            timeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            timeLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
        ])
    }
    
    func setBezierPath(){
        self.backgroundLayer.path = self.circularPath.cgPath
          self.backgroundLayer.fillColor = UIColor.clear.cgColor
          self.backgroundLayer.lineCap = .round
          self.backgroundLayer.lineWidth = 5.0
          self.backgroundLayer.strokeEnd = 1.0
        self.backgroundLayer.strokeColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
          
          self.progressLayer.path = self.circularPath.cgPath
          self.progressLayer.fillColor = UIColor.clear.cgColor
          self.progressLayer.lineCap = .round
          self.progressLayer.lineWidth = 5.0
          self.progressLayer.strokeEnd = 0
        self.progressLayer.strokeColor = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
    }
    
    func start(remainTime : Int, initTime : Int){
        
        if (remainTime == initTime){
            self.progressLayer.removeAnimation(forKey: self.animationName)
        }
        let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
        circularProgressAnimation.duration = CFTimeInterval(remainTime)
        circularProgressAnimation.toValue = 1.0
        circularProgressAnimation.fillMode = .forwards
        circularProgressAnimation.isRemovedOnCompletion = false
        self.progressLayer.add(circularProgressAnimation, forKey: self.animationName)
    }
    
    func pause(){
        let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
        circularProgressAnimation.toValue = 1.0
        circularProgressAnimation.fillMode = .forwards
        circularProgressAnimation.isRemovedOnCompletion = false
    }
    
    
    func stop() {
      self.progressLayer.removeAnimation(forKey: self.animationName)
    }
}
