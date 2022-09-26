//
//  IngredientCollectionViewCell.swift
//  VoiceOverDemo
//
//  Created by Infinum on 20.09.2022..
//

import Foundation
import UIKit

protocol SelectableCell {
    var onDidSelect: (() -> Void)? { get set }
}

struct IngredientCellItem {
    var emoji: String
    var name: String
}

class IngredientCollectionViewCell: UICollectionViewCell, SelectableCell {

    let label = UILabel()
    var onDidSelect: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 48)
        contentView.addSubview(label)
        backgroundColor = .black.withAlphaComponent(0.05)
        layer.cornerRadius = 16
        layer.masksToBounds = true
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }
}
