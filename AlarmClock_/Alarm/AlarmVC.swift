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
 
    
    override func viewDidLoad() {
        //self.navigationController?.navigationBar.barStyle = .black
        //statusbar tint color 변경. viewdidload 전에 사용해야 함
        
        super.viewDidLoad()
        setTableView()
        setNavigationBar()
        setTabBar()
        overrideUserInterfaceStyle = .dark
        //앱을 다크모드로 간주함
       
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
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(LeftBtnPressed(_:)))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(RightBtnPressed(_:)))
        navigationItem.rightBarButtonItem?.tintColor = .orange
        navigationItem.leftBarButtonItem?.tintColor = .orange
        
        
        navigationBar.standardAppearance = appearance
        navigationBar.compactAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
    }
    
    @objc func LeftBtnPressed(_: UIBarButtonItem){
        
    }
    
    @objc func RightBtnPressed(_:UIBarButtonItem){
        let editVC = EditVC()
        editVC.delegate = self
        //EditVC 인스턴스 생성할 때 delegate 설정
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


extension AlarmVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Alarm") as! AlarmCell
        cell.accessoryView = UISwitch(frame: .zero)
        cell.textLabel?.text = timeArray[indexPath.row]
        cell.detailTextLabel?.text = "알람"
        //subtitle 문자 지정
        
        cell.textLabel?.font = UIFont.systemFont(ofSize: 45, weight: .thin)
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 20)
        
        return cell
    }
    
    func tableView(_: UITableView, heightForRowAt: IndexPath) -> CGFloat{
        return 120
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            timeArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            UserDefaults.standard.set(timeArray, forKey: "timeArray")
        } else if editingStyle == .insert{
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(EditVC(), animated: true)
    }
    
    func setTableView(){
        view.addSubview(tableview)
        
        tableview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableview.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableview.topAnchor.constraint(equalTo: view.topAnchor),
            tableview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
           tableview.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
       
        
        self.tableview.dataSource = self
        self.tableview.delegate = self
        tableview.register(AlarmCell.self, forCellReuseIdentifier: "Alarm")
        
    }
    
}

