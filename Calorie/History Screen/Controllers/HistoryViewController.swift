//
//  HistoryViewController.swift
//  Calorie
//
//  Created by mttm on 04.06.2023.
//

import UIKit

class HistoryViewController: UIViewController {
    
    private let recordManager = RecordManager()
    private var dailySummationManager: DailySummationManager?
    private var historyTableView = HistoryTableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDailySummationManager()
        setupTableView()
        updateTableView()
        
        print(recordManager.fetchAllDailyTotalsFromCoreData())
    }
        
    private func setupTableView() {
        historyTableView.activateConstraints(in: view)
    }
    
    private func setupDailySummationManager() {
        dailySummationManager = DailySummationManager(recordManager: recordManager)
    }
    
    private func updateTableView() {
        historyTableView.updateTableView(with: recordManager.fetchAllDailyTotalsFromCoreData())
    }
}
