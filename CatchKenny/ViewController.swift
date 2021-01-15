//
//  ViewController.swift
//  CatchKenny
//
//  Created by Corey Walker on 1/14/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var kenny1: UIImageView!
    @IBOutlet weak var kenny2: UIImageView!
    @IBOutlet weak var kenny3: UIImageView!
    @IBOutlet weak var kenny4: UIImageView!
    @IBOutlet weak var kenny5: UIImageView!
    @IBOutlet weak var kenny6: UIImageView!
    @IBOutlet weak var kenny7: UIImageView!
    @IBOutlet weak var kenny8: UIImageView!
    @IBOutlet weak var kenny9: UIImageView!
    @IBOutlet weak var playAgainButton: UIButton!
    var timer = Timer()
    var kennyTimer = Timer()
    var counter = 0
    var score = 0
    var highScore = 0
    var COUNTER_DEFAULT = 10
    var kennyPosition = -2
    var position = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        kenny1.isUserInteractionEnabled = true
        kenny2.isUserInteractionEnabled = true
        kenny3.isUserInteractionEnabled = true
        kenny4.isUserInteractionEnabled = true
        kenny5.isUserInteractionEnabled = true
        kenny6.isUserInteractionEnabled = true
        kenny7.isUserInteractionEnabled = true
        kenny8.isUserInteractionEnabled = true
        kenny9.isUserInteractionEnabled = true
        
        var tapRecognizers: [UIGestureRecognizer] = []
        for _ in 1...9 {
            tapRecognizers.append(UITapGestureRecognizer(target: self, action: #selector(increaseScore)))
        }
        kenny1.addGestureRecognizer(tapRecognizers[0])
        kenny2.addGestureRecognizer(tapRecognizers[1])
        kenny3.addGestureRecognizer(tapRecognizers[2])
        kenny4.addGestureRecognizer(tapRecognizers[3])
        kenny5.addGestureRecognizer(tapRecognizers[4])
        kenny6.addGestureRecognizer(tapRecognizers[5])
        kenny7.addGestureRecognizer(tapRecognizers[6])
        kenny8.addGestureRecognizer(tapRecognizers[7])
        kenny9.addGestureRecognizer(tapRecognizers[8])
        
        resetTimer()
        resetScore()
        highScoreLabel.text = "High Score: \(highScore)"
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highScore")
        if storedHighScore != nil {
            highScore = (storedHighScore as? Int ?? 0)
            highScoreLabel.text = "High Score: \(highScore)"
        }
    }

    @objc func updateTimer() {
        counter -= 1
        if counter <= 5 {
            timerLabel.textColor = UIColor.red
        }
        timerLabel.text = "\(counter)"
        
        if counter == 0 {
            timer.invalidate()
            kennyTimer.invalidate()
            timerLabel.text = "Time's Up!"
            if score > highScore {
                highScore = score
                highScoreLabel.text = "High Score: \(highScore)"
                UserDefaults.standard.setValue(highScore, forKey: "highScore")
            }
            let alert = UIAlertController(title: "GAME OVER", message: "Time's up! Your Score was \(score)", preferredStyle: UIAlertController.Style.alert)
            let playAgainButton = UIAlertAction(title: "Play Again", style: UIAlertAction.Style.default) { (UIAlertAction) in
                self.playAgain()
            }
            let doneButton = UIAlertAction(title: "I'm Done", style: UIAlertAction.Style.cancel) { (UIAlertAction) in
                self.playAgainButton.isHidden = false
            }
            alert.addAction(playAgainButton)
            alert.addAction(doneButton)
            self.present(alert, animated: false, completion: nil)
        }
    }

    @objc private func increaseScore() {
        // only let the score increase while game is active
        // once timer runs out, we dont accumulate any more scoring
        if counter > 0 && timer.isValid {
            score += 1
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    private func playAgain() -> Void {
        resetScore()
        resetTimer()
    }
    
    private func resetTimer() -> Void {
        playAgainButton.isHidden = true
        counter = COUNTER_DEFAULT
        timerLabel.textColor = UIColor.black
        timerLabel.text = "\(counter)"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        kennyTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(moveKenny), userInfo: nil, repeats: true)
        moveKenny()
    }
    
    private func resetScore() -> Void {
        score = 0
        scoreLabel.text = "Score: \(score)"
    }
    
    @objc private func moveKenny() {
        kenny1.isHidden = true
        kenny2.isHidden = true
        kenny3.isHidden = true
        kenny4.isHidden = true
        kenny5.isHidden = true
        kenny6.isHidden = true
        kenny7.isHidden = true
        kenny8.isHidden = true
        kenny9.isHidden = true
        
        
        while position == kennyPosition {
            position = Int.random(in: 1..<10)
        }
        kennyPosition = position
        switch position {
            case 1:
                kenny1.isHidden = false
            case 2:
                kenny2.isHidden = false
            case 3:
                kenny3.isHidden = false
            case 4:
                kenny4.isHidden = false
            case 5:
                kenny5.isHidden = false
            case 6:
                kenny6.isHidden = false
            case 7:
                kenny7.isHidden = false
            case 8:
                kenny8.isHidden = false
            case 9:
                kenny9.isHidden = false
            default:
                return
        }
    }
    
    @IBAction func playAgainClicked(_ sender: UIButton) {
        playAgain()
    }
}

