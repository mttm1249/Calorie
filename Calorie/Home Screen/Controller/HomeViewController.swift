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
        print("hi")
    }
    
    func setupBottomView() {
        bottomView.buttonAction = { [weak self] in
            self?.handleButtonTap()
        }
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomView)
        
        NSLayoutConstraint.activate([
            bottomView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            bottomView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
