//
//  GameConfigurationTableViewController.swift
//  Find It
//
//  Created by Xcho on 16.01.22.
//

import UIKit

class GameConfigurationTableViewController: UITableViewController, EnvironmentSelectionDelegate, DifficultySelectionDelegate {
    
    @IBOutlet var numberOfPlayersLabel: UILabel!
    @IBOutlet var numberOfPlayersStepper: UIStepper!
    
    @IBOutlet var selectedEnvironmentLabel: UILabel!
    @IBOutlet var selectedDifficultyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func didSelectEnvironment(environment: String) {
        selectedEnvironmentLabel.text = environment
    }
    
    func didSelectDifficulty(difficulty: String) {
        selectedDifficultyLabel.text = difficulty
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
    
    @IBSegueAction func openPlayerNames(coder: NSCoder) -> PlayerNamesViewController? {
        let numberOfPlayers = Int(numberOfPlayersStepper.value)
        return PlayerNamesViewController(coder: coder, numberOfPlayers: numberOfPlayers)
    }
    
    @IBSegueAction func openEnvironments(coder: NSCoder) -> EnvironmentViewController? {
       let environmentViewController = EnvironmentViewController(coder: coder)
        environmentViewController?.delegate = self
        return environmentViewController
    }

    @IBSegueAction func openDifficulties(coder: NSCoder) -> DifficultyViewController? {
       let difficultyViewController = DifficultyViewController(coder: coder)
        difficultyViewController?.delegate = self
        return difficultyViewController
    }
    
}
