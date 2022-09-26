//
//  IngredientsViewController.swift
//  VoiceOverDemo
//
//  Created by Infinum on 20.09.2022..
//

import UIKit

class IngredientsViewController: UIViewController {

    var items: [IngredientCellItem] = [
        .init(emoji: "🍅", name: "Tomato"),
        .init(emoji: "🥬", name: "Lettuce"),
        .init(emoji: "🧀", name: "Cheese"),
        .init(emoji: "🧅", name: "Onion"),
        .init(emoji: "🥒", name: "Cucumber"),
        .init(emoji: "🥓", name: "Bacon"),
        .init(emoji: "🌶", name: "Jalapeño"),
        .init(emoji: "🧄", name: "Garlic"),
        .init(emoji: "🥦", name: "Brocolli")
    ]

    var flowLayout = UICollectionViewFlowLayout()
    lazy var collectionView = AccessibleCollectionView(frame: .zero, collectionViewLayout: flowLayout)

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(collectionView)
        collectionView.frame = .init(x: 0, y: 120, width: view.bounds.width, height: 100)
        collectionView.accessibilityContainerType = .semanticGroup
        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.isAccessibilityElement = true
        collectionView.accessibilityTraits.insert(.adjustable)
        collectionView.accessibilityLabel = "Ingredients Section"
        collectionView.showsHorizontalScrollIndicator = false

        flowLayout.itemSize = .init(width: 70, height: 80)
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = .init(top: 0, left: 16, bottom: 0, right: 16)

        collectionView.register(IngredientCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }

    func didSelect(indexPath: IndexPath) {
        let item = items[indexPath.row]
        let alert = UIAlertController(title: "\(item.name) has been added!", message: "Press OK to continue", preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
}

extension IngredientsViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! IngredientCollectionViewCell

        let item = items[indexPath.row]
        cell.label.text = item.emoji
        cell.onDidSelect = { [weak self] in self?.didSelect(indexPath: indexPath) }

        cell.accessibilityValue = item.name
        cell.accessibilityElementsHidden = true // Never focus on cell itself

        return cell
    }
}

extension IngredientsViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? SelectableCell {
            cell.onDidSelect?()
        }
    }
}
