//
//  AllSportsViewController.swift
//  SportsApp
//
//  Created by user189298 on 5/11/22.
//  Copyright © 2022 mariam mostafa. All rights reserved.
//

import UIKit
import Kingfisher

class AllSportsViewController: UIViewController {
    
    @IBOutlet weak var allSportsCollectionView: UICollectionView!
    
    let indicator = UIActivityIndicatorView(style: .large)
    var presenter : AllSportsPresenter!
    var sportArray:[SportResultNeeded] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        allSportsCollectionView.dataSource = self
        allSportsCollectionView.delegate = self
        
        indicator.center = self.view.center
        self.view.addSubview(indicator)
        indicator.startAnimating()
               
        presenter = AllSportsPresenter(networkService: SportsNetworkService())
        presenter.attachView(view: self)
        presenter.getSports1()
    }
}

/////////////// For Collection view method
extension AllSportsViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sportArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = allSportsCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! AllSportsCollectionViewCell
        let url = URL(string: sportArray[indexPath.row].sportImage)
     
        if(sportArray.count != 0){
            cell.sportNameLabel.text = sportArray[indexPath.row].sportName
            cell.sportImage.kf.setImage(with: url,placeholder: UIImage(named: "sports.jpeg"))
        }
        cell.layer.borderWidth = 2
        cell.layer.borderColor = UIColor.gray.cgColor
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.size.width-10)/2
        return CGSize(width: size, height: 200)
    }
}

/////// For Presenter
extension AllSportsViewController : AllSportsProtocol {
    func stopAnimating() {
        indicator.stopAnimating()
    }
    
    func renderCollectionView() {
       sportArray = presenter.myFetchedData.map({ (item) -> SportResultNeeded in
        let res:SportResultNeeded = SportResultNeeded(sportName:item.sportName ,sportImage:item.sportImage )
            return res
        })
       self.allSportsCollectionView.reloadData()
        //print(sportArray[3] )
    }
}



