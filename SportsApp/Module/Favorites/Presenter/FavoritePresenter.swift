//
//  FavoritePresenter.swift
//  SportsApp
//
//  Created by user189298 on 5/15/22.
//  Copyright © 2022 mariam mostafa. All rights reserved.
//

import Foundation
import CoreData

class FavoritePresenter{
    
    var favCoreData: CoreDataService!
    
    func fetchFavoriteLeagues(appDelegate : AppDelegate) -> Array<NSManagedObject> {
        favCoreData = CoreDataService(appDelegate : appDelegate)
        return favCoreData.fetchLegueData()
       }

    func deleteOneLeagueFromFav(appDelegate : AppDelegate,leage:NSManagedObject) {
        favCoreData = CoreDataService(appDelegate : appDelegate)
        favCoreData.deleteLeagueFromFav(leage: leage)
    }
    
}
