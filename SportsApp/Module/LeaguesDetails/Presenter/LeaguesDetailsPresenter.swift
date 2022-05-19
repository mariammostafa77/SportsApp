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
        var allEventsResult:[AllEventResult]=[]
        var upcomingResult : [AllEventResult]=[] // model
        var latestResult : [AllEventResult]=[]
        weak var view : LeaguesTableViewProtocol!  // DI
        
    var teamFetchedData:[TeamData] = []
    let networkService = NetworkServices()
    
        init(NWService : LeaguesDetailServiceProtocol){}
        func attachView(view: LeaguesTableViewProtocol){
            self.view = view
        }
    
    
    func getItems(leagueId : String){
        networkService.fetchSLeagesDetails(endPoint: leagueId, complitionHandler: { [weak self] (detailsResult) in
            print(detailsResult!)
            self?.allEventsResult = detailsResult ?? []
            print("count of all events \(self!.allEventsResult.count)")
            
            
            let currentDate = Date()
            if(self!.allEventsResult.count != 0){
                    for i in 0...self!.allEventsResult.count-1 {
                         var eventDateString = self!.allEventsResult[i].eventDate
                         eventDateString.append("T00:00:00+0000")
                     let eventDate=self!.formatDate(stringDate: eventDateString)
                        print("eventDate = \(eventDate)")
                        if( eventDate < currentDate){
                            self!.latestResult.append(self!.allEventsResult[i])
                        }else{
                            self!.upcomingResult.append(self!.allEventsResult[i])
                        }
                        }
                        print("from presenter all events = \(self!.allEventsResult.count)")
                        print("from presenter leatest = \(self!.latestResult.count)")
                        print("from presenter upcoming = \(self!.upcomingResult.count)")
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
    func formatDate(stringDate:String) -> Date {
           let dateFormatter = DateFormatter()
           dateFormatter.locale = Locale(identifier: "en_US_POSIX")
           dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
           let myDate = dateFormatter.date(from:stringDate)!
           
           return myDate
       }
}
