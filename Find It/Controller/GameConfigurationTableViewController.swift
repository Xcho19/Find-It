//
//  GameConfigurationTableViewController.swift
//  Find It
//
//  Created by Xcho on 16.01.22.
//

import UIKit

class GameConfigurationTableViewController: UITableViewController {
        
    @IBOutlet var numberOfPlayersLabel: UILabel!
    @IBOutlet var numberOfPlayersStepper: UIStepper!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func updateNumberOfPlayers() {
        numberOfPlayersLabel.text = "\(Int(numberOfPlayersStepper.value))"
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    @IBAction func numberOfPlayersStepperValueChanged(_ sender: UIStepper) {
        updateNumberOfPlayers()
    }
    
}
