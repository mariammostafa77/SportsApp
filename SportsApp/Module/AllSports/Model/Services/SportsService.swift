//
//  SportsService.swift
//  SportsApp
//
//  Created by user189298 on 5/11/22.
//  Copyright © 2022 mariam mostafa. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol SportsService{
  static func fetchSportResult(complitionHandler : @escaping (SportResult?) -> Void)
    func getAllSportsFromNetwork(endPoint: String, complitionHandler: @escaping ([SportResultNeeded]?) -> Void)
}

class SportsNetworkService : SportsService{

    fileprivate var baseUrl = "https://www.thesportsdb.com/api/v1/json/2/"
    var myData:[SportResultNeeded] = []
    
    func getAllSportsFromNetwork(endPoint: String,complitionHandler: @escaping ([SportResultNeeded]?) -> Void ) {
        
        AF.request(self.baseUrl + endPoint, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).responseJSON { (responseData) in
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

