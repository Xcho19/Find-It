//
//  GameConfigurationTableViewController.swift
//  Find It
//
//  Created by Xcho on 16.01.22.
//

import UIKit

final class GameConfigurationTableViewController: UITableViewController {

    // MARK: - Model

    private var playerNames: [String] = []
    private var selectedEnvironment: String?
    private var selectedDifficulty: String?

    // MARK: - Subviews

    @IBOutlet private var numberOfPlayersLabel: UILabel!
    @IBOutlet private var numberOfPlayersStepper: UIStepper!
    @IBOutlet private var selectedEnvironmentLabel: UILabel!
    @IBOutlet private var selectedDifficultyLabel: UILabel!
    @IBOutlet private var startButton: UIBarButtonItem!

    // MARK: - Helpers

    private func updateNumberOfPlayers() {
        numberOfPlayersLabel.text = "\(Int(numberOfPlayersStepper.value))"
    }

    private func checkStartButton() {
        startButton.isEnabled = !playerNames.isEmpty &&
        selectedEnvironment != nil &&
        selectedDifficulty != nil
    }

    // MARK: - Callbacks

    @IBAction func numberOfPlayersStepperValueChanged(_ sender: UIStepper) {
        updateNumberOfPlayers()
        startButton.isEnabled = false
    }

    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }

    // MARK: - Segues

    @IBSegueAction func openPlayerNames(coder: NSCoder) -> PlayerNamesViewController? {
        let numberOfPlayers = Int(numberOfPlayersStepper.value)
        let playerNamesViewController = PlayerNamesViewController(
            coder: coder,
            numberOfPlayers: numberOfPlayers,
            playerNames: playerNames
        )
        playerNamesViewController?.delegate = self

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
            guard
                let navigationController = segue.destination as? UINavigationController,
                let gamePlayViewController = navigationController.topViewController as? GamePlayViewController
            else { fatalError() }

            gamePlayViewController.newGameConfig = .init(
                numberOfPlayers: Int(numberOfPlayersStepper.value),
                playerNames: playerNames,
                environment: selectedEnvironmentLabel.text!,
                difficulty: selectedDifficultyLabel.text!
            )
        }
    }
}
extension GameConfigurationTableViewController: EnvironmentSelectionDelegate {
    func didSelectEnvironment(environment: String) {
        selectedEnvironmentLabel.text = environment
        selectedEnvironment = environment
        checkStartButton()
    }
}

extension GameConfigurationTableViewController: DifficultySelectionDelegate {
    func didSelectDifficulty(difficulty: String) {
        selectedDifficultyLabel.text = difficulty
        selectedDifficulty = difficulty
        checkStartButton()
    }
}

extension GameConfigurationTableViewController: PlayerNamesViewControllerDelegate {
    func didAddPlayers(names: [String]) {
        playerNames = names
        checkStartButton()
    }
}
