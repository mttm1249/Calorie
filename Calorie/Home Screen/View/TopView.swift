//
//  TopView.swift
//  Calorie
//
//  Created by mttm on 31.05.2023.
//

import UIKit

class TopView: UIView {

    private let topTableView = TopTableView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setupConstraints()
    }
    
    private func setupView() {
        addSubview(topTableView)
    }
    
    private func setupConstraints() {
        topTableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            topTableView.topAnchor.constraint(equalTo: topAnchor),
            topTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            topTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            topTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func activateConstraints(for topView: TopView, in superview: UIView) {
        topView.translatesAutoresizingMaskIntoConstraints = false
        superview.addSubview(topView)
        
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor),
            topView.bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor),
            topView.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: superview.trailingAnchor)
        ])
    }
}
