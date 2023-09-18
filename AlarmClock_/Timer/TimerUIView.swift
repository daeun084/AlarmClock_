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
    let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")


    private var circularPath: UIBezierPath {
      UIBezierPath(
        arcCenter: CGPoint(x: self.frame.size.width / 2.0, y: self.frame.size.height / 2.0),
        radius: 150,
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
          self.backgroundLayer.lineWidth = 8.0
          self.backgroundLayer.strokeEnd = 1.0
        self.backgroundLayer.strokeColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
          
          self.progressLayer.path = self.circularPath.cgPath
          self.progressLayer.fillColor = UIColor.clear.cgColor
          self.progressLayer.lineCap = .round
          self.progressLayer.lineWidth = 8.0
          self.progressLayer.strokeEnd = 0
        self.progressLayer.strokeColor = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
    }
    
    func start(remainTime : Int, initTime : Int){
        if progressLayer.animation(forKey: animationName) == nil {
               // 애니메이션이 시작되지 않은 경우, 시작
               print("애니메이션 시작")
               circularProgressAnimation.duration = CFTimeInterval(remainTime)
               circularProgressAnimation.toValue = 1.0
               circularProgressAnimation.fillMode = .backwards
               circularProgressAnimation.isRemovedOnCompletion = false
               if remainTime == initTime - 1 {
                   progressLayer.add(circularProgressAnimation, forKey: animationName)
                   print("remain == init")
               }
        } else if progressLayer.speed == 0.0 {
            // 애니메이션이 일시 중지된 경우, 재개
            print("애니메이션 재개")
            let pausedTime = progressLayer.timeOffset
            progressLayer.speed = 1.0
            progressLayer.timeOffset = 0.0
            progressLayer.beginTime = 0.0
            let timeSincePause = progressLayer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
            progressLayer.beginTime = timeSincePause
        }
        
    }
    
    func pauseFunc(){
        print("beiz pause")
        let pausedTime = progressLayer.convertTime(CACurrentMediaTime(), from: nil)
            progressLayer.speed = 0.0
            progressLayer.timeOffset = pausedTime
    }
    
    
    func stop() {
        print("beiz stop")
        self.progressLayer.removeAnimation(forKey: self.animationName)
        self.timeLabel.text = "00:00:00"

    }
}
