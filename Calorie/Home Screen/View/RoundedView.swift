//
//  RoundedView.swift
//  Calorie
//
//  Created by mttm on 29.05.2023.
//

import UIKit

class RoundedRectView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()

        let shapeLayer = CAShapeLayer()
        shapeLayer.path = UIBezierPath(roundedRect: bounds,
                                       byRoundingCorners: [.topLeft, .topRight],
                                       cornerRadii: CGSize(width: 20, height: 20)).cgPath
        layer.mask = shapeLayer
        backgroundColor = UIColor.darkGray
    }
}
