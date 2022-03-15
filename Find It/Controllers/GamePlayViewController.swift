//
//  GamePlayViewController.swift
//  Find It
//
//  Created by Xcho on 07.03.22.
//

import UIKit

class GamePlayViewController: UIViewController {

    @IBOutlet var showWordButton: UIButton!
    @IBOutlet var wordLabel: UILabel!
    @IBOutlet var timerLabel: UILabel!

    var newGameConfig = GameCofiguration()
    var usedWords = [String]()

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
            var randomWord = environmentWords.easy.randomElement()
            while usedWords.contains(randomWord!) {
                randomWord = environmentWords.easy.randomElement()
            }
            wordLabel.text = randomWord
            usedWords.append(randomWord!)
        case "Medium":
            var randomWord = environmentWords.medium.randomElement()
            while usedWords.contains(randomWord!) {
                randomWord = environmentWords.medium.randomElement()
            }
            wordLabel.text = randomWord
            usedWords.append(randomWord!)
        case "Hard":
            var randomWord = environmentWords.hard.randomElement()
            while usedWords.contains(randomWord!) {
                randomWord = environmentWords.hard.randomElement()
            }
            wordLabel.text = randomWord
            usedWords.append(randomWord!)
        default:
            fatalError()
        }
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
