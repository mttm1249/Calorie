//
//  HistoryViewController.swift
//  Calorie
//
//  Created by mttm on 04.06.2023.
//

import UIKit

class HistoryViewController: UIViewController {
    
    private let recordManager = RecordManager()
    private var historyTableView = HistoryTableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView() {
        historyTableView.updateTableView(with: recordManager.fetchAllDailyTotalsFromCoreData())
        historyTableView.activateConstraints(in: view)
    }
}
