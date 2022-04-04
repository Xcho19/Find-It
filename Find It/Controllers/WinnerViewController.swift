//
//  WinnerViewController.swift
//  Find It
//
//  Created by Xcho on 25.03.22.
//

import UIKit

final class WinnerViewController: UIViewController {

    // MARK: - Model

    var winnerName = ""

    // MARK: - Subviews

    @IBOutlet var winnerNameLabel: UILabel!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        winnerNameLabel.text =
        "The winner is \(winnerName).\n\(winnerName) you have shown great coordination skills!"
    }

    // MARK: - Callbacks

    @IBAction func didTapPlayAgain(_ sender: Any) {
        performSegue(withIdentifier: "PlayAgain", sender: sender)
    }
}
