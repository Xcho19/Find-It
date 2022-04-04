//
//  GamePlayViewController.swift
//  Find It
//
//  Created by Xcho on 07.03.22.
//

import UIKit

class GamePlayViewController: UIViewController, LeaderBoardTableViewControllerDelegate {

    @IBOutlet var showWordButton: UIButton!
    @IBOutlet var wordLabel: UILabel!
    @IBOutlet var timerLabel: UILabel!

    var newGameConfig = GameCofiguration()
    var usedWords = [String]()
    var players: [Player] = []

    var timer: Timer?
    var totalTime = 300

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

    func didSelectPlayer(players: [Player]) {
        self.players = players
    }

    @IBSegueAction func openLeaderboard(coder: NSCoder) -> LeaderBoardTableViewController? {
        let leaderboardTableViewController = LeaderBoardTableViewController(coder: coder)
        leaderboardTableViewController?.delegate = self
        leaderboardTableViewController?.players = players

        return leaderboardTableViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        showWordButton.setTitle("Show Word", for: .normal)
        showWordButton.setTitle("", for: .highlighted)
    }

    override func viewDidLayoutSubviews() {
        showWordButton.titleLabel?.font = UIFont(name: "Chalkboard SE", size: 30)
        showWordButton.layer.cornerRadius = showWordButton.frame.height / 2
    }

    @IBAction func didTapWordButton(_ sender: Any) {
        if showWordButton.titleLabel?.text == "Show Word" {
            showWordButton.setTitle("Found It", for: .normal)
            startOtpTimer()
            getWordsFor(
                environment: newGameConfig.environment,
                difficulty: newGameConfig.difficulty
            )
        } else if showWordButton.titleLabel?.text == "Found It" {
            resetTimer()
            showWordButton.setTitle("Show Word", for: .normal)
            performSegue(withIdentifier: "Leaderboard", sender: sender)
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

            leaderBoardController.gameConfigurations = newGameConfig
        }
    }

}
