//
//  LeagueDetailsViewController.swift
//  SportsApp
//
//  Created by mariam mostafa on 5/13/22.
//  Copyright © 2022 mariam mostafa. All rights reserved.
//

import UIKit
import Kingfisher
struct UpcomingEventsResult{
    var upcomingEventImg:String=""
    var eventName:String=""
    var upcomingDate:String=""
    var upcomingTime:String=""
}
struct LatestEventResult{
    var latestEventImg:String=""
    var eventName:String=""
    var latestDate:String=""
    var latestTime:String=""
    var firstTeamName=""
    var secondTeamName=""
    var firstTeamScore=""
    var secondTeamScore=""
}


class LeagueDetailsViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    let upcomingIdentifier="upcomingCell"
    let lateastIdintifier="latestCell"
    let teamsIdentifier="teamsCell"
    
    
    var upcomingEventsArr:Array<UpcomingEventsResult>=[]
    var latestEventsArr:Array<LatestEventResult>=[]
    var teamsArr:Array<TeamData>=[]
    let indicator = UIActivityIndicatorView(style: .large)
    var presenter : LeaguesDetailsPresenter!
    var leagueItem:ResultView=ResultView(name: "", image: "", youtubeLink: "", id: "",countryName: "")
    
    var strSport: String = ""
    
    
    var appDelegate: AppDelegate!
    
    @IBOutlet weak var teamsCollectionView: UICollectionView!
    @IBOutlet weak var upcommingCollectionView: UICollectionView!
    @IBOutlet weak var latestResultCollectionView: UICollectionView!
    
    @IBAction func addFavBtn(_ sender: UIButton) {
        presenter.inserLeague(favoriteLeague: leagueItem, appDel: appDelegate)
    }
    
    @IBAction func backBtn(_ sender: UIButton) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
               
        appDelegate  = (UIApplication.shared.delegate as! AppDelegate)
          upcommingCollectionView.delegate = self
          latestResultCollectionView.delegate = self
        teamsCollectionView.delegate = self

          upcommingCollectionView.dataSource = self
          latestResultCollectionView.dataSource = self
          teamsCollectionView.dataSource = self
          self.view.addSubview(upcommingCollectionView)
          self.view.addSubview(latestResultCollectionView)
        self.view.addSubview(teamsCollectionView)
        
        print("Detailsssssssssssssssssssss\(strSport) && country\(leagueItem.countryName)")
        
         let layout=UICollectionViewFlowLayout()
              //UIScreen.main.bounds.width
              layout.itemSize=CGSize(width:UIScreen.main.bounds.width,height:  100)
              //upcommingCollectionView.collectionViewLayout=layout
              latestResultCollectionView.collectionViewLayout=layout
              //teamsCollectionView.collectionViewLayout=layout
              
        indicator.center = self.view.center
                     self.view.addSubview(indicator)
                     indicator.startAnimating()
                     
                     presenter = LeaguesDetailsPresenter(NWService: NetworkServices())
                     presenter.attachView(view: self)
                     
        presenter.getItems(endPoint: leagueItem.id)
        presenter.getTeamsData(sEndPoint: strSport, cEndPoint: leagueItem.countryName)
        
        
       /* let upcomingObj=UpcomingEventsResult(upcomingEventImg: "youtube.png", eventName: "Hello Mariam", upcomingDate: "12/1/2009", upcomingTime: "12:33")
        upcomingEventsArr.append(upcomingObj)
        let latestObj = LatestEventResult(latestEventImg: "youtube.png", eventName: "hello", latestDate:  "12/2/222", latestTime:  "10:02", eventScore: "1:2")
        latestEventsArr.append(latestObj)
        let teamsObj=TeamsResult(teamImg: "youtube.png", teamName: "hello")
        teamsArr.append(teamsObj)
        
        
    let upcomingObj2=UpcomingEventsResult(upcomingEventImg: "youtube.png", eventName: "Hello Mariam", upcomingDate: "12/1/2009", upcomingTime: "12:33")
               upcomingEventsArr.append(upcomingObj2)
               let latestObj2 = LatestEventResult(latestEventImg: "youtube.png", eventName: "hello", latestDate:  "12/2/222", latestTime:  "10:02", eventScore: "1:2")
               latestEventsArr.append(latestObj2)
               let teamsObj2=TeamsResult(teamImg: "youtube.png", teamName: "hello")
               teamsArr.append(teamsObj2)*/
    }
    
    
       func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
               if collectionView == upcommingCollectionView {
                return upcomingEventsArr.count
                  }
               if collectionView == latestResultCollectionView {
                   let size = collectionView.frame.size.width
                   return latestEventsArr.count
               }
               if collectionView == teamsCollectionView {
                   return teamsArr.count
               }
               return 0
       }
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         if collectionView == upcommingCollectionView {
                   let size = collectionView.frame.width
                      return CGSize(width: size, height: 140)
                  }
               if collectionView == latestResultCollectionView {
                   let size = UIScreen.main.bounds.width
                   return CGSize(width: size, height: 100)
               }
               if collectionView == teamsCollectionView {
                   let size = collectionView.frame.size.width
                   return CGSize(width: size, height: 120)
               }
        return CGSize(width: 0, height: 0)
    }
       
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == teamsCollectionView{
            let vc = storyboard?.instantiateViewController(withIdentifier: "teamDetails") as? TeamsDetailsViewController
            vc?.teamDetauils =  teamsArr[indexPath.row]
            navigationController?.pushViewController(vc!, animated: true)
        }
    }
    
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var teamCell = teamsCollectionView.dequeueReusableCell(withReuseIdentifier: teamsIdentifier, for: indexPath) as! TeamsCollectionViewCell
        
           if collectionView == upcommingCollectionView {
                let upcomingCell = upcommingCollectionView.dequeueReusableCell(withReuseIdentifier: upcomingIdentifier, for: indexPath) as! UpcomingCollectionViewCell
            upcomingCell.dateLabel.text=upcomingEventsArr[indexPath.row].upcomingDate
            upcomingCell.eventNameLabel.text=upcomingEventsArr[indexPath.row].eventName
            upcomingCell.upcomingImg.image=UIImage(named: upcomingEventsArr[indexPath.row].upcomingEventImg)
            upcomingCell.timeLabel.text=upcomingEventsArr[indexPath.row].upcomingTime
            
            
            let url = URL(string: upcomingEventsArr[indexPath.row].upcomingEventImg)
            upcomingCell.upcomingImg.kf.setImage(with: url,placeholder: UIImage(named: "noData.png"))

            
               return upcomingCell
           }

            if collectionView == latestResultCollectionView {
             let latestCell = collectionView.dequeueReusableCell(withReuseIdentifier: lateastIdintifier, for: indexPath) as! LatestCollectionViewCell
                      latestCell.scoreLabel.text=latestEventsArr[indexPath.row].latestDate
                      //latestCell.LatestImg.image=UIImage(named: latestEventsArr[indexPath.row].latestEventImg)
                      
                      latestCell.firstTeamNameLabel.text=latestEventsArr[indexPath.row].firstTeamName
                      latestCell.secondTeamNameLabel.text=latestEventsArr[indexPath.row].secondTeamName
                     
                     
                      //latestCell.LatestImg.image=UIImage(named: "gragBg.png")
                     
                      let score: String = "\(latestEventsArr[indexPath.row].firstTeamScore ) - \(latestEventsArr[indexPath.row].secondTeamScore)"
                          
                          latestCell.dateLabel.text=score
                      latestCell.timeLabel.text=latestEventsArr[indexPath.row].latestTime
                      let url = URL(string: latestEventsArr[indexPath.row].latestEventImg)
                      //latestCell.LatestImg.kf.setImage(with: url,placeholder: UIImage(named: "noData.png"))
print("hello from latest \(latestEventsArr[indexPath.row].secondTeamScore)")
                         return latestCell
                     
       }
        if collectionView == teamsCollectionView{
            
            let url = URL(string: teamsArr[indexPath.row].logoImage)
            teamCell.teamImg.kf.setImage(with: url,placeholder: UIImage(named: "noData.png"))
            teamCell.teamNameLabel.text=teamsArr[indexPath.row].teamName
            return teamCell
        }
       
        return teamCell
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
extension LeagueDetailsViewController : LeaguesTableViewProtocol {
    func stopAnimating() {
        indicator.stopAnimating()
    }
    func renderTableView(){
        upcomingEventsArr = presenter.upcomingResult.map({ (item) -> UpcomingEventsResult in
            let res:UpcomingEventsResult = UpcomingEventsResult(upcomingEventImg: item.upcomingEventImg, eventName: item.eventName, upcomingDate: item.upcomingDate, upcomingTime: item.upcomingTime)
                return res
            })
        
        latestEventsArr = presenter.latestResult.map({ (item) -> LatestEventResult in
           let res:LatestEventResult = LatestEventResult(latestEventImg: item.latestEventImg, eventName: item.eventName, latestDate: item.latestDate, latestTime: item.latestTime,firstTeamName: item.firstTeamName,secondTeamName: item.secondTeamName,firstTeamScore: item.firstTeamScore,secondTeamScore: item.secondTeamScore)
                return res
            })
        
        teamsArr = presenter.teamFetchedData.map({ (item) -> TeamData in
            let res:TeamData = TeamData(teamName: item.teamName, leagueName: item.leagueName, countryName: item.countryName, stadiumName: item.stadiumName, facebookLink: item.facebookLink, instagramLink: item.instagramLink, twitterLink: item.twitterLink, youtubeLink: item.youtubeLink, websiteLink: item.websiteLink, stadiumImage: item.stadiumImage, logoImage: item.logoImage)
                return res
            })
        self.upcommingCollectionView.reloadData()
        self.latestResultCollectionView.reloadData()
        self.teamsCollectionView.reloadData()

    }
              
}





