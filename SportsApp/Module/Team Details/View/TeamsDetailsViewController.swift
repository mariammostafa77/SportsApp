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
    
    var teamDetauils: TeamData  = TeamData(teamName: "", leagueName: "", countryName: "", stadiumName: "", facebookLink: "", instagramLink: "", twitterLink: "", youtubeLink: "", websiteLink: "", stadiumImage: <#T##String#>, logoImage: "")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //teamNameLabel.text = teamDetauils.teamName
        
        
    }
    
    @IBAction func websiteBtn(_ sender: UIButton) {
    }
    
    @IBAction func facebookBtn(_ sender: UIButton) {
    }
    
    @IBAction func instegramBtn(_ sender: Any) {
    }
    
    @IBAction func twitterBtn(_ sender: UIButton) {
    }
    
    @IBAction func youtubeBtn(_ sender: UIButton) {
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
