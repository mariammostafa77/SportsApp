//
//  FavoriteViewController.swift
//  SportsApp
//
//  Created by user189298 on 5/13/22.
//  Copyright © 2022 mariam mostafa. All rights reserved.
//

import UIKit
import Kingfisher
import CoreData

class FavoriteViewController: UIViewController {
    
    @IBOutlet weak var favoriteTableView: UITableView!
    
    var appDelegate: AppDelegate!
    var favLeagues: [NSManagedObject] = []
    var favLeagueSelected: ResultView!
    var presenter : FavoritePresenter!
    var viewContext: NSManagedObjectContext!
    
    ///// For No Data
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /////// For table View
        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self
        
        //////
        favoriteTableView.separatorStyle = .none
        favoriteTableView.showsVerticalScrollIndicator = false
       
    }
    override func viewDidAppear(_ animated: Bool) {
        presenter = FavoritePresenter()
        appDelegate  = (UIApplication.shared.delegate as! AppDelegate)
        favLeagues = presenter.fetchFavoriteLeagues(appDelegate: appDelegate)
        
        checkTableViewIsEmptyOrNot()
    }
    

}

/////////////// For Table view methods

extension FavoriteViewController : UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favLeagues.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FavoriteTableViewCell
      
        let url = URL(string: (favLeagues[indexPath.row].value(forKey: "leagueImg") as? String)!)
        cell.legueNameLabel.text = favLeagues[indexPath.row].value(forKey: "leagueName") as? String
        cell.favLegueImageView.kf.setImage(with: url,placeholder: UIImage(named: "sport.jpeg"))
        cell.favYoutubeLink = favLeagues[indexPath.row].value(forKey: "youtubeLink") as? String ?? ""
        /// https://www.youtube.com/watch?v=eRrMaxAE-SY
        ///////////////
        cell.favoriteView.layer.cornerRadius = cell.favoriteView.frame.height / 2
        cell.favLegueImageView.layer.cornerRadius = cell.favLegueImageView.frame.height / 2
        cell.favLegueImageView.layer.masksToBounds = true
        
        return cell
    }
    
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == UITableViewCell.EditingStyle.delete {
                presenter.deleteOneLeagueFromFav(appDelegate: appDelegate, leage: favLeagues[indexPath.row])
                favLeagues.remove(at: indexPath.row)
                favoriteTableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
                checkTableViewIsEmptyOrNot()
            }
        }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if NetworkMonitor.shared.isConnected{
            print("You are Connected....")
            let vc = storyboard?.instantiateViewController(withIdentifier: "leaguesDetail") as? NewLeagueDetailsViewController
            vc!.leagueItem = ResultView(name: favLeagues[indexPath.row].value(forKey: "leagueName") as? String ?? "Name",
                image: (favLeagues[indexPath.row].value(forKey: "leagueImg") as? String?)! ?? "",
                youtubeLink: favLeagues[indexPath.row].value(forKey: "youtubeLink") as? String ?? "",
                id: favLeagues[indexPath.row].value(forKey: "leagueId") as? String ?? "1234",countryName: favLeagues[indexPath.row].value(forKey: "countryName") as? String ?? "Spain")
            navigationController?.pushViewController(vc!, animated: true)
        }
        else{
            print("No Internet........")
            let alert = UIAlertController(title: "No Internet!", message: "Please Check Internet Connection!!!!", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }

    }


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    }


///////For check no data in fav
extension FavoriteViewController{
    func checkTableViewIsEmptyOrNot() {
        let noDataImage = UIImageView(frame: CGRect(x:100,y:250,width:200,height:200))
        noDataImage.image=UIImage(named: "noData.png")
        noDataImage.tintColor = .gray
        noDataImage.tag = 100
        let labelNoData=UILabel(frame: CGRect(x: noDataImage.frame.minX, y: noDataImage.frame.maxY+30, width: noDataImage.frame.width, height: 16))
        labelNoData.text="No Data Found!!"
        labelNoData.textAlignment = .center
        labelNoData.tag = 200
        
        if favLeagues.count==0{
            favoriteTableView.isHidden = true
            self.view.addSubview(noDataImage)
            self.view.addSubview(labelNoData)
            }
        else{
            favoriteTableView.isHidden = false
            if let viewWithTag = self.view.viewWithTag(100) {
                    viewWithTag.removeFromSuperview()
                }
            if let viewWithTag = self.view.viewWithTag(200) {
                    viewWithTag.removeFromSuperview()
                }
           
        }
        favoriteTableView.reloadData()
    }
    
    
}

