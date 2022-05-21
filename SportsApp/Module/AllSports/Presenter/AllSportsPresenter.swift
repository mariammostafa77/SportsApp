//
//  AllSportsPresenter.swift
//  SportsApp
//
//  Created by user189298 on 5/11/22.
//  Copyright © 2022 mariam mostafa. All rights reserved.
//

import Foundation

class AllSportsPresenter{

    weak var view : AllSportsProtocol!
    var myFetchedData:[SportResultNeeded] = []
    let service = NetworkServices()
    
    init(networkService : SportsService){}
    
    func attachView(view: AllSportsProtocol){
        self.view = view
    }
    
    func getAllSports(){
        service.getAllSportsFromNetwork{[weak self] (myResult) in
            self?.myFetchedData = myResult!
            DispatchQueue.main.async {
                self?.view.stopAnimating()
                self?.view.renderCollectionView()
            }
        }
    }
}
