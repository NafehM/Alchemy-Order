//
//  ElementTableViewCell.swift
//  ScienceGame
//
//  Created by NMM on 13/04/2024.
//

import UIKit

class ElementTableViewCell: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet weak var elementView: UIView!
    @IBOutlet weak var elementImageView: UIImageView!
    @IBOutlet weak var elementLabel: UILabel!
    
    // MARK: - Cell Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
