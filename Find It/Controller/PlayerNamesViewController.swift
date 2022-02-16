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
    @IBOutlet var containerStackView: UIStackView!
    
    weak var delegate: PlayerNamesViewControllerDelegate?
    let numberOfPlayers: Int
    
    private lazy var textFields: [UITextField] = {
        (0..<numberOfPlayers).map { _ in
            let textField = UITextField()
            textField.placeholder = "Enter Player Name"
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
        
        containerStackView.addArrangedSubviews(textFields)
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
