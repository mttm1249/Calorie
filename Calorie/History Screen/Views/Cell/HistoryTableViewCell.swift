//
//  HistoryTableViewCell.swift
//  Calorie
//
//  Created by mttm on 04.06.2023.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    
    static let identifier = "HistoryTableViewCell"
    
    private let dailyTotalLabel = UILabel()
    private let dateLabel = UILabel()
    private let stackView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        isUserInteractionEnabled = false
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        self.separatorInset = .zero
        self.backgroundColor = .lightGray

        dailyTotalLabel.translatesAutoresizingMaskIntoConstraints = false
        dailyTotalLabel.font = .boldSystemFont(ofSize: 19)
        dailyTotalLabel.textColor = .white
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.font = .systemFont(ofSize: 17)
        dateLabel.textColor = .white

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fill
        
        stackView.addArrangedSubview(dailyTotalLabel)
        stackView.addArrangedSubview(dateLabel)
        
        self.contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25)
        ])
    }
    
    func configure(with model: DailyTotalModel) {
        dailyTotalLabel.text = model.totalCaloriesinfo.description + " kkal"
        dateLabel.text = TimeManager.formatDate(model.date)
    }
}
