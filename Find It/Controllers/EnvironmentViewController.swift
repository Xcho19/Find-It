//
//  EnvironmentViewController.swift
//  Find It
//
//  Created by Xcho on 17.01.22.
//

import UIKit

protocol EnvironmentSelectionDelegate: AnyObject {
    func didSelectEnvironment(environment: String)
}

final class EnvironmentViewController: UIViewController {

    // MARK: - Dependencies

    weak var delegate: EnvironmentSelectionDelegate?

    // MARK: - Callbacks

    @IBAction func didTapEnvironment(_ sender: UIButton) {
        delegate?.didSelectEnvironment(environment: sender.titleLabel?.text ?? "")
        dismiss(animated: true)
    }
}
