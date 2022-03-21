//
//  PLayerNamesViewController.swift
//  Find It
//
//  Created by Xcho on 08.02.22.
//

import UIKit

protocol PlayerNamesViewControllerDelegate: AnyObject {
    func didAddPlayers(names: [String])
}

final class PlayerNamesViewController: UIViewController {

    @IBOutlet var saveButton: UIBarButtonItem!
    @IBOutlet var containerStackView: UIStackView!

    weak var delegate: PlayerNamesViewControllerDelegate?

    let numberOfPlayers: Int
    var playerNames: [String] = []

    private lazy var textFields: [UITextField] = {
        (0..<numberOfPlayers).map { _ in
            let textField = UITextField()
            textField.placeholder = "Enter Player Name"
            textField.borderStyle = .line
            textField.addTarget(
                self,
                action: #selector(editingChanged(textField:)),
                for: .editingChanged
            )

            return textField
        }
    }()

    init?(coder: NSCoder, numberOfPlayers: Int) {
        self.numberOfPlayers = numberOfPlayers
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("Unexpected Init")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        saveButton.isEnabled = false
        containerStackView.addArrangedSubviews(textFields)
        fillTextFields()
    }

    @objc final private func editingChanged(textField: UITextField) {
        if textFields.allSatisfy({ $0.text?.isEmpty == false }) {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
    }

    private func fillTextFields() {
        for textField in textFields {
            textField.text = playerNames.first ?? ""

            if playerNames != [] {
                playerNames.removeFirst()
            }
        }

        if textFields.allSatisfy({ $0.text?.isEmpty == false }) {
            saveButton.isEnabled = true
        }
    }

    @IBAction func didTapAddButton(_ sender: Any) {
        delegate?.didAddPlayers(names: textFields.compactMap { $0.text })
        dismiss(animated: true)
    }

    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true)
    }
}

extension UIStackView {
    func addArrangedSubviews(_ subviews: [UIView]) {
        subviews.enumerated().forEach { insertArrangedSubview($0.1, at: $0.0) }
    }
}
