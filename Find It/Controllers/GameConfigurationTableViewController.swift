//
//  GameConfigurationTableViewController.swift
//  Find It
//
//  Created by Xcho on 16.01.22.
//

import UIKit

class GameConfigurationTableViewController: UITableViewController,
                                            EnvironmentSelectionDelegate,
                                            DifficultySelectionDelegate,
                                            PlayerNamesViewControllerDelegate {

    @IBOutlet var numberOfPlayersLabel: UILabel!
    @IBOutlet var numberOfPlayersStepper: UIStepper!
    @IBOutlet var selectedEnvironmentLabel: UILabel!
    @IBOutlet var selectedDifficultyLabel: UILabel!
    @IBOutlet var startButton: UIBarButtonItem!

    var playerNames: [String] = []

    func didSelectEnvironment(environment: String) {
        selectedEnvironmentLabel.text = environment
        checkStartButton()
    }

    func didSelectDifficulty(difficulty: String) {
        selectedDifficultyLabel.text = difficulty
        checkStartButton()
    }

    func didAddPlayers(names: [String]) {
        playerNames = names
        checkStartButton()
    }

    private func updateNumberOfPlayers() {
        numberOfPlayersLabel.text = "\(Int(numberOfPlayersStepper.value))"
    }

    private func checkStartButton() {
        if playerNames != [] &&
            selectedEnvironmentLabel.text != "[Select an Environment]" &&
            selectedDifficultyLabel.text != "[Select a Difficulty]" {
            startButton.isEnabled = true
        } else {
            startButton.isEnabled = false
        }
    }

    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }

    @IBAction func numberOfPlayersStepperValueChanged(_ sender: UIStepper) {
        updateNumberOfPlayers()
    }

    @IBSegueAction func openPlayerNames(coder: NSCoder) -> PlayerNamesViewController? {
        let numberOfPlayers = Int(numberOfPlayersStepper.value)
        let playerNamesViewController = PlayerNamesViewController(
            coder: coder,
            numberOfPlayers: numberOfPlayers
        )
        playerNamesViewController?.delegate = self
        playerNamesViewController?.playerNames = playerNames

        return playerNamesViewController
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GamePlay" {
            guard let navigationController = segue.destination as? UINavigationController,
                  let gamePlayViewController = navigationController.topViewController as? GamePlayViewController
            else { fatalError() }

            let newGameConfig = GameCofiguration(
                numberOfPlayers: Int(numberOfPlayersStepper.value),
                playerNames: playerNames,
                environment: selectedEnvironmentLabel.text!,
                difficulty: selectedDifficultyLabel.text!
            )
            gamePlayViewController.newGameConfig = newGameConfig
        }
    }
}
