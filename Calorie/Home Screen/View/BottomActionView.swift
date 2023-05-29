//
//  CustomView.swift
//  Calorie
//
//  Created by mttm on 29.05.2023.
//

import UIKit

class BottomActionView: UIView {
    private let roundedRectView = RoundedRectView()
    private let label = UILabel()
    private let button = UIButton(type: .system)
    
    private var heightConstraint: NSLayoutConstraint!

    var buttonAction: (() -> Void)?
    
    var labelText: String? {
        get { return label.text }
        set { label.text = newValue }
    }
    
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
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        addSubview(roundedRectView)
        
        label.text = "Total: 2000kkal"
        label.font = .boldSystemFont(ofSize: 25)
        label.textColor = .white
        label.textAlignment = .center
        roundedRectView.addSubview(label)
        
        button.layer.cornerRadius = 30
        button.backgroundColor = .white
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        addSubview(button)
    }
    
    @objc private func buttonTapped() {
        buttonAction?()
        animateHeightChange()
    }
    
    private func setupConstraints() {
        roundedRectView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let bottomOffset: CGFloat = 0
        heightConstraint = roundedRectView.heightAnchor.constraint(equalToConstant: 120)
        
        NSLayoutConstraint.activate([
            roundedRectView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -bottomOffset),
            roundedRectView.leadingAnchor.constraint(equalTo: leadingAnchor),
            roundedRectView.trailingAnchor.constraint(equalTo: trailingAnchor),
            heightConstraint,
            
            label.centerXAnchor.constraint(equalTo: roundedRectView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: roundedRectView.centerYAnchor),
            
            button.centerXAnchor.constraint(equalTo: roundedRectView.centerXAnchor),
            button.bottomAnchor.constraint(equalTo: roundedRectView.topAnchor, constant: 30),
            button.widthAnchor.constraint(equalToConstant: 60),
            button.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func animateHeightChange() {
        let isExpanded = (heightConstraint.constant == 120)
        let newHeight: CGFloat = isExpanded ? 250 : 120
        let newButtonImage: UIImage? = isExpanded ? UIImage(systemName: "chevron.backward") : UIImage(systemName: "plus")
        
        // TODO
        if isExpanded {
            label.text = "Enter new value!"
        } else {
            label.text = "Total: 2000kkal"
        }
        
        button.setImage(newButtonImage, for: .normal)
        
        let animator = UIViewPropertyAnimator(duration: 0.4, dampingRatio: 0.5) {
            self.heightConstraint.constant = newHeight
            self.superview?.layoutIfNeeded()
        }
        animator.startAnimation()
    }
}


