//
//  LeagueDetailsViewController.swift
//  SportsApp
//
//  Created by mariam mostafa on 5/13/22.
//  Copyright © 2022 mariam mostafa. All rights reserved.
//

import UIKit

class LeagueDetailsViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    let upcomingIdentifier="upcomingCell"
    let lateastIdintifier="lateastCell"
    let teamsIdentifier="teamsCell"
    
    @IBOutlet weak var teamsCollectionView: UICollectionView!
    @IBOutlet weak var latestResultCollectionView: UICollectionView!
    @IBOutlet weak var upcommingCollectionView: UICollectionView!
    @IBAction func addFavBtn(_ sender: UIButton) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
          upcommingCollectionView.delegate = self
          latestResultCollectionView.delegate = self
        teamsCollectionView.delegate = self

          upcommingCollectionView.dataSource = self
          latestResultCollectionView.dataSource = self
          teamsCollectionView.dataSource = self
          self.view.addSubview(upcommingCollectionView)
          self.view.addSubview(latestResultCollectionView)
        self.view.addSubview(teamsCollectionView)
        
        let layout=UICollectionViewFlowLayout()
        layout.itemSize=CGSize(width:UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/3)
        upcommingCollectionView.collectionViewLayout=layout
        latestResultCollectionView.collectionViewLayout=layout
        teamsCollectionView.collectionViewLayout=layout
        
        
    }
    
    
       func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
               return 0
       }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        
        let teamsCell = collectionView.dequeueReusableCell(withReuseIdentifier: teamsIdentifier, for: indexPath) as! TeamsCollectionViewCell

        
           if collectionView == upcommingCollectionView {
                let upcomingCell = upcommingCollectionView.dequeueReusableCell(withReuseIdentifier: upcomingIdentifier, for: indexPath) as! UpcomingCollectionViewCell
            
               return upcomingCell
           }

           else if collectionView == latestResultCollectionView {
            let latestCell = collectionView.dequeueReusableCell(withReuseIdentifier: lateastIdintifier, for: indexPath) as! LatestCollectionViewCell


               return latestCell
           
       }
       
        return teamsCell
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
