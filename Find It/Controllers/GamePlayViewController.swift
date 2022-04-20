//
//  GamePlayViewController.swift
//  Find It
//
//  Created by Xcho on 07.03.22.
//

import UIKit

final class GamePlayViewController: UIViewController {
    // MARK: - Model

    var newGameConfig = GameCofiguration()
    private var players = [Player]()
    private var usedWords = [String]()

    var wordsShown = 0
    var timer: Timer?
    var totalTime = 300

    // MARK: - Subviews

    @IBOutlet var showWordButton: UIButton!
    @IBOutlet var wordLabel: UILabel!
    @IBOutlet var timerLabel: UILabel!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setPlayers()
        showWordButton.setTitle("Show Word", for: .normal)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let radius = showWordButton.bounds.height / 4
        if showWordButton.layer.cornerRadius != radius {
            showWordButton.layer.cornerRadius = radius
        }
    }

    // MARK: - Helpers

    private func startOtpTimer() {
        self.totalTime = 300
        self.timer = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(updateTimer),
            userInfo: nil, repeats: true
        )
    }

    @objc private func updateTimer() {
        self.timerLabel.text = self.timeFormatted(self.totalTime)
        if totalTime != 0 {
            totalTime -= 1
        } else if let timer = self.timer {
            timer.invalidate()
            self.timer = nil
        }
    }

    private func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60

        return String(format: "%02d:%02d", minutes, seconds)
    }

    private func resetTimer() {
        if let timer = timer {
            timer.invalidate()
            totalTime = 300
            timerLabel.text = timeFormatted(totalTime)
        }
    }

    private func getWordsFor(environment: String, difficulty: String) {
        guard let environmentURL = Bundle.main.url(forResource: environment, withExtension: "plist")
        else { return }

        let environmentWords = Environment(withPlistAt: environmentURL)

        switch difficulty {
        case "Easy":
            getNewWord(from: environmentWords.easy)
        case "Medium":
            getNewWord(from: environmentWords.medium)
        case "Hard":
            getNewWord(from: environmentWords.hard)
        default:
            fatalError()
        }
    }

    private func getNewWord(from words: [String]) {
        if let randomWord = words.shuffled().first(where: {
            !usedWords.contains($0)
        }) {
            usedWords.append(randomWord)
            wordLabel.text = randomWord
        } else {
            wordLabel.text = "Out of words"
        }
    }

    private func setPlayers() {
        for playerName in newGameConfig.playerNames {
            let player = Player()
            player.name = playerName
            players.append(player)
        }
    }

    // MARK: - Callbacks

    var wordFound: Bool = false { didSet {
        showWordButton.setTitle(wordFound ? "Found It" : "Show Word", for: .normal)
    }}

    @IBAction func didTapWordButton(_ sender: Any) {

        wordFound.toggle()

        if wordFound {
            getWordsFor(
                environment: newGameConfig.environment,
                difficulty: newGameConfig.difficulty
            )
            startOtpTimer()
        } else {
            wordsShown += 1
            resetTimer()
            performSegue(withIdentifier: "Leaderboard", sender: sender)
        }
        UIView.animate(
            withDuration: 0.3,
            delay: 0,
            usingSpringWithDamping: 0.7,
            initialSpringVelocity: 0.1,
            options: []) {
                self.showWordButton.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
                self.showWordButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
    }

    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Leaderboard" {
            guard let navigationController = segue.destination as? UINavigationController,
                  let leaderBoardController = navigationController.topViewController as? LeaderBoardTableViewController
            else { fatalError() }

            leaderBoardController.delegate = self
            leaderBoardController.players = players
            leaderBoardController.wordsShown = wordsShown
        }
    }
}
extension GamePlayViewController: LeaderBoardTableViewControllerDelegate {
    func didSelectPlayer(players: [Player]) {
        self.players = players
    }
}
