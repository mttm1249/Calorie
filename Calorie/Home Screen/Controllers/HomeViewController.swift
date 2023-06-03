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
        view.backgroundColor = .lightGray
        topView.records = recordManager.fetchRecordsFromCoreData()
        setupTopView()
        setupBottomView()
    }
    
    private func handleButtonTap() {
        topView.updateTableView(with: recordManager.fetchRecordsFromCoreData())
    }
    
    private func setupTopView() {
        topView.activateConstraints(in: view)
    }
    
    private func setupBottomView() {
        bottomView.buttonAction = { [weak self] in
            self?.handleButtonTap()
        }
        bottomView.updateTableAction = { [weak self] in
            self?.topView.updateTableView(with: self?.recordManager.fetchRecordsFromCoreData() ?? [])
        }
        bottomView.activateConstraints(in: view)
    }
}
