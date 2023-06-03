//
//  TopTableView.swift
//  Calorie
//
//  Created by mttm on 31.05.2023.
//

import UIKit

class TopTableView: UITableView {
    
    private let recordManager = RecordManager()

    var records: [RecordModel] = []
    
    init() {
        super.init(frame: .zero, style: .plain)
        self.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        self.delegate = self
        self.dataSource = self
        self.isScrollEnabled = true
        self.isUserInteractionEnabled = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //TODO: Обновление таблицы после добавления записи!
    func updateTableView() {
        self.reloadData()
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
