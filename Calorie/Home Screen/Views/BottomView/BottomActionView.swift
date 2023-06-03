//
//  CustomView.swift
//  Calorie
//
//  Created by mttm on 29.05.2023.
//

import UIKit
import CoreData

class BottomActionView: UIView {
    
    private let topView = TopTableView()
    private let roundedRectView = RoundedRectView()
    private let numPad = NumPad()
    private let recordManager = RecordManager()
    private let calorieLabel = UILabel()
    private let mainButton = UIButton(type: .system)
    private let addButton = UIButton()
    private let verticalStackView = UIStackView()
    private let horizontalStackView = UIStackView()
    private var heightConstraint: NSLayoutConstraint!
    private var calorieCounter: CaloriesCounter!
    
    var updateTableViewAction: (() -> Void)?
    
    var calorieLabelText: String? {
        didSet {
            calorieLabel.text = calorieLabelText
            addButton.isHidden = calorieLabelText == "Enter new value!" ? true : false
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        calorieCounter = CaloriesCounter(recordManager: recordManager)
        updateTotalCalories()
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func updateLabel(with text: String) {
        calorieLabelText = text
    }
    
    private func updateTotalCalories() {
        calorieLabel.text = calorieCounter.showTotalCalories()
    }
    
    private func setupView() {
        // Configure verticalStackView
        verticalStackView.axis = .vertical
        verticalStackView.distribution = .fill
        verticalStackView.spacing = 20
        
        // Configure calorieLabel
        calorieLabel.font = .boldSystemFont(ofSize: 25)
        calorieLabel.textColor = .white
        calorieLabel.textAlignment = .center
        
        // Configure addButton
        addButton.setTitle("Add", for: .normal)
        addButton.setTitleColor(.white, for: .normal)
        addButton.backgroundColor = .darkGray
        addButton.layer.cornerRadius = 8
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        addButton.isHidden = true
        
        // Configure horizontalStackView
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = 5
        horizontalStackView.distribution = .fillEqually
        horizontalStackView.layoutMargins = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        horizontalStackView.isLayoutMarginsRelativeArrangement = true
        horizontalStackView.addArrangedSubview(calorieLabel)
        horizontalStackView.addArrangedSubview(addButton)
        
        // Add horizontalStackView to verticalStackView
        verticalStackView.addArrangedSubview(horizontalStackView)
        verticalStackView.addArrangedSubview(numPad)
        
        // Add verticalStackView to roundedRectView
        roundedRectView.addSubview(verticalStackView)
        
        // Add roundedRectView to self
        addSubview(roundedRectView)
        
        // Configure mainButton
        mainButton.layer.cornerRadius = 30
        mainButton.backgroundColor = .systemGray6
        mainButton.setImage(UIImage(systemName: "plus"), for: .normal)
        
        // Add mainButton target action
        mainButton.addTarget(self, action: #selector(mainButtonTapped), for: .touchUpInside)
        
        // Add mainButton to self
        addSubview(mainButton)
        
        // Configure numPad
        numPad.isHidden = true
        numPad.didSelectItem = { [weak self] selectedText in
            self?.handleSelectedNumPadButtons(selectedText)
        }
    }
    
    // Handle selected NumPad buttons method
    private func handleSelectedNumPadButtons(_ calorieValue: String) {
        if calorieLabelText == "Enter new value!" {
            calorieLabelText = calorieValue
        } else {
            calorieLabelText = (calorieLabelText ?? "") + calorieValue
        }
    }
    
    // MARK: UI Buttons
    
    // AddButton Action
    @objc private func addButtonTapped() {
        let newRecord = RecordModel(createDate: Date(), calorieValueInfo: calorieLabelText!)
        calorieCounter.addRecord(newRecord)
        calorieLabelText = ""
        animateHeightChange()
        updateTotalCalories()
        updateTableViewAction?()
    }
    
    // MainButton Action
    @objc private func mainButtonTapped() {
        animateHeightChange()
    }
    
    // BottomView animation method
    private func animateHeightChange() {
        numPad.isHidden = !numPad.isHidden
        let isExpanded = (heightConstraint.constant == 120)
        let newHeight: CGFloat = isExpanded ? 250 : 120
        let newButtonImage: UIImage? = isExpanded ? UIImage(systemName: "chevron.backward") : UIImage(systemName: "plus")
        
        if isExpanded {
            calorieLabel.text = "Enter new value!"
        } else {
            calorieLabel.text = calorieCounter.showTotalCalories()
        }
        addButton.isHidden = true
        mainButton.setImage(newButtonImage, for: .normal)
        
        let animator = UIViewPropertyAnimator(duration: 0.4, dampingRatio: 0.5) {
            self.heightConstraint.constant = newHeight
            self.superview?.layoutIfNeeded()
        }
        animator.startAnimation()
    }
}

// MARK: Constraints Setup
extension BottomActionView {
    private func setupConstraints() {
        roundedRectView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        mainButton.translatesAutoresizingMaskIntoConstraints = false
        
        let bottomOffset: CGFloat = 0
        heightConstraint = roundedRectView.heightAnchor.constraint(equalToConstant: 120)
        
        NSLayoutConstraint.activate([
            roundedRectView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -bottomOffset),
            roundedRectView.leadingAnchor.constraint(equalTo: leadingAnchor),
            roundedRectView.trailingAnchor.constraint(equalTo: trailingAnchor),
            heightConstraint,
            
            mainButton.centerXAnchor.constraint(equalTo: roundedRectView.centerXAnchor),
            mainButton.bottomAnchor.constraint(equalTo: roundedRectView.topAnchor, constant: 30),
            mainButton.widthAnchor.constraint(equalToConstant: 60),
            mainButton.heightAnchor.constraint(equalToConstant: 60),
            
            verticalStackView.centerXAnchor.constraint(equalTo: roundedRectView.centerXAnchor),
            verticalStackView.centerYAnchor.constraint(equalTo: roundedRectView.centerYAnchor, constant: 5),
            verticalStackView.widthAnchor.constraint(equalTo: roundedRectView.widthAnchor),
            verticalStackView.heightAnchor.constraint(equalToConstant: 170)
        ])
    }
    
    func activateConstraints(in superview: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        superview.addSubview(self)
        
        let heightConstraint = heightAnchor.constraint(equalToConstant: 280)
        heightConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor)
        ])
    }
}
