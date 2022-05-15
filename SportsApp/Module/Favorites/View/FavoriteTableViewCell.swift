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
    
    @IBOutlet weak var legueNameLabel: UILabel!
    
    var favYoutubeLink:String = ""
    
    @IBAction func youtubeButton(_ sender: UIButton) {
        let youtubeId = "SxTYjptEzZs"
        var youtubeUrl = NSURL(string:"youtube://\(youtubeId)")!
        if UIApplication.shared.canOpenURL(youtubeUrl as URL){
            UIApplication.shared.openURL(youtubeUrl as URL)
        } else{
            var myUrl=favYoutubeLink
           if(myUrl == ""){
                myUrl="/www.youtube.com/watch?v=eRrMaxAE-SY"
            }
            youtubeUrl = NSURL(string:"https://"+myUrl)!
            UIApplication.shared.openURL(youtubeUrl as URL)
        }
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
