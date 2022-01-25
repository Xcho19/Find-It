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

class DifficultyViewController: UIViewController {

    weak var delegate: DifficultySelectionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didTapDifficulty(_ sender: UIButton) {
        delegate?.didSelectDifficulty(difficulty: sender.titleLabel?.text ?? "")
        dismiss(animated: true)
    }
}
