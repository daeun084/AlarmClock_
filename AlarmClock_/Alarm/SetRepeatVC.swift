//
//  SetRepeatVC.swift
//  AlarmClock_
//
//  Created by 다은 on 2023/09/07.
//

import UIKit
class SetRepeatVC : UIViewController {
    
    let tableView : UITableView = UITableView(frame: .zero, style: .insetGrouped)
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        setNavigationBar()
        setTableView()

    }
}

extension SetRepeatVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "일요일마다"
        case 1:
            cell.textLabel?.text = "월요일마다"
        case 2:
            cell.textLabel?.text = "화요일마다"
        case 3:
            cell.textLabel?.text = "수요일마다"
        case 4:
            cell.textLabel?.text = "목요일마다"
        case 5:
            cell.textLabel?.text = "금요일마다"
        case 6:
            cell.textLabel?.text = "토요일마다"
        default:
            break;
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .none
    }
    
    func setTableView(){
        view.addSubview(tableView)
        self.tableView.dataSource = self
        self.tableView.delegate=self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.heightAnchor.constraint(equalToConstant: 50*8)
            
        ])
        
    }
    
}

extension SetRepeatVC {
    func setNavigationBar(){
        self.title = "반복"
        let backBtn = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(cancelFunc(_:)))
        backBtn.title = "뒤로"
        backBtn.tintColor = .orange
        navigationItem.backBarButtonItem = backBtn
    }
    
    @objc func cancelFunc(_: UIBarButtonItem){
        navigationController?.popViewController(animated: true)
    }
}
