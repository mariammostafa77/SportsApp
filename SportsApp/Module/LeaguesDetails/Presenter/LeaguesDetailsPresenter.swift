//
//  LeaguesDetailsPresenter.swift
//  SportsApp
//
//  Created by mariam mostafa on 5/14/22.
//  Copyright © 2022 mariam mostafa. All rights reserved.
//

import Foundation
class LeaguesDetailsPresenter{
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
            self?.allEventsResult = detailsResult ?? []
            let currentDate = Date()
            if(self!.allEventsResult.count != 0){
                    for i in 0...self!.allEventsResult.count-1 {
                         var eventDateString = self!.allEventsResult[i].eventDate
                         eventDateString.append("T00:00:00+0000")
                     let eventDate=self!.formatDate(stringDate: eventDateString)
                        if( eventDate < currentDate){
                            self!.latestResult.append(self!.allEventsResult[i])
                        }else{
                            self!.upcomingResult.append(self!.allEventsResult[i])
                        }
                        }
            }
            
               DispatchQueue.main.async {
               self?.view.stopAnimating()
               self?.view.renderTableView()
                   }
               })
       }
    
     ///// Get Teams
    func getTeamsData(leagueName : String){
        networkService.fetchTeamData(parametrs: ["l": leagueName]) {[weak self] (myResult) in
            self?.teamFetchedData = myResult!
            DispatchQueue.main.async {
                self?.view.stopAnimating()
                self?.view.renderTableView()
                }
        }
    }
    func chechIfExist(favoriteLeagueId:String,appDel:AppDelegate)->Int{
        let coreData = CoreDataService(appDelegate: appDel)
        return coreData.searchIfExist(leagueItemId:favoriteLeagueId)
    }
    
    func deleteLeague(favLeagueIndex:Int,appDel:AppDelegate){
        let coreData = CoreDataService(appDelegate: appDel)
        let favs = coreData.fetchLegueData()
        coreData.deleteLeagueFromFav(leage: favs[favLeagueIndex])
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
