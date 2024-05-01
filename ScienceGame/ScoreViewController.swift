//
//  ScoreViewController.swift
//  ScienceGame
//
//  Created by NMM on 18/04/2024.
//

import UIKit

/*
 It handles the display of the game's final score and results,
 including UI customization for button styling
 */
class ScoreViewController: UIViewController {
    
    // MARK: - Properties
    
    var score: Int = 0
    var lives: Int = 0
    
    // MARK: - Outlets
    
    // Button that allows user to return to the home screen
    @IBOutlet weak var homeBtn: UIButton!
    
    // Label displaying the result of the game (e.g., "Game Over", "Winner")
    @IBOutlet weak var resultLabel: UILabel!
    
    // Label displaying the final score
    @IBOutlet weak var scoreLabel: UILabel!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
        // Customises the home button with rounded corners
        homeBtn.layer.cornerRadius = homeBtn.frame.height / 2
        homeBtn.layer.borderWidth = 1.0
        homeBtn.layer.borderColor = UIColor.black.cgColor
        homeBtn.layer.masksToBounds = true
    }
    
    // MARK: - UI Updates
    
    //Updates the user interface based on the current score and remaining lives
    private func updateUI() {
        scoreLabel.text = "Score: \(score)" // Displays the final score
        if lives <= 0 {
            resultLabel.text = "Game Over" //Displays the game is over due to running out of lives
        } else if score > 0 {
            resultLabel.text = "Winner" // Indicates the player has won
        } else {
            resultLabel.text = "Try Again"
        }
    }
}
