//
//  LeaguesTableViewCell.swift
//  SportsApp
//
//  Created by mariam mostafa on 5/11/22.
//  Copyright © 2022 mariam mostafa. All rights reserved.
//

import UIKit
class LeaguesTableViewCell: UITableViewCell {

    @IBOutlet weak var leagueName: UILabel!
    @IBOutlet weak var leagueImg: UIImageView!
    @IBAction func leagueVideoBtn(_ sender: UIButton) {
        let tableObj = LeaguesTableViewController()
        tableObj.displayvideo()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
}
