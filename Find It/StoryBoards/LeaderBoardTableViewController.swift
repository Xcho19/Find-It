//
//  LeaderBoardTableViewController.swift
//  Find It
//
//  Created by Xcho on 14.03.22.
//

import UIKit

protocol LeaderBoardTableViewControllerDelegate: AnyObject {
    func didSelectPlayer(players: [Player])
}

final class LeaderBoardTableViewController: UITableViewController {
    weak var delegate: LeaderBoardTableViewControllerDelegate?

    // MARK: - Subviews

    @IBOutlet var continueBarButton: UIBarButtonItem!

    // MARK: - Model

    private var isSelected = false
    var selectedPlayer: Player?
    var deSelectedPlayer: Player?
    var players: [Player] = []
    var wordsShown = 0

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        continueBarButton.isEnabled = false
    }

    // MARK: - Helpers

    private func checkForWinner(sender: Any?) {
        if wordsShown >= 5 {
            guard let highestScore = players.map({ $0.score }).max() else { return }

            players = players.filter { $0.score == highestScore }

            if players.count > 1 {
                dismiss(animated: true)
            } else {
                performSegue(withIdentifier: "WinnerSegue", sender: sender)
            }
        } else {
            dismiss(animated: true)
        }
    }

    // MARK: - Callbacks

    @IBAction func didTapContinue(_ sender: UIBarButtonItem) {
        delegate?.didSelectPlayer(players: players)
        checkForWinner(sender: sender)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
    -> Int { players.count }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeaderBoardCell", for: indexPath)
        let player = players[indexPath.row]
        cell.textLabel?.text = player.name
        cell.detailTextLabel?.text = "\(player.score)"
        cell.selectionStyle = .none

        return cell
    }

    override func tableView(
        _ tableView: UITableView, didSelectRowAt indexPath: IndexPath
    ) {
        guard
            let cell = tableView.cellForRow(at: indexPath)
        else { return }

        if selectedPlayer == players[indexPath.row] { return }

        selectedPlayer = players[indexPath.row]

        selectedPlayer?.score += 1
        cell.detailTextLabel?.text = "\(selectedPlayer?.score ?? 0)"
        continueBarButton.isEnabled = true
    }

    override func tableView(
        _ tableView: UITableView, didDeselectRowAt indexPath: IndexPath
    ) {
        guard
            let cell = tableView.cellForRow(at: indexPath)
        else { return }

        if deSelectedPlayer == players[indexPath.row] { return }

        deSelectedPlayer = players[indexPath.row]

        deSelectedPlayer?.score -= 1
        cell.detailTextLabel?.text = "\(selectedPlayer?.score ?? 0)"
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "WinnerSegue" {
            guard let winnerController = segue.destination as? WinnerViewController
            else { fatalError() }

            winnerController.winnerName = players.first!.name
        }
    }
}
