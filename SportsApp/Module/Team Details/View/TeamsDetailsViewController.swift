//
//  TeamsDetailsViewController.swift
//  SportsApp
//
//  Created by user189298 on 5/16/22.
//  Copyright © 2022 mariam mostafa. All rights reserved.
//

import UIKit


struct TeamData {
    var teamName: String
    var leagueName: String
    var countryName: String
    var stadiumName: String
    var facebookLink: String
    var instagramLink: String
    var twitterLink: String
    var youtubeLink: String
    var websiteLink: String
    var stadiumImage: String
    var logoImage: String
}


class TeamsDetailsViewController: UIViewController {
    
    @IBOutlet weak var stadiumImg: UIImageView!
    @IBOutlet weak var teaLlogoImg: UIImageView!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var leagueNameLabel: UILabel!
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var stadiumNameLabel: UILabel!
    
    var teamDetauils: TeamData  = TeamData(teamName: "", leagueName: "", countryName: "", stadiumName: "Stadium Name", facebookLink: "", instagramLink: "", twitterLink: "", youtubeLink: "", websiteLink: "", stadiumImage: "", logoImage: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        teamNameLabel.text = teamDetauils.teamName
        countryNameLabel.text = teamDetauils.countryName
        leagueNameLabel.text = teamDetauils.leagueName
        stadiumNameLabel.text = teamDetauils.stadiumName
        let logoUrl = URL(string: teamDetauils.logoImage)
        let stadiumImgLink = URL(string: teamDetauils.stadiumImage)
        teaLlogoImg.kf.setImage(with: logoUrl,placeholder: UIImage(named: "defaultTeamLogo"))
        stadiumImg.kf.setImage(with: stadiumImgLink,placeholder: UIImage(named: "stadium"))
    }
    
    @IBAction func websiteBtn(_ sender: UIButton) {
        
        let websiteUrl = NSURL(string: "http://"+teamDetauils.websiteLink)
        
        if UIApplication.shared.canOpenURL(websiteUrl! as URL) {
            UIApplication.shared.openURL(websiteUrl! as URL)
        } else {
            UIApplication.shared.openURL(NSURL(string: "http://google.com/")! as URL)
        }
    }
    
    @IBAction func facebookBtn(_ sender: UIButton) {
        let facebookUrl = NSURL(string: "https://"+teamDetauils.facebookLink)
        if UIApplication.shared.canOpenURL(facebookUrl! as URL) {
            UIApplication.shared.openURL(facebookUrl! as URL)
        } else {
            UIApplication.shared.openURL(NSURL(string: "http://facebook.com/")! as URL)
        }
    }
    
    @IBAction func instegramBtn(_ sender: Any) {
        let instagramUrl = NSURL(string:"https://"+teamDetauils.instagramLink+"/")
        if UIApplication.shared.canOpenURL(instagramUrl! as URL) {
            UIApplication.shared.openURL(instagramUrl! as URL)
        } else {
            UIApplication.shared.openURL(NSURL(string: "https://www.instagram.com/"
)! as URL)
        }
    }
    
    @IBAction func twitterBtn(_ sender: UIButton) {
        let twitterUrl = NSURL(string: "https://"+teamDetauils.instagramLink)
        if UIApplication.shared.canOpenURL(twitterUrl! as URL) {
            UIApplication.shared.openURL(twitterUrl! as URL)
        } else {
            UIApplication.shared.openURL(NSURL(string: "https://twitter.com/")! as URL)
        }
    }
    
    @IBAction func youtubeBtn(_ sender: UIButton) {
        let youtubeId = "SxTYjptEzZs"
        var youtubeUrl = NSURL(string:"youtube://\(youtubeId)")!
        if UIApplication.shared.canOpenURL(youtubeUrl as URL){
            UIApplication.shared.openURL(youtubeUrl as URL)
        } else{
            var myUrl = teamDetauils.youtubeLink
           if(myUrl == ""){
                myUrl="www.youtube.com/watch?v=eRrMaxAE-SY"
            }
            youtubeUrl = NSURL(string:"https://"+myUrl)!
            UIApplication.shared.openURL(youtubeUrl as URL)
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
