//
//  AllSportsPresenter.swift
//  SportsApp
//
//  Created by user189298 on 5/11/22.
//  Copyright © 2022 mariam mostafa. All rights reserved.
//

import Foundation

class AllSportsPresenter{
    
    var result : [SportItem]!
    weak var view : AllSportsProtocol!
    weak var sportsView : AllSportsProtocol!
    
    init(networkService : SportsService){}
    
    func attachView(view: AllSportsProtocol){
        self.view = view
    }
    
    func getSports()  {
        SportsNetworkService.fetchSportResult {[weak self] (result1) in
            print(result1?.sports[2].strSport ?? "")
            self?.result = result1?.sports
            
            DispatchQueue.main.async {
                self?.view.stopAnimating()
                self?.view.renderCollectionView(result: self!.result)
        
            }
        }
    }
    
}
