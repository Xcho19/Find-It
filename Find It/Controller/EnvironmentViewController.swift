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

class EnvironmentViewController: UIViewController {
    
    weak var delegate: EnvironmentSelectionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didTapEnvironment(_ sender:UIButton) {
        delegate?.didSelectEnvironment(environment: sender.titleLabel?.text ?? "")
        dismiss(animated: true)
    }
}
