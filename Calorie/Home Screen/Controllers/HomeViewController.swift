//
//  ViewController.swift
//  Calorie
//
//  Created by mttm on 29.05.2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let recordManager = RecordManager()
    private var topView = TopTableView()
    private var bottomView = BottomActionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTopView()
        setupBottomView()
    }
    
    private func setupTopView() {
        view.backgroundColor = .lightGray
        topView.records = recordManager.fetchRecordsFromCoreData()
        topView.activateConstraints(in: view)
    }
    
    private func setupBottomView() {
        bottomView.updateTableViewAction = { [weak self] in
            self?.topView.updateTableView(with: self?.recordManager.fetchRecordsFromCoreData() ?? [])
        }
        bottomView.activateConstraints(in: view)
    }
}
