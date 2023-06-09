//
//  TableViewCell.swift
//  Calorie
//
//  Created by mttm on 31.05.2023.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    static let identifier = "TableViewCell"
    
    private let recordLabel = UILabel()
    
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
        recordLabel.translatesAutoresizingMaskIntoConstraints = false
        recordLabel.font = .boldSystemFont(ofSize: 19)
        recordLabel.textColor = .white
        self.contentView.addSubview(recordLabel)
        
        NSLayoutConstraint.activate([
            recordLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            recordLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            recordLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            recordLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    func configure(with model: RecordModel) {
        recordLabel.text = model.calorieValueInfo + " kkal"
    }
}
