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
    var allLatestResult:[LeaguesDetailsItem]=[]
        var upcomingResult : [UpcomingEventsResult]=[] // model
        var latestResult : [LatestEventResult]=[]
        weak var view : LeaguesTableViewProtocol!  // DI
        
        init(NWService : LeaguesDetailServiceProtocol){
            
        }
        func attachView(view: LeaguesTableViewProtocol){
            self.view = view
        }
       func getItems(endPoint:String){
             let service=NetworkServices()
        
        service.fetchSLeagesDetailsLatestResultWithAF(endPoint : endPoint,complitionHandler: {[weak self] (result1) in
           
             self?.allLatestResult = result1 ?? []
        print(self!.allLatestResult.count)
        for i in 0...self!.allLatestResult.count-1 {
            //if(self!.allResult[i].strStatus == "Match Finished"){}
                
                let latestEvent=LatestEventResult(latestEventImg: self!.allLatestResult[i].strThumb ?? "", eventName: self!.allLatestResult[i].strEvent ?? "", latestDate: self!.allLatestResult[i].dateEvent ?? "", latestTime: self!.allLatestResult[i].strTime ?? "", eventScore: self!.allLatestResult[i].intScore ?? "")
                self!.latestResult.append(latestEvent)
            }
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
}
