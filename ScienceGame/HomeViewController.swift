//
//  HomeViewController.swift
//  ScienceGame
//
//  Created by NMM on 03/04/2024.
//

import UIKit

class HomeViewController : UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var instructionBtn: UIButton!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //Customise the start button with rounded corners
        startBtn.layer.cornerRadius = startBtn.frame.height / 2
        startBtn.layer.borderWidth = 1.0
        startBtn.layer.borderColor = UIColor.black.cgColor
        startBtn.layer.masksToBounds = true
        
        //Customise the instruction button with rounded corners
        instructionBtn.layer.cornerRadius = instructionBtn.frame.height / 2
        instructionBtn.layer.borderWidth = 1.0
        instructionBtn.layer.borderColor = UIColor.black.cgColor
        instructionBtn.layer.masksToBounds = true
    }
}
