//
//  HistoryTableView.swift
//  Calorie
//
//  Created by mttm on 04.06.2023.
//

import UIKit

class HistoryTableView: UITableView {
    
    var records: [DailyTotalModel] = []
    
    init() {
        super.init(frame: .zero, style: .plain)
        self.delegate = self
        self.dataSource = self
        self.register(HistoryTableViewCell.self, forCellReuseIdentifier: HistoryTableViewCell.identifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Update TableView Method
    func updateTableView(with newRecords: [DailyTotalModel]) {
        DispatchQueue.main.async {
            self.records = newRecords
            self.reloadData()
        }
    }
}

// MARK: UITableViewDataSource
extension HistoryTableView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Records count: \(records.count)"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = dequeueReusableCell(withIdentifier: HistoryTableViewCell.identifier, for: indexPath) as? HistoryTableViewCell {
            cell.configure(with: records[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

// MARK: Constraints Setup
extension HistoryTableView {
    func activateConstraints(in superview: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        superview.addSubview(self)
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor)
        ])
    }
}
