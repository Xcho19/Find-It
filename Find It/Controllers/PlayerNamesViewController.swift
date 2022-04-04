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
    // MARK: - init

    init?(coder: NSCoder, numberOfPlayers: Int, playerNames: [String]) {
        self.numberOfPlayers = numberOfPlayers
        self.playerNames = playerNames
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("Unexpected Init")
    }

    // MARK: - Dependencies

    weak var delegate: PlayerNamesViewControllerDelegate?

    // MARK: - Model

    private let numberOfPlayers: Int
    private var playerNames: [String]

    // MARK: - Subviews

    @IBOutlet var saveButton: UIBarButtonItem!
    @IBOutlet var containerStackView: UIStackView!

    private lazy var textFields: [UITextField] = {
        (0..<numberOfPlayers).map { _ in
            let textField = UITextField()
            textField.placeholder = "Enter Player Name"
            textField.borderStyle = .roundedRect
            textField.addTarget(
                self,
                action: #selector(editingChanged(textField:)),
                for: .editingChanged
            )

            return textField
        }
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        saveButton.isEnabled = false
        containerStackView.addArrangedSubviews(textFields)
        fillTextFields()
    }

    // MARK: - Helpers

    private func fillTextFields() {
        for textField in textFields {
            textField.text = playerNames.first ?? ""

            if !playerNames.isEmpty {
                playerNames.removeFirst()
            }
        }

        saveButton.isEnabled = textFields.allSatisfy({ $0.text?.isEmpty == false })
    }

    // MARK: - Callbacks

    @objc final private func editingChanged(textField: UITextField) {
        saveButton.isEnabled = textFields.allSatisfy({ $0.text?.isEmpty == false })
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
