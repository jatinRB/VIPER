//
//  View.swift
//  Project
//
//  Created by PC on 23/03/22.
//

import Foundation
import UIKit
import SnapKit

protocol AnyView {
    var presenter: AnyPresenter? { get set }
    
    func update(with users: [User])
    func update(with error: String)
}

class UserViewController: UIViewController, AnyView {
    var presenter: AnyPresenter?
    
    var didSetupConstraints = false
    var userArray: [User] = []
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero)
        table.tableFooterView = UIView.init()
        table.separatorStyle = .none
        table.register(UserCell.self, forCellReuseIdentifier: "UserCell")
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setTableViewDelegateDataSource()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !didSetupConstraints {
            createTableView()
            didSetupConstraints = true
        }
    }
    
    func update(with users: [User]) {
        DispatchQueue.main.async {
            self.userArray = users
            self.tableView.reloadData()
        }
    }
    
    func update(with error: String) {
        DispatchQueue.main.async {
            print(error)
        }
    }
}

//Custom Function
extension UserViewController {
    private func setTableViewDelegateDataSource() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func createTableView() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(15)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view.safeAreaLayoutGuide)
            make.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        tableView.reloadData()
    }
}

extension UserViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as? UserCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.setVerifyYourIdentityData(with: userArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
