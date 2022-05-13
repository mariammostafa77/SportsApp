//
//  FavoriteTableViewCell.swift
//  SportsApp
//
//  Created by user189298 on 5/13/22.
//  Copyright © 2022 mariam mostafa. All rights reserved.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet weak var favoriteView: UIView!
    @IBOutlet weak var favLegueImageView: UIImageView!
    @IBOutlet weak var favYoutubeImageView: UIImageView!
    
    @IBOutlet weak var legueNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
