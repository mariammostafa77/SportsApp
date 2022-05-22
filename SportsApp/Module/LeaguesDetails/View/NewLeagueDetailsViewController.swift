//
//  NewLeagueDetailsViewController.swift
//  SportsApp
//
//  Created by mariam mostafa on 5/17/22.
//  Copyright © 2022 mariam mostafa. All rights reserved.
//

import UIKit
import Kingfisher


class NewLeagueDetailsViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var teamsCollectionView: UICollectionView!
    @IBOutlet weak var latestCollectionView: UICollectionView!
    @IBOutlet weak var upcomingCollectionView: UICollectionView!
    
    @IBOutlet weak var addFavBtnOutlet: UIButton!
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
    var isFav : Int = -1
    
    @IBAction func btnBack(_ sender: UIButton) {
    }
    @IBAction func btnAddFav(_ sender: UIButton) {
        isFav=presenter.chechIfExist(favoriteLeagueId: leagueItem.id , appDel: appDelegate)
        if isFav == -1 {
             presenter.inserLeague(favoriteLeague: leagueItem, appDel: appDelegate)
            addFavBtnOutlet.setImage(UIImage(named: "favourite.png"), for: .normal)
        }else{
            addFavBtnOutlet.setImage(UIImage(named: "FavouritUnFill.png"), for: .normal)
            presenter.deleteLeague(favLeagueIndex: isFav, appDel: appDelegate)
            isFav = -1
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        appDelegate  = (UIApplication.shared.delegate as! AppDelegate)
        presenter = LeaguesDetailsPresenter(NWService:NetworkServices())
        presenter.attachView(view: self)
        
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
                     
        
                     print("league id from view \(leagueItem.id)")
        print("league name from view \(leagueItem.name)")

        presenter.getItems(leagueId: leagueItem.id)
        presenter.getTeamsData(leagueName: leagueItem.name)
       // presenter.getTeamsData(sEndPoint: strSport, cEndPoint: leagueItem.countryName)
        print("league selected id \(leagueItem.id)")
    }
    override func viewDidAppear(_ animated: Bool) {
        isFav = presenter.chechIfExist(favoriteLeagueId: leagueItem.id , appDel: appDelegate)
        print("from view is fav = \(isFav)")
        if isFav == -1 {
            addFavBtnOutlet.setImage(UIImage(named: "FavouritUnFill.png"), for: .normal)
        }else{
            addFavBtnOutlet.setImage(UIImage(named: "favourite.png"), for: .normal)
        }
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
                         
                         let dateTime : String = "\(latestEventsArr[indexPath.row].eventDate) , \(latestEventsArr[indexPath.row].eventTime)"
                         latestCell.dateTimeLabel.text=dateTime
                    if(latestEventsArr[indexPath.row].firstTeamName != ""){
                         latestCell.firstTeamNameLabel.text = latestEventsArr[indexPath.row].firstTeamName
                         latestCell.secondTeamNameLabel.text = latestEventsArr[indexPath.row].secondTeamName
                    }else{
                        latestCell.firstTeamNameLabel.text = "Unknown"
                        latestCell.secondTeamNameLabel.text = "Unknown"
                    }
                         
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
                teamCell.teamImg.layer.borderWidth = 1
                teamCell.teamImg.layer.masksToBounds = false
                teamCell.teamImg.layer.borderColor = UIColor.black.cgColor
                teamCell.teamImg.layer.cornerRadius = teamCell.teamImg.frame.height/2
                teamCell.teamImg.clipsToBounds = true
                
                 let url = URL(string: teamsArr[indexPath.row].logoImage)
                 teamCell.teamImg.kf.setImage(with: url,placeholder: UIImage(named: "defaultTeamLogo"))
                 teamCell.teamNameLabel.text=teamsArr[indexPath.row].teamName
                
                /*print("Facebook: \(teamsArr[indexPath.row].facebookLink)")
                print("Instegram: \(teamsArr[indexPath.row].instagramLink)")
                print("Website: \(teamsArr[indexPath.row].websiteLink)")
                print("Youtube: \(teamsArr[indexPath.row].youtubeLink)")
                print("Twitter: \(teamsArr[indexPath.row].twitterLink)")*/
                
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
                
            }
        }
        
            
}





