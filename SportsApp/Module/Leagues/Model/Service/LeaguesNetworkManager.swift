//
//  LeaguesNetworkManager.swift
//  SportsApp
//
//  Created by mariam mostafa on 5/13/22.
//  Copyright © 2022 mariam mostafa. All rights reserved.
//

import Foundation
import Foundation
import Alamofire
import SwiftyJSON
protocol LeaguesNetworkManagerProtocol
{
   func fetchSLeagesResultWithAF(endPoint: String, complitionHandler: @escaping ([ResultView]?) -> Void) -> Array<ResultView>
}
    class LeaguesNetworkManager : LeaguesNetworkManagerProtocol{
        
        let baseUrl="https://www.thesportsdb.com/api/v1/json/2/search_all_leagues.php?s="
        //Soccer
        
        var myLeaguesData:[ResultView] = []
        
        func fetchSLeagesResultWithAF(endPoint: String, complitionHandler: @escaping ([ResultView]?) -> Void) ->Array<ResultView>{
            Alamofire.request(baseUrl+endPoint, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (responseData) in
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
        
        
        
        
        
        
        
    static func fetchResult(complitionHandler : @escaping (LeaguesResult?) -> Void){
        let url = URL(string: "https://www.thesportsdb.com/api/v1/json/2/search_all_leagues.php?c=England&s=Soccer")
        guard let newUrl = url else{
            return
        }
        let request = URLRequest(url: newUrl)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let data = data else{
                return
            }
            do{
                let result = try JSONDecoder().decode(LeaguesResult.self, from: data)
                print(result.Leagues[0].strSport ?? "")
                complitionHandler(result)
            }catch let error{
                print("Here")
                print(error.localizedDescription)
                complitionHandler(nil)
            }
            
            
        }
        task.resume()
        
        }
    }


