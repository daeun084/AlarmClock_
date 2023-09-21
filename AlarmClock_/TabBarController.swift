//
//  TabBarController.swift
//  AlarmClock_
//
//  Created by 다은 on 2023/09/08.
//

import UIKit
class TabBarController : UITabBarController {
    override func viewDidLoad() {
        
        let ClockVC = UINavigationController(rootViewController: ClockVC())
        let AlarmVC = UINavigationController(rootViewController: AlarmVC())
        let StopWatchVC = UINavigationController(rootViewController: StopWatchVC())
        let TimerVC = UINavigationController(rootViewController: TimerVC())
        
        self.viewControllers = [ClockVC, AlarmVC, StopWatchVC, TimerVC]
        
        if let items = self.tabBar.items{
            items[0].image = UIImage(systemName: "network")?.resizeImageTo(size: CGSize(width: 35, height: 35))
            items[1].image = UIImage(systemName: "alarm.fill")?.resizeImageTo(size: CGSize(width: 35, height: 35))
            items[2].image = UIImage(systemName: "stopwatch.fill")?.resizeImageTo(size: CGSize(width: 35, height: 35))
            items[3].image = UIImage(systemName: "timer")?.resizeImageTo(size: CGSize(width: 35, height: 35))
            
            items[0].title = "세계시계"
            items[1].title = "알람"
            items[2].title = "스톱워치"
            items[3].title = "타이머"
        }
        self.hidesBottomBarWhenPushed = true
        self.selectedIndex = 1
        self.tabBar.unselectedItemTintColor = .systemGray
        self.tabBar.tintColor = .orange

    }
}
