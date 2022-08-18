//
//  CeldaProgramaTableViewCell.swift
//  AppTVFinal
//
//  Created by Ricardo Omar Martinez Nava on 16/08/22.
//

import UIKit

class CeldaProgramaTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imagePrograma: UIImageView!
    
    @IBOutlet weak var namePrograma: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
