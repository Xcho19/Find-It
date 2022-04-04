//
//  DifficultyViewController.swift
//  Find It
//
//  Created by Xcho on 17.01.22.
//

import UIKit

protocol DifficultySelectionDelegate: AnyObject {
    func didSelectDifficulty(difficulty: String)
}

final class DifficultyViewController: UIViewController {

    // MARK: - Dependencies

    weak var delegate: DifficultySelectionDelegate?

    // MARK: - Callbacks

    @IBAction func didTapDifficulty(_ sender: UIButton) {
        let selectedDifficulty = sender.titleLabel?.text ?? ""
        delegate?.didSelectDifficulty(difficulty: selectedDifficulty)
        dismiss(animated: true)
    }
}
