//
//  InstructionsViewController.swift
//  ScienceGame
//
//  Created by NMM on 18/04/2024.
//

import UIKit

class InstructionsViewController: UIViewController {
    
    // MARK: - Properties
    // The label to display instructions.
    private var instructionsLabel: UILabel!
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        configureInstructions()
    }
    
    // MARK: - Setup
    //Set up and configure the views within the controller.
    private func setupViews() {
        instructionsLabel = UILabel()
        instructionsLabel.numberOfLines = 0  //Allows multiple lines
        instructionsLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(instructionsLabel)
        
        // Constraints for the label
        NSLayoutConstraint.activate([
            instructionsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            instructionsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            instructionsLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    // Configures the instructions text with styled bullet points, bold highlights, and adjusted alignment for multiline text.
    private func configureInstructions() {
        let bulletList = [
            ("Start", "Tap 'Start' on the home screen."),
            ("Arrange", "Drag elements to order them by atomic number."),
            ("Submit", "Tap 'Submit' to check your order."),
            ("Scoring", "Correct orders gain points; mistakes cost a life."),
            ("Lives", "You have 3 lives. Game ends if all are lost."),
            ("Win", "Correctly order all elements to win.")
        ]
        
        let normalAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 22)
        ]
        
        let boldAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 25)
        ]
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.headIndent = 35  //Indent for the text after the bullet
        paragraphStyle.firstLineHeadIndent = 15  //Indentation for the first line with the bullet
        paragraphStyle.paragraphSpacingBefore = 12.0
        paragraphStyle.paragraphSpacing = 12.0
        
        let attributedString = NSMutableAttributedString()
        
        for (keyword, description) in bulletList {
            let bulletPointString = "\u{2022} "
            let boldKeyword = NSAttributedString(string: "\(keyword): ", attributes: boldAttributes)
            let normalDescription = NSAttributedString(string: "\(description)\n", attributes: normalAttributes)
            
            attributedString.append(NSAttributedString(string: bulletPointString, attributes: normalAttributes))
            attributedString.append(boldKeyword)
            attributedString.append(normalDescription)
        }
        
        instructionsLabel.attributedText = attributedString
    }
}

