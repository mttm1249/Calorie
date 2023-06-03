//
//  TopTableView.swift
//  Calorie
//
//  Created by mttm on 31.05.2023.
//

import UIKit

class TopTableView: UITableView {
    
    var records: [RecordModel] = []
    
    init() {
        super.init(frame: .zero, style: .plain)
        self.delegate = self
        self.dataSource = self
        self.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Update TableView Method
    func updateTableView(with newRecords: [RecordModel]) {
        DispatchQueue.main.async {
            self.records = newRecords
            self.reloadData()
        }
    }
}

// MARK: UITableViewDataSource
extension TopTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? TableViewCell {
            cell.configure(with: records[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

// MARK: Constraints
extension TopTableView {
    func activateConstraints(in superview: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        superview.addSubview(self)
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor),
            heightAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.heightAnchor, multiplier: 1),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor)
        ])
    }
}
