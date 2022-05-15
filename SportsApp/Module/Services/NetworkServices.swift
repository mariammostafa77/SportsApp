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


protocol AllSportsService{
  static func fetchSportResult(complitionHandler : @escaping (SportResult?) -> Void)
    func getAllSportsFromNetwork(endPoint: String, complitionHandler: @escaping ([SportResultNeeded]?) -> Void)
}

protocol LeaguesNetworkServiceProtocol
{
   func fetchSLeagesResultWithAF(endPoint: String, complitionHandler: @escaping ([ResultView]?) -> Void) -> Array<ResultView>
}

protocol LeaguesDetailServiceProtocol{
    func fetchSLeagesDetailsUpcomingResultWithAF(endPoint: String, complitionHandler: @escaping ([LeaguesDetailsItem]?) -> Void)-> Array<LeaguesDetailsItem>
    func fetchSLeagesDetailsLatestResultWithAF(endPoint: String, complitionHandler: @escaping ([LeaguesDetailsItem]?) -> Void)-> Array<LeaguesDetailsItem>
}

class NetworkServices: AllSportsService, LeaguesNetworkServiceProtocol,LeaguesDetailServiceProtocol{
    
    
    
    ////Sports
       fileprivate var baseUrl = "https://www.thesportsdb.com/api/v1/json/2/"
       var myData:[SportResultNeeded] = []
       /////////// Leaugue
       
       let baseUrl1="https://www.thesportsdb.com/api/v1/json/2/search_all_leagues.php?s="

       var myLeaguesData:[ResultView] = []
    

    var leaguesUpcomingResultData:[LeaguesDetailsItem]=[]
    var leaguesLatestResultData:[LeaguesDetailsItem]=[]
    
    let LeaguesDetailsLatestUrl = "https://www.thesportsdb.com/api/v1/json/2/eventsseason.php?id="
    let LeaguesDetailsUpcomingUrl = "https://www.thesportsdb.com/api/v1/json/2/eventsround.php?id=4328&r=38&s=2021-2022"
    
    func fetchSLeagesDetailsLatestResultWithAF(endPoint: String, complitionHandler: @escaping ([LeaguesDetailsItem]?) -> Void) -> Array<LeaguesDetailsItem> {
        Alamofire.request(LeaguesDetailsLatestUrl + endPoint, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (responseData) in
             switch responseData.result{
             case .success:
                 let myResult = try? JSON(data: responseData.data!)
                 let resultArray = myResult!["events"]
                do {
                                       
                    let strjson = resultArray.arrayValue.description
                    let data=Data(strjson.utf8)
                    self.leaguesLatestResultData = try JSONDecoder().decode([LeaguesDetailsItem].self, from: data)
                    complitionHandler(self.leaguesLatestResultData)
                                       
                 } catch {
                     print(error)
                     }

            print(self.leaguesLatestResultData[0].dateEvent ?? "")
            print(self.leaguesLatestResultData[1].dateEvent ?? "")
             case .failure:
                 print("Can not access data")
                 complitionHandler(nil)
                 break
             }
         }
        return leaguesLatestResultData
    }
    
    func fetchSLeagesDetailsUpcomingResultWithAF(endPoint: String, complitionHandler: @escaping ([LeaguesDetailsItem]?) -> Void)-> Array<LeaguesDetailsItem> {
        
        Alamofire.request(LeaguesDetailsUpcomingUrl, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (responseData) in
             switch responseData.result{
             case .success:
                 let myResult = try? JSON(data: responseData.data!)
                 let resultArray = myResult!["events"]
                do {
                                       
                    let strjson = resultArray.arrayValue.description
                    let data=Data(strjson.utf8)
                    self.leaguesUpcomingResultData = try JSONDecoder().decode([LeaguesDetailsItem].self, from: data)
                    complitionHandler(self.leaguesUpcomingResultData)
                                       
                 } catch {
                     print(error)
                     }

            print(self.leaguesUpcomingResultData[0].dateEvent ?? "")
            print(self.leaguesUpcomingResultData[1].dateEvent ?? "")
             case .failure:
                 print("Can not access data")
                 complitionHandler(nil)
                 break
             }
         }
        return leaguesUpcomingResultData
    }
    
    
    
   
    
    func getAllSportsFromNetwork(endPoint: String,complitionHandler: @escaping ([SportResultNeeded]?) -> Void ) {
        
        Alamofire.request(self.baseUrl + endPoint, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (responseData) in
            switch responseData.result{
            case .success:
                let myResult = try? JSON(data: responseData.data!)
                let resultArray = myResult!["sports"]
                for i in resultArray.arrayValue {
                    let sportResultNeeded: SportResultNeeded = SportResultNeeded(sportName: i["strSport"].stringValue, sportImage: i["strSportThumb"].stringValue)
                    self.myData.append(sportResultNeeded)
                }
                complitionHandler(self.myData)
                print(" name:   \(self.myData[3].sportName)")
                print(" image: \(self.myData[3].sportImage)")
            case .failure:
                print("Can not get data")
                complitionHandler(nil)
                break
            }
        }
       
    }
    ///////////// Legues
    
    
    func fetchSLeagesResultWithAF(endPoint: String, complitionHandler: @escaping ([ResultView]?) -> Void) ->Array<ResultView>{
        Alamofire.request(baseUrl1+endPoint, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (responseData) in
             switch responseData.result{
             case .success:
         
                 let myResult = try? JSON(data: responseData.data!)
                 let resultArray = myResult!["countries"]
                 for i in resultArray.arrayValue {
                  
                    var leaguesValue:ResultView=ResultView(name:i["strLeague"].stringValue, image:i["strBadge"].stringValue , youtubeLink: i["strYoutube"].stringValue)
                     
                     print("testImg"+i["strBadge"].stringValue)
                     self.myLeaguesData.append(leaguesValue)
                     
                 }
                 complitionHandler(self.myLeaguesData)
               
            
             case .failure:
                 print("Can not access data")
                complitionHandler(nil)
                 break
             }
         }
        return myLeaguesData
         
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    ///////////
    
    static func fetchSportResult(complitionHandler: @escaping (SportResult?) -> Void) {
        let url = URL(string: "https://www.thesportsdb.com/api/v1/json/2/all_sports.php")
        guard let newUrl = url else{
            return
        }
        let request = URLRequest(url: newUrl)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let data = data else{return}
            do{
                let result = try JSONDecoder().decode(SportResult.self, from: data)
                complitionHandler(result)
            }
            catch let error{
                        print("Can not get data")
                        print(error.localizedDescription)
                        complitionHandler(nil)
            }
        }
        task.resume()
    }
    
    
    
}




