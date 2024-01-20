//
//  ViewController.swift
//  AlarmClock_
//
//  Created by 다은 on 2023/07/02.
//

import UIKit
import UserNotifications

class AlarmVC: UIViewController {
    
    var currentTime = Date()
    
    var timeArray : [String] = []
    //DatePicker로 고른 시간 배열로 저장
    var tableview = UITableView(frame: .zero, style: .plain)
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setTabBar()
        overrideUserInterfaceStyle = .dark
        //앱을 다크모드로 간주함
        setTableView()
        setTimer()
    }
    
    // MARK: TIMER
    func setTimer(){
        let timer = Timer(timeInterval: 10, target: self, selector: #selector(runCheckTime), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: .default)
    }
    
    @objc func runCheckTime(){
        checkTime()
    }
    
    //현재 시간과 비교해서 Alart 띄우기
    func checkTime(){
        //현재 시간 체크
        currentTime = Date()
        var DateFormatter = DateFormatter()
      //  DateFormatter.dateFormat = "HH:mm"
        DateFormatter.timeStyle = .short
        let dateString = DateFormatter.string(for: currentTime + 1)!
            //Date()가 현재 시간보다 1분 느려서 dateString =+ 1
        
        for i in timeArray{
            print("현재 시간 : \(dateString), i : \(i)")
            if (dateString == i){
                if let cell = tableview.visibleCells.first(where: { $0.textLabel?.text == i }) as? UITableViewCell {
                        if let accessorySwitch = cell.accessoryView as? UISwitch {
                            // 스위치에 접근
                            print("Switch Value: \(accessorySwitch.isOn)")
                            if(accessorySwitch.isOn){
                                scheduleNotification(at: currentTime)
                            }
                    }
                }
            }
        }
    }
    
    func scheduleNotification(at time: Date) {
        print("schedulNotif")
        let content = UNMutableNotificationContent()
        content.title = "Alarm"
        content.body = "Alarm is ringing"

        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: time)

        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)

        let request = UNNotificationRequest(identifier: "alarm", content: content, trigger: trigger)

        let center = UNUserNotificationCenter.current()
        center.add(request) { (error) in
            if let error = error {
                print("Error scheduling notification: \(error)")
            }
        }
    }

}

// MARK: DELEGATE
extension AlarmVC : AlarmDelegate{
    
    func alarmDelegate(data: String) {
        timeArray.append(data)
        print(data)
        timeArray.sort() // timeArray를 정렬
        self.tableview.reloadData()
    }
    //EditView에서 alarmtime을 전달 받음
    //프로토콜 채택해야 함
}

// MARK: NAVIGATIONBAR
extension AlarmVC{
    func setNavigationBar(){
        
        let navigationBar = navigationController!.navigationBar
        let appearance = UINavigationBarAppearance()
        appearance.backgroundEffect = UIBlurEffect(style: .dark)
        //tableview의 topAnchor을 view.topAnchor으로 설정해야 블러 효과가 나타남
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.boldSystemFont(ofSize: 20)]
       // navigationBar.prefersLargeTitles = true
        
        navigationItem.title = "알람"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(LeftBtnPressed(sender:)))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(RightBtnPressed(_:)))
        navigationItem.rightBarButtonItem?.tintColor = .orange
        navigationItem.leftBarButtonItem?.tintColor = .orange
        
        
        navigationBar.standardAppearance = appearance
        navigationBar.compactAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
    }
    
    @objc func LeftBtnPressed(sender: UIBarButtonItem){
        let shouldBeEdited = !tableview.isEditing
           tableview.setEditing(shouldBeEdited, animated: true)
          sender.isSelected = shouldBeEdited
    }
    //눌렀을 때 editing 가능하게 함
    
    
    @objc func RightBtnPressed(_:UIBarButtonItem){
        let editVC = AddAlarmVC()
        editVC.delegate = self
        //EditVC 인스턴스 생성할 때 delegate 설정
        editVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(editVC, animated: true)
    }
    
    func setTabBar(){
        let tabBar = tabBarController?.tabBar
        
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundEffect = UIBlurEffect(style: .dark)
        
        tabBar?.standardAppearance = tabBarAppearance
        tabBar?.scrollEdgeAppearance = tabBarAppearance
    }
}

// MARK: TABLEVIEW
extension AlarmVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Alarm") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "Alarm")

        cell.textLabel?.text = timeArray[indexPath.row]
        cell.detailTextLabel?.text = "알람"
        
        cell.textLabel?.font = UIFont.systemFont(ofSize: 45, weight: .thin)
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 20)
        
        cell.accessoryView = UISwitch(frame: .zero)
        return cell
    }
    
    func tableView(_: UITableView, heightForRowAt: IndexPath) -> CGFloat{
        return 120
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            UserDefaults.standard.set(timeArray, forKey: "timeArray")
            timeArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert{
        }
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        (indexPath.row >= 0)
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(EditAlarmVC(), animated: true)
    }
    
    func setTableView(){
        view.addSubview(tableview)
        self.tableview.dataSource = self
        self.tableview.delegate = self
       //tableview.register(UITableViewCell.self, forCellReuseIdentifier: "Alarm")
        
        tableview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: view.topAnchor),
            tableview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
           tableview.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
}

