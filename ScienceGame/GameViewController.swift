//
//  GameViewController.swift
//  ScienceGame
//
//  Created by NMM on 11/04/2024.
//

import UIKit

///A view controller that manages the game interface, including an interactive table of elements.
class GameViewController : UIViewController,
                           UITableViewDataSource,
                           UITableViewDelegate,
                           UITableViewDragDelegate,
                           UITableViewDropDelegate {
    // MARK: - Properties
    
    // Identifier for the table view cells.
    let cellIdentifier = "elementCellID"
    
    // Reference to the app's delegate to access shared properties and methods.
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    // MARK: - Outlets
    
    @IBOutlet weak var elementTableView: UITableView!
    
    @IBOutlet weak var submitBtn: UIButton!
    
    // MARK: - Actions
    
    @IBAction func submitBtn(_ sender: Any) {
        handleGameScoreEvent()
    }
    
    // MARK: - Computed Properties
    
    //To access elements from AppDelegate's MyModel
    var elements: [Element] {
        return (UIApplication.shared.delegate as! AppDelegate).myModel.getElements()
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set the table view's delegates to manage content, interactions and drag-drop operations
        elementTableView.delegate = self
        elementTableView.dataSource = self
        elementTableView.dragDelegate = self
        //Set this view controller as the drop delegate for the collection view
        elementTableView.dropDelegate = self
        elementTableView.dragInteractionEnabled = true // Enable drag and drop
        
        //Styling the Table View & Cell
        elementTableView.showsVerticalScrollIndicator = false
//        elementTableView.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Shuffle the elements and reset the game with every new view
        appDelegate.myModel.shuffleElements()
        
        //to reset the score
        appDelegate.myModel.resetGame()
        
        //Reload the tableView to display the new order of elements.
        elementTableView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //Style the submit button with rounded corners and a border
        styleButton(submitBtn)
    }
    
    
    // MARK: - Table View Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return appDelegate.myModel.getElements().count
        return elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ElementTableViewCell
        let element = elements[indexPath.row].getElementName()
        
        //Configure the cell with element data
        cell.elementLabel.text = element
        cell.elementImageView.image = UIImage(named: element)
        cell.elementView.layer.cornerRadius = cell.elementView.frame.height / 2.2
        cell.elementImageView.layer.cornerRadius = cell.elementImageView.frame.height / 2
        return cell
    }
    
    // MARK: - Table View Delegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90 //Set a fixed height for all rows
    }
    
    // MARK: - Drag Delegate
    
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
//        print("Starting drag for item at \(indexPath)")
        let provider = NSItemProvider(object: elements[indexPath.row].getElementName() as NSString)
        let dragItem = UIDragItem(itemProvider: provider)
        dragItem.localObject = elements[indexPath.row]
        return [dragItem]
    }
    
    // MARK: - Drop Delegate
    
    func tableView(_ tableView: UITableView, canHandle session: UIDropSession) -> Bool {
//        print("canHandle works")
        return session.canLoadObjects(ofClass: NSString.self)
    }
    
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        if tableView.hasActiveDrag {
//            print("dropSessionDidUpdate works")
            return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }
        return UITableViewDropProposal(operation: .forbidden)
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
//        print("canMoveRowAt works")
        return true //Allows every row in the table view to be movable
    }
    
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
//        print("performDropWith works")
        let destinationIndexPath: IndexPath
        
        if let indexPath = coordinator.destinationIndexPath {
            destinationIndexPath = indexPath
        } else {
            let section = tableView.numberOfSections - 1
            let row = tableView.numberOfRows(inSection: section)
            destinationIndexPath = IndexPath(row: row, section: section)
        }
        
        coordinator.session.loadObjects(ofClass: NSString.self) { [weak self] items in
            guard let `self` = self,
                  let strings = items as? [String],
                  let draggedElementName = strings.first,
                  let sourceIndex = self.appDelegate.myModel.elements.firstIndex(where: { $0.getElementName() == draggedElementName })
            else {
                return
            }
//            print("Attempting to move from \(sourceIndex) to \(destinationIndexPath.row)")
            
            tableView.performBatchUpdates({
                self.appDelegate.myModel.moveElement(from: sourceIndex, to: destinationIndexPath.row)
                tableView.moveRow(at: IndexPath(row: sourceIndex, section: 0), to: destinationIndexPath)
            }, completion: { finished in
            })
        }
    }
    
    // MARK: - Private Methods
    
    // Handles game score updates and navigation based on the game state
    func handleGameScoreEvent() {
        if appDelegate.myModel.areElementsOrdered() {
            //If ordered correctly, update score and segue to ScoreViewController
            appDelegate.myModel.updateScore(with: 10)
            performSegue(withIdentifier: "showScoreSegue", sender: self)
        } else {
            
            // If not ordered correctly, use a life and show "Try again" message
            appDelegate.myModel.useLife()
            
            // Check if the game is over
            if appDelegate.myModel.lives <= 0 {
                //                showToast(with: "Game Over! No lives left.")
                performSegue(withIdentifier: "showScoreSegue", sender: self)
                
                // Optionally perform an action when no lives are left, like navigating to a different screen
            } else {
                showToast(with: "Try again! Lives left: \(appDelegate.myModel.lives)")
            }
        }
    }
    
    // Displays a temporary alert (Toast) message
    func showToast(with message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        self.present(alert, animated: true)
        
        // Duration of appearance: 2 seconds
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            alert.dismiss(animated: true)
        }
    }
    // Styles a UIButton to have rounded corners and a border.
    private func styleButton(_ button: UIButton) {
        submitBtn.layer.cornerRadius = submitBtn.frame.height / 2
        
        //adding border to the buttons
        submitBtn.layer.borderWidth = 1.0
        submitBtn.layer.borderColor = UIColor.black.cgColor
        submitBtn.layer.masksToBounds = true
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showScoreSegue" {
//            print("Preparing for segue with score: \(appDelegate.myModel.score)")
            if let destinationVC = segue.destination as? ScoreViewController {
                //To make sure this score property holds the updated score value
                destinationVC.score = appDelegate.myModel.score // Pass the updated score
                destinationVC.lives = appDelegate.myModel.lives
            }
        }
    }
    
}
