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

class LeaderBoardTableViewController: UITableViewController {

    weak var delegate: LeaderBoardTableViewControllerDelegate?

    var gameConfigurations = GameCofiguration()
    var player = Player()
    var players: [Player] = []
    var playerScore = 0

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func didTapContinue(_ sender: UIBarButtonItem) {
        delegate?.didSelectPlayer(players: players)
        dismiss(animated: true)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int { gameConfigurations.numberOfPlayers }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeaderBoardCell", for: indexPath)
        player.name = gameConfigurations.playerNames[indexPath.row]
        players.append(player)
        cell.selectionStyle = .none
        for player in players {
            cell.textLabel?.text = player.name
            cell.detailTextLabel?.text = "\(player.score)"
        }

        return cell
    }

    override func tableView(
        _ tableView: UITableView, didSelectRowAt indexPath: IndexPath
    ) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        cell.detailTextLabel?.text = "\(playerScore + 1)"
        for player in players where player.name == cell.textLabel?.text {
                player.score += 1
        }
    }

    override func tableView(
        _ tableView: UITableView, didDeselectRowAt indexPath: IndexPath
    ) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        cell.detailTextLabel?.text = "\(playerScore)"
    }
}
