//
//  AllSportsProtocol.swift
//  SportsApp
//
//  Created by user189298 on 5/11/22.
//  Copyright © 2022 mariam mostafa. All rights reserved.
//

import Foundation

protocol AllSportsProtocol : AnyObject{
    func stopAnimating()
    func renderCollectionView(result: [SportItem])
}
