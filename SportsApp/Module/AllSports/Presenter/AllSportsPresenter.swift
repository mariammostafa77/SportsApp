//
//  AllSportsPresenter.swift
//  SportsApp
//
//  Created by user189298 on 5/11/22.
//  Copyright © 2022 mariam mostafa. All rights reserved.
//

import Foundation

class AllSportsPresenter{
    
   // var result : [SportItem]!
    weak var view : AllSportsProtocol!
    weak var sportsView : AllSportsProtocol!
    var myFetchedData:[SportResultNeeded] = []
    let service = SportsNetworkService()
    
    init(networkService : SportsService){}
    
    func attachView(view: AllSportsProtocol){
        self.view = view
    }
    
    func getSports1(){
        service.getAllSportsFromNetwork(endPoint: "all_sports.php") {[weak self] (myResult) in
            self?.myFetchedData = myResult!
            DispatchQueue.main.async {
                self?.view.stopAnimating()
                self?.view.renderCollectionView()
            }
        }
    }
    /*
    func getSports()  {
        SportsNetworkService.fetchSportResult {[weak self] (result1) in
            print(result1?.sports[2].strSport ?? "")
            self?.result = result1?.sports
            DispatchQueue.main.async {
                self?.view.stopAnimating()
                self?.view.renderCollectionView()
        
            }
        }
    }
    */
}
