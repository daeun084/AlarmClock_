//
//  ViewController.swift
//  AlarmClock_
//
//  Created by 다은 on 2023/07/02.
//

import UIKit

class AlarmVC: UIViewController {
    
    var timeArray : [String] = []
    //DatePicker로 고른 시간 배열로 저장
    var tableview = UITableView(frame: .zero, style: .plain)
 
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        setNavigationBar()
        setTabBar()
        overrideUserInterfaceStyle = .dark
        //앱을 다크모드로 간주함
        setTableView()

       
    }
}

extension AlarmVC : AlarmDelegate{
    
    func alarmDelegate(data: String) {
        timeArray.append(data)
        self.tableview.reloadData()
    }
    //EditView에서 alarmtime을 전달 받음
    //프로토콜 채택해야 함
}


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
        //present(editVC, animated: true, completion: nil)
    }
    
    func setTabBar(){
        let tabBar = tabBarController?.tabBar
        
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundEffect = UIBlurEffect(style: .dark)
        
        tabBar?.standardAppearance = tabBarAppearance
        tabBar?.scrollEdgeAppearance = tabBarAppearance
    }
}


extension AlarmVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Alarm") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "Alarm")

        cell.textLabel?.text = timeArray[indexPath.row]
        cell.detailTextLabel?.text = "알람"
        //subtitle 문자 지정
        
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
       tableview.register(UITableViewCell.self, forCellReuseIdentifier: "Alarm")
        
        tableview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: view.topAnchor),
            tableview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
           tableview.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
}

