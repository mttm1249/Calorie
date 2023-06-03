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
    
    private var calorieCounter: CalorieCounter!

    var buttonAction: (() -> Void)?
    
    var labelText: String? {
        didSet {
            calorieLabel.text = labelText
            addButton.isHidden = labelText == "Enter new value!" ? true : false
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        calorieCounter = CalorieCounter(recordManager: recordManager)
        updateTotalCalories()
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func updateLabel(with text: String) {
        labelText = text
    }
    
    private func updateTotalCalories() {
        calorieLabel.text = calorieCounter.showTotalCalories()
    }
    
    private func setupView() {
        // Configure stackView
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
        
        // Add horizontal stackView to vertical stackView
        verticalStackView.addArrangedSubview(horizontalStackView)
        verticalStackView.addArrangedSubview(numPad)
        
        // Add stackView to roundedRectView
        roundedRectView.addSubview(verticalStackView)
        
        // Add roundedRectView to self
        addSubview(roundedRectView)
        
        // Configure mainButton
        mainButton.layer.cornerRadius = 30
        mainButton.backgroundColor = .white
        mainButton.setImage(UIImage(systemName: "plus"), for: .normal)
        
        // Add mainButton target action
        mainButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        // Add mainButton to self
        addSubview(mainButton)
        
        // Configure numPad
        numPad.isHidden = true
        numPad.didSelectItem = { [weak self] selectedText in
            self?.handleSelectedText(selectedText)
        }
    }
    
    private func handleSelectedText(_ text: String) {
        if labelText == "Enter new value!" {
            labelText = text
        } else {
            labelText = (labelText ?? "") + text
        }
    }
    
    @objc private func addButtonTapped() {
        let newRecord = RecordModel(createDate: Date(), calorieValueInfo: labelText!)
        calorieCounter.addRecord(newRecord)
        labelText = ""
        animateHeightChange()
        topView.records = recordManager.fetchRecordsFromCoreData()
        updateTotalCalories()
    }
    
    @objc private func buttonTapped() {
        buttonAction?()
        animateHeightChange()
    }
    
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
    
    func activateConstraints(for bottomView: BottomActionView, in superview: UIView) {
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        superview.addSubview(bottomView)
        
        let heightConstraint = bottomView.heightAnchor.constraint(equalToConstant: 280)
        heightConstraint.isActive = true

        NSLayoutConstraint.activate([
            bottomView.bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor),
            bottomView.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: superview.trailingAnchor)
        ])
    }
    
    private func animateHeightChange() {
        numPad.isHidden = !numPad.isHidden
        let isExpanded = (heightConstraint.constant == 120)
        let newHeight: CGFloat = isExpanded ? 250 : 120
        let newButtonImage: UIImage? = isExpanded ? UIImage(systemName: "chevron.backward") : UIImage(systemName: "plus")
        
        // TODO
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