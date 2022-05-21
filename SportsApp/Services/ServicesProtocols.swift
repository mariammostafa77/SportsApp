//
//  ServicesProtocols.swift
//  SportsApp
//
//  Created by user189298 on 5/20/22.
//  Copyright © 2022 mariam mostafa. All rights reserved.
//

import Foundation

protocol SportsService{
    func getAllSportsFromNetwork(complitionHandler: @escaping ([SportResultNeeded]?) -> Void)
}

protocol LeaguesServiceProtocol
{
   func fetchSLeagesResultWithAF(endPoint: String, complitionHandler: @escaping ([ResultView]?) -> Void) -> Array<ResultView>
}

protocol LeaguesDetailServiceProtocol{
    func fetchSLeagesDetails(endPoint: String, complitionHandler: @escaping ([AllEventResult]?) -> Void)-> Array<AllEventResult>
    func fetchTeamData(parametrs : [String:String],complitionHandler: @escaping ([TeamData]?) -> Void)
    
}
