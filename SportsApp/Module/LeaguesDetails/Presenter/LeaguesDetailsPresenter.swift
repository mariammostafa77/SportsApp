//
//  LeaguesDetailsPresenter.swift
//  SportsApp
//
//  Created by mariam mostafa on 5/14/22.
//  Copyright © 2022 mariam mostafa. All rights reserved.
//

import Foundation
class LeaguesDetailsPresenter{
    //var NWService : MovieService! // service
        var allUpcomingResult:[LeaguesDetailsItem]=[]
    var allLatestResult:[LeaguesDetailsItem] = []
        var upcomingResult : [UpcomingEventsResult]=[] // model
        var latestResult : [LatestEventResult]=[]
        weak var view : LeaguesTableViewProtocol!  // DI
        
    var teamFetchedData:[TeamData] = []
    let networkService = NetworkServices()
    
        init(NWService : LeaguesDetailServiceProtocol){
            
        }
        func attachView(view: LeaguesTableViewProtocol){
            self.view = view
        }
       func getItems(endPoint:String){
             let service = NetworkServices()
        
        service.fetchSLeagesDetailsLatestResultWithAF(endPoint : endPoint,complitionHandler: {[weak self] (result1) in
             self?.allLatestResult = result1 ?? []
        print(self!.allLatestResult.count)
        for i in 0...self!.allLatestResult.count-1 {
            //if(self!.allResult[i].strStatus == "Match Finished"){}
                
                 let latestEvent=LatestEventResult(latestEventImg: self!.allLatestResult[i].strThumb ?? "", eventName: self!.allLatestResult[i].strEvent ?? "", latestDate: self!.allLatestResult[i].dateEvent ?? "", latestTime: self!.allLatestResult[i].strTime ?? "", firstTeamName: self!.allLatestResult[i].strHomeTeam ?? "",secondTeamName: self!.allLatestResult[i].strAwayTeam ?? "", firstTeamScore:self!.allLatestResult[i].intHomeScore ?? "",secondTeamScore: self!.allLatestResult[i].intAwayScore ?? "" )
            }
            print("from presenter \(self!.allLatestResult[0].intAwayScore ?? "" )")

            DispatchQueue.main.async {
            self?.view.stopAnimating()
            self?.view.renderTableView()
                }
            })
        
        service.fetchSLeagesDetailsUpcomingResultWithAF(endPoint: "", complitionHandler: {[weak self] (result1) in
                 self?.allUpcomingResult = result1 ?? []
            for i in 0...self!.allUpcomingResult.count-1 {
                let upcomingEvent = UpcomingEventsResult(upcomingEventImg: self!.allUpcomingResult[i].strThumb ?? "", eventName: self!.allUpcomingResult[i].strEvent ?? "", upcomingDate: self!.allUpcomingResult[i].dateEvent ?? "", upcomingTime: self!.allUpcomingResult[i].strTime ?? "")
                self!.upcomingResult.append(upcomingEvent)
            }
            DispatchQueue.main.async {
            self?.view.stopAnimating()
            self?.view.renderTableView()
                }
            })
        
    }
    
    func getTeamsData(leagueName : String){
        networkService.fetchTeamData(parametrs: ["l": leagueName]) {[weak self] (myResult) in
            self?.teamFetchedData = myResult!
            DispatchQueue.main.async {
                self?.view.stopAnimating()
                self?.view.renderTableView()
                }
        }
    }

    
    
    func inserLeague(favoriteLeague:ResultView,appDel:AppDelegate){
        let coreData = CoreDataService(appDelegate: appDel)
            coreData.insertLeague(leagueItem: favoriteLeague)
        }
}
