//
//  LeaguesTableViewCell.swift
//  SportsApp
//
//  Created by mariam mostafa on 5/11/22.
//  Copyright © 2022 mariam mostafa. All rights reserved.
//

import UIKit
class LeaguesTableViewCell: UITableViewCell {
    var youtubeLink:String = ""
    weak var viewController : UIViewController?
    @IBOutlet weak var leagueName: UILabel!
    @IBOutlet weak var leagueImg: UIImageView!
    @IBOutlet weak var videoBtn: UIButton!
    @IBAction func leagueVideoBtn(_ sender: UIButton) {
        
        let youtubeId = "SxTYjptEzZs"
        var youtubeUrl = NSURL(string:"youtube://\(youtubeId)")!
        if UIApplication.shared.canOpenURL(youtubeUrl as URL){
            UIApplication.shared.openURL(youtubeUrl as URL)
        } else{
            let myUrl=youtubeLink
            if(myUrl != ""){
                youtubeUrl = NSURL(string:"https://"+myUrl)!
                UIApplication.shared.openURL(youtubeUrl as URL)
            }else{
                let alert = UIAlertController(title: "Info", message: "No youtube link for this league", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                viewController?.present(alert,animated: true,completion: nil)
            }
            
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
