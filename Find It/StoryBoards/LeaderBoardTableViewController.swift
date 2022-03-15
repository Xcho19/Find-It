//
//  LeaderBoardTableViewController.swift
//  Find It
//
//  Created by Xcho on 14.03.22.
//

import UIKit

class LeaderBoardTableViewController: UITableViewController {

    var gameConfigurations = GameCofiguration()
    var playerPoints = 0

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int { gameConfigurations.numberOfPlayers}

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeaderBoardCell", for: indexPath)
        cell.textLabel?.text = gameConfigurations.playerNames[indexPath.row]

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath)
        else { return }
    }
}
