//
//  NumPadCell.swift
//  Calorie
//
//  Created by mttm on 30.05.2023.
//

import UIKit

class NumPadCell: UICollectionViewCell {
    static let identifier = "NumPadCell"
    
     private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
         label.font = .boldSystemFont(ofSize: 19)
        return label
    }()
    
    override var isHighlighted: Bool {
        didSet {
            let scale: CGFloat = isHighlighted ? 1.4 : 1.0
            let transform = CGAffineTransform(scaleX: scale, y: scale)
            
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.9, options: [.curveEaseInOut], animations: {
                self.transform = transform
            }, completion: nil)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .darkGray
        self.layer.cornerRadius = 20
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with text: String) {
        label.text = text
    }
    
    func getLabelText() -> String? {
        return label.text
    }
}
