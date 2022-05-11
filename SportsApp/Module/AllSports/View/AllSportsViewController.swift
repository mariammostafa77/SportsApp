//
//  AllSportsViewController.swift
//  SportsApp
//
//  Created by user189298 on 5/11/22.
//  Copyright © 2022 mariam mostafa. All rights reserved.
//

import UIKit

class AllSportsViewController: UIViewController {

    struct ResultView {
        var sportName: String = ""
        var sportImage: String = ""
    }
    
    @IBOutlet weak var allSportsCollectionView: UICollectionView!
    
    let indicator = UIActivityIndicatorView(style: .large)
    var presenter : AllSportsPresenter!
    var sportArray:[ResultView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        allSportsCollectionView.dataSource = self
        allSportsCollectionView.delegate = self
        
        indicator.center = self.view.center
        self.view.addSubview(indicator)
        indicator.startAnimating()
               
        presenter = AllSportsPresenter(networkService: SportsNetworkService())
        presenter.attachView(view: self)
        presenter.getSports()
    }
}


/////////////// For Collection view method
extension AllSportsViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sportArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = allSportsCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! AllSportsCollectionViewCell
       // cell.sportNameLabel.text = presenter.result[indexPath.row].strSport
        if(sportArray.count != 0){
            cell.sportNameLabel.text = sportArray[indexPath.row].sportName
        }
        return cell
    }
}

/////// For Presenter
extension AllSportsViewController : AllSportsProtocol {
    func stopAnimating() {
        indicator.stopAnimating()
    }
    func renderCollectionView(result: [SportItem]) {
        
        for i in 0...result.count-1{
            let resultView: ResultView = ResultView(sportName: result[i].strSport ?? "", sportImage: result[i].strSportThumb ?? "")
            sportArray.append(resultView)
        }
        self.allSportsCollectionView.reloadData()
        print(sportArray[3] )
    }
}



