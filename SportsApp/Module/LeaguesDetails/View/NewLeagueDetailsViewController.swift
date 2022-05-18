//
//  NewLeagueDetailsViewController.swift
//  SportsApp
//
//  Created by mariam mostafa on 5/17/22.
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


class NewLeagueDetailsViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    @IBOutlet weak var teamsCollectionView: UICollectionView!
    @IBOutlet weak var latestCollectionView: UICollectionView!
    @IBOutlet weak var upcomingCollectionView: UICollectionView!
    
    let upcomingIdentifier="upcomingCell"
    let lateastIdintifier="latestCell"
    let teamsIdentifier="teamsCell"
    var appDelegate: AppDelegate!
    var upcomingEventsArr:Array<UpcomingEventsResult>=[]
    var latestEventsArr:Array<LatestEventResult>=[]
    var teamsArr:Array<TeamData>=[]
    let indicator = UIActivityIndicatorView(style: .large)
    var presenter : LeaguesDetailsPresenter!
    var present: LeaguesDetailsPresenter!
    var leagueItem:ResultView=ResultView(name: "", image: "", youtubeLink: "", id: "",countryName: "")
    var strSport: String = ""
    
    @IBAction func btnBack(_ sender: UIButton) {
    }
    @IBAction func btnAddFav(_ sender: UIButton) {
        presenter.inserLeague(favoriteLeague: leagueItem, appDel: appDelegate)
        //print("In Core Data ..\(leagueItem.name)")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        appDelegate  = (UIApplication.shared.delegate as! AppDelegate)
        
        print("from fav \(leagueItem.name)")
        
        upcomingCollectionView.delegate = self
        upcomingCollectionView.dataSource = self
        let latestLayout=UICollectionViewFlowLayout()
        latestLayout.itemSize=CGSize(width:UIScreen.main.bounds.width,height:  100)
        latestCollectionView.collectionViewLayout=latestLayout
        
        
        latestCollectionView.delegate = self
        latestCollectionView.dataSource = self
        let upcomingLayout=UICollectionViewFlowLayout()
        upcomingLayout.itemSize=CGSize(width:upcomingCollectionView.frame.width/2,height:  upcomingCollectionView.frame.height)
            upcomingLayout.scrollDirection = .horizontal
            upcomingCollectionView.collectionViewLayout=upcomingLayout

        
        teamsCollectionView.delegate = self
        teamsCollectionView.dataSource = self
        let teamsLayout=UICollectionViewFlowLayout()
        teamsLayout.itemSize=CGSize(width:teamsCollectionView.frame.width/2,height:  teamsCollectionView.frame.height)
            teamsLayout.scrollDirection = .horizontal
            teamsCollectionView.collectionViewLayout=teamsLayout

        indicator.center = self.view.center
                     self.view.addSubview(indicator)
                     indicator.startAnimating()
                     
                     presenter = LeaguesDetailsPresenter(NWService: NetworkServices())
        present = LeaguesDetailsPresenter(NWService: NetworkServices())
                     presenter.attachView(view: self)
                     
        presenter.getItems(endPoint: leagueItem.id)
        presenter.getTeamsData(leagueName: leagueItem.name)
       // presenter.getTeamsData(sEndPoint: strSport, cEndPoint: leagueItem.countryName)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            if collectionView == upcomingCollectionView {
                return upcomingEventsArr.count
               }
            if collectionView == latestCollectionView {
                return latestEventsArr.count
            }
            if collectionView == teamsCollectionView {
                return teamsArr.count
            }
            return 0
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == teamsCollectionView{
            let vc = storyboard?.instantiateViewController(withIdentifier: "teamDetails") as? TeamsDetailsViewController
            vc?.teamDetauils =  teamsArr[indexPath.row]
            navigationController?.pushViewController(vc!, animated: true)
        }
    }

     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let teamCell = teamsCollectionView.dequeueReusableCell(withReuseIdentifier: teamsIdentifier, for: indexPath) as! NewTeamCollectionViewCell
             
                if collectionView == upcomingCollectionView {
                     let upcomingCell = upcomingCollectionView.dequeueReusableCell(withReuseIdentifier: upcomingIdentifier, for: indexPath) as! NewUpcomingCollectionViewCell
                upcomingCell.dateLabel.text=upcomingEventsArr[indexPath.row].upcomingDate
                upcomingCell.eventNameLabel.text=upcomingEventsArr[indexPath.row].eventName
                 upcomingCell.timeLabel.text=upcomingEventsArr[indexPath.row].upcomingTime
                 
                    return upcomingCell
                }

                 if collectionView == latestCollectionView {
                  let latestCell = collectionView.dequeueReusableCell(withReuseIdentifier: lateastIdintifier, for: indexPath) as! NewLatestCollectionViewCell
                    
                    let dateTime : String = "\(latestEventsArr[indexPath.row].latestDate) - \(latestEventsArr[indexPath.row].latestTime)"
                    latestCell.dateTimeLabel.text=dateTime
                                          
                    latestCell.firstTeamNameLabel.text = latestEventsArr[indexPath.row].firstTeamName
                    latestCell.secondTeamNameLabel.text = latestEventsArr[indexPath.row].secondTeamName
                                         
                                          
                    let score: String = "\(latestEventsArr[indexPath.row].firstTeamScore ) - \(latestEventsArr[indexPath.row].secondTeamScore)"
                                              
                    latestCell.scoreLabel.text = score
                                          
                    
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

}
extension NewLeagueDetailsViewController : LeaguesTableViewProtocol {
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
        self.upcomingCollectionView.reloadData()
        self.latestCollectionView.reloadData()
        self.teamsCollectionView.reloadData()

    }
              
}





