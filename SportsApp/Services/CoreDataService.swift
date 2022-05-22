//
//  CoreDataService.swift
//  SportsApp
//
//  Created by user189298 on 5/15/22.
//  Copyright © 2022 mariam mostafa. All rights reserved.
//

import Foundation
import CoreData

class CoreDataService {
    
    var viewContext: NSManagedObjectContext!
    
    init(appDelegate: AppDelegate){
        viewContext = appDelegate.persistentContainer.viewContext
    }
    
    ////// Save
    func insertLeague(leagueItem:ResultView){
        let leagueEntity = NSEntityDescription.entity(forEntityName: "FavouriteLeagues", in: viewContext)
        
        let favleague = NSManagedObject(entity: leagueEntity!, insertInto: viewContext)
        favleague.setValue(leagueItem.id, forKey: "leagueId")
        favleague.setValue(leagueItem.image, forKey: "leagueImg")
        favleague.setValue(leagueItem.name, forKey: "leagueName")
        favleague.setValue(leagueItem.youtubeLink, forKey: "youtubeLink")
        favleague.setValue(leagueItem.countryName, forKey: "countryName")
        do{
            try viewContext.save()
            print("\nsave successfully")
        }catch let error{
            print(error.localizedDescription)
        }
    }
    /////// Fetch
     func fetchLegueData() -> Array<NSManagedObject> {
        let fetch = NSFetchRequest<NSManagedObject>(entityName: "FavouriteLeagues")
        var favLeagues: [NSManagedObject] = []
        do{
            favLeagues  = try viewContext.fetch(fetch)
        }catch{
            print("Couldn't fetch!")
        }
        return favLeagues
    }
    //////Delete
    func deleteLeagueFromFav(leage: NSManagedObject){
        viewContext.delete(leage)
        do {
            try viewContext.save()
            print("Deleted.....")
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    //Search
    func searchIfExist(leagueItemId:String)->Int{
        let favLeagues=fetchLegueData()
        var isFound = -1
        if favLeagues.count != 0{
            for i in 0...favLeagues.count-1 {
                let id : String = (favLeagues[i].value(forKey: "leagueId")) as! String
                if id == leagueItemId{
                    isFound = i
                    break
                }else{
                    isFound = -1
                }
            }
        }
        return isFound
    }

}

