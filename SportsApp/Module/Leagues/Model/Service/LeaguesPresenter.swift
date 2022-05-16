//
//  LeaguesPresenter.swift
//  SportsApp
//
//  Created by mariam mostafa on 5/13/22.
//  Copyright © 2022 mariam mostafa. All rights reserved.
//

import Foundation
class LeaguesPresenter {
    
    //var NWService : MovieService! // service
    var result : [ResultView]! // model
    weak var view : LeaguesTableViewProtocol!  // DI
    
    init(NWService : LeaguesNetworkManagerProtocol){
        //self.NWService = NWService
        //NWService = NetworkService() // no Dependency Injection
    }
    func attachView(view: LeaguesTableViewProtocol){
        self.view = view
    }
   func getItems(endPoint:String){
         let service=LeaguesNetworkManager()
    service.fetchSLeagesResultWithAF(endPoint: endPoint){[weak self] (result1) in
             self?.result = result1 ?? []
        print("from Presenter.....\(self?.result[0].countryName)")
             DispatchQueue.main.async {
                 self?.view.stopAnimating()
                 self?.view.renderTableView()
             }
         }
     }
}


