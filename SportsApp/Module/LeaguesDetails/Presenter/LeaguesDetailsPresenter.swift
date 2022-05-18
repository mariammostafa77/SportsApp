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
        var allEventsResult:[LeaguesDetailsItem]=[]
        var upcomingResult : [UpcomingEventsResult]=[] // model
        var latestResult : [LatestEventResult]=[]
        weak var view : LeaguesTableViewProtocol!  // DI
        
    var teamFetchedData:[TeamData] = []
    let networkService = NetworkServices()
    
        init(NWService : LeaguesDetailServiceProtocol){}
        func attachView(view: LeaguesTableViewProtocol){
            self.view = view
        }
       func getItems(endPoint:String){
                let service = NetworkServices()
           service.fetchSLeagesDetails(endPoint : endPoint,complitionHandler: {[weak self] (result1) in
                self?.allEventsResult = result1 ?? []

               let currentDate = Date()
           for i in 0...self!.allEventsResult.count-1 {
                var eventDateString = self!.allEventsResult[i].dateEvent ?? ""
                eventDateString.append("T00:00:00+0000")
            let eventDate=self!.formatDate(stringDate: eventDateString)
               print("eventDate = \(eventDate)")
               if( eventDate < currentDate){
                   let latestEvent=LatestEventResult(latestEventImg: self!.allEventsResult[i].strThumb ?? "", eventName: self!.allEventsResult[i].strEvent ?? "", latestDate: self!.allEventsResult[i].dateEvent ?? "", latestTime: self!.allEventsResult[i].strTime ?? "", firstTeamName: self!.allEventsResult[i].strHomeTeam ?? "",secondTeamName: self!.allEventsResult[i].strAwayTeam ?? "", firstTeamScore:self!.allEventsResult[i].intHomeScore ?? "",secondTeamScore: self!.allEventsResult[i].intAwayScore ?? "" )
                   self!.latestResult.append(latestEvent)
               }else{
                   let upcomingEvent=UpcomingEventsResult(eventName: self!.allEventsResult[i].strEvent ?? "", upcomingDate: self!.allEventsResult[i].dateEvent ?? "", upcomingTime: self!.allEventsResult[i].strTime ?? "")
                   self!.upcomingResult.append(upcomingEvent)
               }
               }
               print("from presenter all events = \(self!.allEventsResult.count)")
               print("from presenter leatest = \(self!.latestResult.count)")
               print("from presenter upcoming = \(self!.upcomingResult.count)")

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
    func formatDate(stringDate:String) -> Date {
           let dateFormatter = DateFormatter()
           dateFormatter.locale = Locale(identifier: "en_US_POSIX")
           dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
           let myDate = dateFormatter.date(from:stringDate)!
           
           return myDate
       }
}
