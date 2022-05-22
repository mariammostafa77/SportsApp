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
        
        if NetworkMonitor.shared.isConnected {
            print("You are Connected....")
            indicator.center = self.view.center
            self.view.addSubview(indicator)
            indicator.startAnimating()

            presenter = AllSportsPresenter(networkService: NetworkServices())
            presenter.attachView(view: self)
            presenter.getAllSports()
        }
        else{
            print("You are not Connected....")
            let alert = UIAlertController(title: "No Internet!", message: "Please Check Internet Connection!!!!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
}
/////////////// For Collection view method
extension AllSportsViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sportArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = allSportsCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! AllSportsCollectionViewCell
        let url = URL(string: sportArray[indexPath.row].sportImage)
     
        if(sportArray.count != 0){
            cell.sportNameLabel.text = sportArray[indexPath.row].sportName
            cell.sportImage.kf.setImage(with: url,placeholder: UIImage(named: "sport.jpeg"))
        }
        cell.layer.borderWidth = 2
        cell.layer.borderColor = UIColor.gray.cgColor
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.size.width-10)/2
        return CGSize(width: size, height: 200)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "leagues") as? LeaguesTableViewController
        vc?.sportName =  sportArray[indexPath.row].sportName
        navigationController?.pushViewController(vc!, animated: true)
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
        
        let noDataImage = UIImageView(frame: CGRect(x:100,y:250,width:200,height:200))
        noDataImage.image=UIImage(named: "noData.png")
        noDataImage.tintColor = .gray
        noDataImage.tag = 100
        let labelNoData=UILabel(frame: CGRect(x: noDataImage.frame.minX, y: noDataImage.frame.maxY+30, width: noDataImage.frame.width, height: 16))
        labelNoData.text="No Data Found!!"
        labelNoData.textAlignment = .center
        labelNoData.tag = 200
        
        if sportArray.count == 0{
            allSportsCollectionView.isHidden = true
            self.view.addSubview(noDataImage)
            self.view.addSubview(labelNoData)
            }
        else{
            allSportsCollectionView.isHidden = false
            if let viewWithTag = self.view.viewWithTag(100) {
                    viewWithTag.removeFromSuperview()
                }
            if let viewWithTag = self.view.viewWithTag(200) {
                    viewWithTag.removeFromSuperview()
                }
           
        }
        allSportsCollectionView.reloadData()
       
    }
}



