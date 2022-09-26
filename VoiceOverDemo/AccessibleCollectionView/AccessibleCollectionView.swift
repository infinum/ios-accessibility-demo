//
//  AccessibleCollectionView.swift
//  VoiceOverDemo
//
//  Created by Infinum on 20.09.2022..
//

import Foundation
import UIKit

/// Collection View in VoiceOver iterated by swiping up and down. Swipe left/right skips it.
class AccessibleCollectionView: UICollectionView {

    /// VoiceOver - Currently Focused Cell
    private var currentIndex: Int = 0
    private var currentCell: UICollectionViewCell? { cellForItem(at: .init(row: currentIndex, section: 0)) }
    private var cellCount: Int { numberOfItems(inSection: 0) }

    func announceFocusedCell(animated: Bool) {
        let indexPath = IndexPath(row: currentIndex, section: 0)
        guard let cell = currentCell else { return }
        scrollToItem(at: indexPath, at: .centeredHorizontally, animated: animated)
        visibleCells.forEach { $0.setBlueOutlineVisible(false) }
        accessibilityValue = cell.accessibilityValue // Causes the announcement.
        cell.setBlueOutlineVisible(true)
    }

    // MARK: - Accessibility Overrides

    /// VoiceOver: Executed on Swip Up
    override func accessibilityIncrement() {
        super.accessibilityIncrement()
        guard currentIndex < cellCount - 1 else { return }
        currentIndex += 1
        announceFocusedCell(animated: true)
    }

    /// VoiceOver: Executed on Swipe Down
    override func accessibilityDecrement() {
        super.accessibilityDecrement()
        guard currentIndex > 0 else { return }
        currentIndex -= 1
        announceFocusedCell(animated: true)
    }

    /// VoiceOver: Executed on double tap
    override func accessibilityActivate() -> Bool {
        if let selectableCell = currentCell as? SelectableCell {
            selectableCell.onDidSelect?()
            return true
        } else {
            return super.accessibilityActivate()
        }
    }

    /// Make sure to announce focused cell every time it is focused.
    override func accessibilityElementDidBecomeFocused() {
        super.accessibilityElementDidBecomeFocused()
        announceFocusedCell(animated: true)
    }
}

extension UIView {
    func setBlueOutlineVisible(_ outlined: Bool) {
        layer.borderColor = outlined ? UIColor.systemBlue.cgColor : nil
        layer.borderWidth = outlined ? 3.0 : 0.0
    }
}
