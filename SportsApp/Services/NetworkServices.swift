//
//  NetworkServices.swift
//  SportsApp
//
//  Created by user189298 on 5/14/22.
//  Copyright © 2022 mariam mostafa. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkServices: SportsService, LeaguesServiceProtocol,LeaguesDetailServiceProtocol{
    
    fileprivate var baseUrl = "https://www.thesportsdb.com/api/v1/json/2/"
    ////Sports
    let sportsEndPoint = "all_sports.php"
    var myData:[SportResultNeeded] = []
    //////////////////// Teams
    let teamEndPoint = "search_all_teams.php"
    var teamData: [TeamData] = []
       /////////// Leaugue
    let leagueUrl="https://www.thesportsdb.com/api/v1/json/2/search_all_leagues.php?s="
    var myLeaguesData:[ResultView] = []
    let LeaguesDetailsLatestUrl = "https://www.thesportsdb.com/api/v1/json/2/eventsseason.php?id="
    var leaguesDetailsResult:[AllEventResult]=[]

    ///// Sports
    func getAllSportsFromNetwork(complitionHandler: @escaping ([SportResultNeeded]?) -> Void ) {
        
        Alamofire.request(self.baseUrl + sportsEndPoint, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (responseData) in
            switch responseData.result{
            case .success:
                let myResult = try? JSON(data: responseData.data!)
                let resultArray = myResult!["sports"]
                for i in resultArray.arrayValue {
                    let sportResultNeeded: SportResultNeeded = SportResultNeeded(sportName: i["strSport"].stringValue, sportImage: i["strSportThumb"].stringValue)
                    self.myData.append(sportResultNeeded)
                }
                complitionHandler(self.myData)
 
            case .failure:
                print("Can not access data!!!!!")
                complitionHandler(nil)
                break
            }
        }
       
    }
    ///////////// Legues
    func fetchSLeagesResultWithAF(endPoint: String, complitionHandler: @escaping ([ResultView]?) -> Void) ->Array<ResultView>{
        Alamofire.request(leagueUrl+endPoint, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (responseData) in
             switch responseData.result{
             case .success:
                //print("url \(self.leagueUrl)\(endPoint)")
                 let myResult = try? JSON(data: responseData.data!)
                 let resultArray = myResult!["countries"]
                 for i in resultArray.arrayValue {
                  
                    let leaguesValue:ResultView=ResultView(name:i["strLeague"].stringValue, image:i["strBadge"].stringValue , youtubeLink: i["strYoutube"].stringValue,id: i["idLeague"].stringValue,countryName: i["strCountry"].stringValue)
                     self.myLeaguesData.append(leaguesValue)
                     
                 }
                 complitionHandler(self.myLeaguesData)
             case .failure:
                print("Can not access data!!!!!")
                complitionHandler(nil)
                 break
             }
         }
        return myLeaguesData
         
    }
    /// League Details
    func fetchSLeagesDetails(endPoint: String, complitionHandler: @escaping ([AllEventResult]?) -> Void) -> Array<AllEventResult> {
        Alamofire.request(LeaguesDetailsLatestUrl + endPoint, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (responseData) in
             switch responseData.result{
             case .success:
                 let myResult = try? JSON(data: responseData.data!)
                 let resultArray = myResult!["events"]
                 for i in resultArray.arrayValue {
                    let allEventsResult=AllEventResult(EventImg: i[""].stringValue, eventName: i["strEvent"].stringValue, eventDate: i["dateEvent"].stringValue, eventTime: i["strTime"].stringValue, firstTeamName: i["strHomeTeam"].stringValue, secondTeamName: i["strAwayTeam"].stringValue, firstTeamScore: i["intHomeScore"].stringValue, secondTeamScore: i["intAwayScore"].stringValue)
                        self.leaguesDetailsResult.append(allEventsResult)

                 }
                 complitionHandler(self.leaguesDetailsResult)
                case .failure:
                    print("Can not access data!!!!!")
                         complitionHandler(nil)
                         break
                     }
        }
        //print("From network \(leaguesDetailsResult.count)")

        return leaguesDetailsResult
    }
    
    //////////// Teams
    func fetchTeamData(parametrs : [String:String],complitionHandler: @escaping ([TeamData]?) -> Void) {
            Alamofire.request(self.baseUrl+teamEndPoint, method: .get, parameters: parametrs, encoding: URLEncoding.default, headers: nil).responseJSON { (responseData) in
                switch responseData.result{
                case .success:
                    let myResult = try? JSON(data: responseData.data!)
                    let resultArray = myResult!["teams"]
                    for i in resultArray.arrayValue {
                        let teamResult: TeamData = TeamData(teamName: i["strTeam"].stringValue, leagueName: i["strLeague"].stringValue, countryName: i["strCountry"].stringValue, stadiumName: i["strStadium"].stringValue, facebookLink: i["strFacebook"].stringValue, instagramLink: i["strInstagram"].stringValue, twitterLink: i["strTwitter"].stringValue, youtubeLink: i["strYoutube"].stringValue, websiteLink: i["strWebsite"].stringValue, stadiumImage: i["strStadiumThumb"].stringValue, logoImage: i["strTeamBadge"].stringValue)
                        self.teamData.append(teamResult)
                    }
                    complitionHandler(self.teamData)
                case .failure:
                    print("Can not access data!!!!!")
                    complitionHandler(nil)
                    break
                }
            }
        }
    
    
    
}




