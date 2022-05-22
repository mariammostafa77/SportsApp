//
//  TeamsDetailsViewController.swift
//  SportsApp
//
//  Created by user189298 on 5/16/22.
//  Copyright © 2022 mariam mostafa. All rights reserved.
//

import UIKit

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
        
        print("Facebook: \(teamDetauils.facebookLink)")
        print("Instegram: \(teamDetauils.instagramLink)")
        print("Website: \(teamDetauils.websiteLink)")
        print("Youtube: \(teamDetauils.youtubeLink)")
        print("Twitter: \(teamDetauils.twitterLink)")
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
        let url = NSURL(string: "https://"+teamDetauils.facebookLink)
              if UIApplication.shared.canOpenURL(url! as URL) {
                  UIApplication.shared.openURL(url! as URL)
              } else {
                  UIApplication.shared.openURL(NSURL(string: "http://facebook.com/")! as URL)
              }
    }
    
    
    @IBAction func instegramBtn(_ sender: Any) {
        let url = NSURL(string:"https://"+teamDetauils.instagramLink+"/")
        if UIApplication.shared.canOpenURL(url! as URL) {
            UIApplication.shared.openURL(url! as URL)
        } else {
            UIApplication.shared.openURL(NSURL(string: "https://www.instagram.com/")! as URL)
        }

    }
    
    @IBAction func twitterBtn(_ sender: UIButton) {
        let url = NSURL(string: "https://"+teamDetauils.twitterLink)
               if UIApplication.shared.canOpenURL(url! as URL) {
                   UIApplication.shared.openURL(url! as URL)
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
    

}
