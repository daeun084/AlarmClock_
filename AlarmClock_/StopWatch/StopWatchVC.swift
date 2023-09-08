//
//  StopWatchVC.swift
//  AlarmClock_
//
//  Created by 다은 on 2023/09/08.
//

import UIKit
class StopWatchVC : UIViewController {
    
   // var timer = scheduledTimer(withTimeInterval: 1, repeats: true, block: 1)
    
    var isPlaying : Bool?
    
    let labBtn : UIButton = {
        let btn = UIButton()
        var title = AttributedString("랩")
        var config = UIButton.Configuration.filled()
        config.cornerStyle = .capsule
        config.attributedTitle = title
        config.baseBackgroundColor = #colorLiteral(red: 0.3781762719, green: 0.3781762719, blue: 0.3781762719, alpha: 1)
       // config.baseForegroundColor = .systemGray4
        btn.configuration = config
        return btn
    }()
    
    let startBtn : UIButton = {
        let btn = UIButton()
        var title = AttributedString("시작")
        var config = UIButton.Configuration.filled()
        config.cornerStyle = .capsule
        config.attributedTitle = title
        config.baseBackgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        //config.baseForegroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
        btn.configuration = config
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        makeSubView()
        makeConstraint()
    }
    
}

extension StopWatchVC {
    func makeSubView(){
        view.addSubview(labBtn)
        view.addSubview(startBtn)
    }
    
    func makeConstraint(){
        labBtn.translatesAutoresizingMaskIntoConstraints = false
        startBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labBtn.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200),
            labBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            labBtn.widthAnchor.constraint(equalToConstant: 80),
            labBtn.heightAnchor.constraint(equalTo: labBtn.widthAnchor),
            
            startBtn.topAnchor.constraint(equalTo: labBtn.topAnchor),
            startBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            startBtn.widthAnchor.constraint(equalTo: labBtn.widthAnchor),
            startBtn.heightAnchor.constraint(equalTo: labBtn.heightAnchor)
        
        ])
    }
    
    
    
    
}
