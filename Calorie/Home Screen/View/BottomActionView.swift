//
//  CustomView.swift
//  Calorie
//
//  Created by mttm on 29.05.2023.
//

import UIKit

class BottomActionView: UIView {
    
    private let roundedRectView = RoundedRectView()
    private let numPad = NumPad()
    private let label = UILabel()
    private let button = UIButton(type: .system)
    private let stackView = UIStackView()
    
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
    
    func updateLabel(with text: String) {
        labelText = text
    }
    
    private func setupView() {
        // Configure stackView
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 20

        // Configure label
        label.text = "Total: 2000kkal"
        label.font = .boldSystemFont(ofSize: 25)
        label.textColor = .white
        label.textAlignment = .center

        // Add label and numPad to stackView
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(numPad)

        // Add stackView to roundedRectView
        roundedRectView.addSubview(stackView)

        // Add roundedRectView to self
        addSubview(roundedRectView)

        // Configure button
        button.layer.cornerRadius = 30
        button.backgroundColor = .white
        button.setImage(UIImage(systemName: "plus"), for: .normal)

        // Add button target action
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

        // Add button to self
        addSubview(button)
        
        // Configure numPad
        numPad.isHidden = true
        numPad.didSelectItem = { [weak self] selectedText in
            if let existingText = self?.labelText {
                if existingText == "Enter new value!" {
                    self?.labelText = selectedText.description
                } else {
                    self?.labelText = existingText + selectedText.description
                }
            } else {
                self?.labelText = selectedText.description
            }
        }
    }
    
    @objc private func buttonTapped() {
        buttonAction?()
        numPad.isHidden = !numPad.isHidden
        animateHeightChange()
    }
    
    private func setupConstraints() {
        roundedRectView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
            
        let bottomOffset: CGFloat = 0
        heightConstraint = roundedRectView.heightAnchor.constraint(equalToConstant: 120)
            
        NSLayoutConstraint.activate([
            roundedRectView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -bottomOffset),
            roundedRectView.leadingAnchor.constraint(equalTo: leadingAnchor),
            roundedRectView.trailingAnchor.constraint(equalTo: trailingAnchor),
            heightConstraint,
                
            button.centerXAnchor.constraint(equalTo: roundedRectView.centerXAnchor),
            button.bottomAnchor.constraint(equalTo: roundedRectView.topAnchor, constant: 30),
            button.widthAnchor.constraint(equalToConstant: 60),
            button.heightAnchor.constraint(equalToConstant: 60),
                
            stackView.centerXAnchor.constraint(equalTo: roundedRectView.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: roundedRectView.centerYAnchor, constant: 5),
            stackView.widthAnchor.constraint(equalTo: roundedRectView.widthAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 170)
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
