//
//  TopTableView.swift
//  Calorie
//
//  Created by mttm on 31.05.2023.
//

import UIKit

class TopTableView: UITableView {
    init() {
        super.init(frame: .zero, style: .plain)
        register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        self.delegate = self
        self.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TopTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 21
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
        cell.configure(with: "\(indexPath.row)")
        return cell
    }
}
