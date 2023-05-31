//
//  NumPad.swift
//  Calorie
//
//  Created by mttm on 30.05.2023.
//

import UIKit

class NumPad: UICollectionView {
    
    var didSelectItem: ((String) -> Void)?
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 40, height: 40)
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = (UIScreen.main.bounds.width - 5 * 40) / 6
        layout.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        super.init(frame: .zero, collectionViewLayout: layout)
        register(NumPadCell.self, forCellWithReuseIdentifier: NumPadCell.identifier)
        backgroundColor = .clear
        
        showsVerticalScrollIndicator = false
        isScrollEnabled = false
        
        self.delegate = self
        self.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NumPad: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = dequeueReusableCell(withReuseIdentifier: NumPadCell.identifier, for: indexPath) as? NumPadCell {
            cell.backgroundColor = .darkGray
            cell.layer.cornerRadius = 20
            cell.configure(with: "\(indexPath.row)")
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? NumPadCell else { return }
        let selectedText = cell.getLabelText()!
        didSelectItem?(selectedText)
    }
}
