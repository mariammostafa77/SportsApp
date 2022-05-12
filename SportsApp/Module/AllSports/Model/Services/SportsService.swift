//
//  SportsService.swift
//  SportsApp
//
//  Created by user189298 on 5/11/22.
//  Copyright © 2022 mariam mostafa. All rights reserved.
//

import Foundation
import Alamofire

protocol SportsService{
  static func fetchSportResult(complitionHandler : @escaping (SportResult?) -> Void)
    func fetchSportResult1(endPoint: String)
}
class SportsNetworkService : SportsService{
    
    
    fileprivate var baseUrl = ""
   // typealias sportsCallBack = ( test: [SportItem]?, staus: Bool, message: String)
   // typealias sportsCallBack = (_ sportsData: [SportItem]? )
    init(baseUrl: String){
        self.baseUrl = baseUrl
    }
    func fetchSportResult1(endPoint: String){
      //  AF.reqest(self.baseUrl + endPoint, method: .get, Parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response(
        
        AF.request(self.baseUrl + endPoint, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).responseJSON { (responseData) in
            switch responseData.result{
            case .success:
                print(responseData.result)
            case .failure:
                break
            }
           // print("Got Response.... \(responseData)")
            /*
            guard let data = responseData.data else { return}
            do{
                let sportsData = try JSONDecoder().decode(SportResult.self, from: data)
                print("Sport Data \(sportsData)")
            } catch{
                print("Error Decoding.....\(error)")
            }
            */
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

