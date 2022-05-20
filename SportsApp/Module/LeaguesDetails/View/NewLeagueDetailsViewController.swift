//
//  NewLeagueDetailsViewController.swift
//  SportsApp
//
//  Created by mariam mostafa on 5/17/22.
//  Copyright © 2022 mariam mostafa. All rights reserved.
//

import UIKit
import Kingfisher


struct AllEventResult{
    var EventImg:String=""
    var eventName:String=""
    var eventDate:String=""
    var eventTime:String=""
    var firstTeamName=""
    var secondTeamName=""
    var firstTeamScore=""
    var secondTeamScore=""
}

struct UpcomingEventsResult{
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
    
    @IBOutlet weak var teamsView: UIView!
    @IBOutlet weak var latestView: UIView!
    @IBOutlet weak var upcomingView: UIView!
    @IBOutlet weak var leagueNameLabel: UILabel!
    let upcomingIdentifier="upcomingCell"
    let lateastIdintifier="latestCell"
    let teamsIdentifier="teamsCell"
    var appDelegate: AppDelegate!
    var upcomingEventsArr:Array<AllEventResult>=[]
    var latestEventsArr:Array<AllEventResult>=[]
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
        upcomingLayout.itemSize=CGSize(width:upcomingCollectionView.frame.width,height:  upcomingCollectionView.frame.height)
            upcomingLayout.scrollDirection = .horizontal
            upcomingCollectionView.collectionViewLayout=upcomingLayout

        
        teamsCollectionView.delegate = self
        teamsCollectionView.dataSource = self
        let teamsLayout=UICollectionViewFlowLayout()
        teamsLayout.itemSize=CGSize(width:teamsCollectionView.frame.width/2,height:  teamsCollectionView.frame.height)
            teamsLayout.scrollDirection = .horizontal
            teamsCollectionView.collectionViewLayout=teamsLayout
        
        leagueNameLabel.text = leagueItem.name

        
        indicator.center = self.view.center
                     self.view.addSubview(indicator)
                     indicator.startAnimating()
                     
        presenter = LeaguesDetailsPresenter(NWService:NetworkServices())
                     presenter.attachView(view: self)
                     print("league id from view \(leagueItem.id)")
        print("league name from view \(leagueItem.name)")

        presenter.getItems(leagueId: leagueItem.id)
        presenter.getTeamsData(leagueName: leagueItem.name)
       // presenter.getTeamsData(sEndPoint: strSport, cEndPoint: leagueItem.countryName)
        print("league selected id \(leagueItem.id)")
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
                upcomingCell.dateLabel.text=upcomingEventsArr[indexPath.row].eventDate
                upcomingCell.eventNameLabel.text=upcomingEventsArr[indexPath.row].eventName
                 upcomingCell.timeLabel.text=upcomingEventsArr[indexPath.row].eventTime
                 
