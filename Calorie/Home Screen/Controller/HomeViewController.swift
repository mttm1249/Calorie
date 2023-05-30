//
//  ViewController.swift
//  Calorie
//
//  Created by mttm on 29.05.2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    private var bottomView = BottomActionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray3
        setupBottomView()
    }
    
    private func handleButtonTap() {
        print("Button tapped")
    }
    
    private func setupBottomView() {
        bottomView.buttonAction = { [weak self] in
            self?.handleButtonTap()
        }
        bottomView.activateConstraints(for: bottomView, in: view)
    }
}
