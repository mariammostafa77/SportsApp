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
        //////For CoreData
      /*  presenter = FavoritePresenter()
        appDelegate  = (UIApplication.shared.delegate as! AppDelegate)
        favLeagues = presenter.fetchFavoriteLeagues(appDelegate: appDelegate)
        ///// For No Data
        let img = UIImageView(frame: CGRect(x:100,y:250,width:200,height:200))
        img.image=UIImage(named: "noData.png")
        img.tintColor = .gray
        img.tag = 100
        let labelNoData=UILabel(frame: CGRect(x: img.frame.minX, y: img.frame.maxY+30, width: img.frame.width, height: 16))
        labelNoData.text="No Data Found!!"
        labelNoData.textAlignment = .center
        labelNoData.tag = 200
        
        if favLeagues.count==0{
            favoriteTableView.isHidden = true
            self.view.addSubview(img)
            self.view.addSubview(labelNoData)
            }
        else{
            favoriteTableView.isHidden = false
            if let viewWithTag = self.view.viewWithTag(100) {
                    viewWithTag.removeFromSuperview()
                }else{
                    print("No!")
                }
            if let viewWithTag = self.view.viewWithTag(200) {
                    viewWithTag.removeFromSuperview()
                }else{
                    print("No!")
                }
        }
        favoriteTableView.reloadData()
 */
    }
    override func viewDidAppear(_ animated: Bool) {
        presenter = FavoritePresenter()
        appDelegate  = (UIApplication.shared.delegate as! AppDelegate)
        favLeagues = presenter.fetchFavoriteLeagues(appDelegate: appDelegate)
        
        let img = UIImageView(frame: CGRect(x:100,y:250,width:200,height:200))
        img.image=UIImage(named: "noData.png")
        img.tintColor = .gray
        img.viewWithTag(100)
        let labelNoData=UILabel(frame: CGRect(x: img.frame.minX, y: img.frame.maxY+30, width: img.frame.width, height: 16))
        labelNoData.text="No Data Found!!"
        labelNoData.textAlignment = .center
        labelNoData.tag = 200
        
        if favLeagues.count==0{
            favoriteTableView.isHidden = true
            img.removeFromSuperview()
            labelNoData.removeFromSuperview()
            }
        else{
            favoriteTableView.isHidden = false
            if let viewWithTag = self.view.viewWithTag(100) {
                    viewWithTag.removeFromSuperview()
                }else{
                    print("No!")
                }
            if let viewWithTag = self.view.viewWithTag(200) {
                    viewWithTag.removeFromSuperview()
                }else{
                    print("No!")
                }
           
        }
        favoriteTableView.reloadData()
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
        cell.favoriteView.layer.cornerRadius = cell.favoriteView.frame.height / 1.5
        cell.favLegueImageView.layer.cornerRadius = cell.favLegueImageView.frame.height / 2
        cell.favLegueImageView.layer.masksToBounds = true
        
        return cell
    }
    
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == UITableViewCell.EditingStyle.delete {
                presenter.deleteOneLeagueFromFav(appDelegate: appDelegate, leage: favLeagues[indexPath.row])
                favLeagues.remove(at: indexPath.row)
                favoriteTableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            }
        }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = favoriteTableView.indexPathForSelectedRow
        if NetworkMonitor.shared.isConnected{
            print("You are Connected....")
            let vc : LeagueDetailsViewController = segue.destination as! LeagueDetailsViewController
            vc.leagueItem = ResultView(name: favLeagues[indexPath!.row].value(forKey: "leagueName") as? String ?? "Name",
                                       image: (favLeagues[indexPath!.row].value(forKey: "leagueImg") as? String?)! ?? "",
                                       youtubeLink:  favLeagues[indexPath!.row].value(forKey: "youtubeLink") as? String ?? "",
                                       id: favLeagues[indexPath!.row].value(forKey: "leagueId") as? String ?? "1234",countryName: favLeagues[indexPath!.row].value(forKey: "countryName") as? String ?? "Spain")
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