                    return upcomingCell
                }

                 if collectionView == latestCollectionView {
                       let latestCell = collectionView.dequeueReusableCell(withReuseIdentifier: lateastIdintifier, for: indexPath) as! NewLatestCollectionViewCell
                         
                         let dateTime : String = "\(latestEventsArr[indexPath.row].eventDate) - \(latestEventsArr[indexPath.row].eventTime)"
                         latestCell.dateTimeLabel.text=dateTime
                                               
                         latestCell.firstTeamNameLabel.text = latestEventsArr[indexPath.row].firstTeamName
                         latestCell.secondTeamNameLabel.text = latestEventsArr[indexPath.row].secondTeamName
                                              
                         
                         if latestEventsArr[indexPath.row].firstTeamScore == "" {
                             latestEventsArr[indexPath.row].firstTeamScore = "0"
                         }
                         if latestEventsArr[indexPath.row].secondTeamScore == "" {
                             latestEventsArr[indexPath.row].secondTeamScore = "0"
                         }
                         
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
    upcomingEventsArr=presenter.upcomingResult
    latestEventsArr=presenter.latestResult
        
        
        teamsArr = presenter.teamFetchedData.map({ (item) -> TeamData in
            let res:TeamData = TeamData(teamName: item.teamName, leagueName: item.leagueName, countryName: item.countryName, stadiumName: item.stadiumName, facebookLink: item.facebookLink, instagramLink: item.instagramLink, twitterLink: item.twitterLink, youtubeLink: item.youtubeLink, websiteLink: item.websiteLink, stadiumImage: item.stadiumImage, logoImage: item.logoImage)
                return res
            })
        handelNoData()
        self.upcomingCollectionView.reloadData()
        self.latestCollectionView.reloadData()
        self.teamsCollectionView.reloadData()

    }
    
    func handelNoData(){
         let labelNoTeams=UILabel(frame:CGRect(x:(teamsCollectionView.frame.origin.x+teamsCollectionView.frame.width/2)-75,y:teamsCollectionView.frame.origin.y+10,width:150,height:16))
        let labelNoLatest=UILabel(frame:CGRect(x:(latestCollectionView.frame.origin.x+latestCollectionView.frame.width/2)-90,y:latestCollectionView.frame.origin.y+10,width:180,height:16))
         let labelNoUpcoming=UILabel(frame:CGRect(x:(upcomingCollectionView.frame.origin.x+upcomingCollectionView.frame.width/2)-90,y:upcomingCollectionView.frame.origin.y+10,width:180,height:16))
        
        if upcomingEventsArr.count == 0 && latestEventsArr.count == 0 && teamsArr.count == 0 {
            teamsCollectionView.isHidden=true
            upcomingCollectionView.isHidden=true
            latestCollectionView.isHidden=true
            upcomingView.isHidden=true
            latestView.isHidden=true
            teamsView.isHidden=true
            let imgNoData = UIImageView(frame:CGRect(x:(UIScreen.main.bounds.width/2)-40,y:300,width:80,height:80))
                imgNoData.image=UIImage(named: "noData.png")
                imgNoData.tintColor = .lightGray
                let labelNoData=UILabel(frame: CGRect(x: imgNoData.frame.origin.x-20, y: imgNoData.frame.maxY+10, width:130, height: 16))
                labelNoData.text="No Data Found!!"
                labelNoData.textAlignment = .center
                self.view.addSubview(imgNoData)
                self.view.addSubview(labelNoData)
        }else{
            upcomingCollectionView.isHidden=false
            latestCollectionView.isHidden=false
            teamsCollectionView.isHidden=false
            upcomingView.isHidden=false
            latestView.isHidden=false
            teamsView.isHidden=false
            
            if upcomingEventsArr.count == 0{
                    upcomingCollectionView.isHidden=true
                    labelNoUpcoming.text="No Upcoming Events!"
                    labelNoUpcoming.textAlignment = .center
                labelNoUpcoming.textColor = .lightGray
                    self.view.addSubview(labelNoUpcoming)
                }else{
                    upcomingCollectionView.isHidden=false
                labelNoUpcoming.isHidden=true
                }
                if latestEventsArr.count == 0{
                    latestCollectionView.isHidden=true
                    labelNoLatest.text="No Leatest Events!"
                    labelNoLatest.textAlignment = .center
                    labelNoLatest.textColor = .lightGray
                    self.view.addSubview(labelNoLatest)
                }else{
                    upcomingCollectionView.isHidden=false
                    labelNoLatest.isHidden=true
                }
                
                if teamsArr.count == 0{
                    teamsCollectionView.isHidden=true
                    labelNoTeams.text="No Teams Found!!"
                    labelNoTeams.textAlignment = .center
                    labelNoTeams.textColor = .lightGray
                    self.view.addSubview(labelNoTeams)
                }else{
                    upcomingCollectionView.isHidden=false
                    labelNoTeams.isHidden=true
                }
                
                
            }
        }
        
            
}





