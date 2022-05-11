//
//  AllSportsViewController.swift
//  SportsApp
//
//  Created by user189298 on 5/11/22.
//  Copyright © 2022 mariam mostafa. All rights reserved.
//

import UIKit

class AllSportsViewController: UIViewController {

    @IBOutlet weak var allSportsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}

extension AllSportsViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = allSportsCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! AllSportsCollectionViewCell
        return cell
    }

}
