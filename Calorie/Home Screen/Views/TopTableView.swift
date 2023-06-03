//
//  TopTableView.swift
//  Calorie
//
//  Created by mttm on 31.05.2023.
//

import UIKit

class TopTableView: UITableView {
    
    let recordManager = RecordManager()
    var records: [RecordModel] = []

    init() {
        super.init(frame: .zero, style: .plain)
        register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        delegate = self
        dataSource = self
        isScrollEnabled = true
        isUserInteractionEnabled = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: UITableViewDataSource
extension TopTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
        cell.configure(with: records[indexPath.row])
        return cell
    }
}

// MARK: Constraints
extension TopTableView {
    func activateConstraints(for tableView: TopTableView ,in superview: UIView) {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        superview.addSubview(self)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor),
            tableView.heightAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.heightAnchor, multiplier: 1),
            tableView.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: superview.trailingAnchor)
        ])
    }
}

//TODO: Обновление таблицы после добавления записи!
