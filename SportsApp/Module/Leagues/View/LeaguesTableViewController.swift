//
//  LeaguesTableViewController.swift
//  SportsApp
//
//  Created by mariam mostafa on 5/11/22.
//  Copyright © 2022 mariam mostafa. All rights reserved.
//

import UIKit

import Kingfisher

protocol LeaguesTableViewProtocol : AnyObject{
    func stopAnimating()
    func renderTableView()
}
struct ResultView{
    var name : String = ""
    var image : String = ""
    var youtubeLink : String = ""
    var id:String=""
    var countryName : String = ""
}

class LeaguesTableViewController: UITableViewController {

    var leaguesArr:Array<ResultView>=[]
    let indicator = UIActivityIndicatorView(style: .large)
    var presenter : LeaguesPresenter!
    var sportName:String=""
    
    override func viewDidLoad() {
        super.viewDidLoad()

             indicator.center = self.view.center
              self.view.addSubview(indicator)
              indicator.startAnimating()
              
              presenter = LeaguesPresenter(NWService: NetworkServices())
              presenter.attachView(view: self)
              
        presenter.getItems(endPoint: sportName)

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return leaguesArr.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LeaguesTableViewCell
       
        cell.leagueImg.layer.cornerRadius = cell.leagueImg.frame.height / 2
        cell.leagueImg.layer.masksToBounds = true
        cell.leagueImg.backgroundColor = .lightGray
        
        cell.leagueName.text=leaguesArr[indexPath.row].name

        cell.youtubeLink=leaguesArr[indexPath.row].youtubeLink
        
        if leaguesArr[indexPath.row].name == "No Data Found !!!" {
            cell.videoBtn.isHidden=true
        }
        let url = URL(string: leaguesArr[indexPath.row].image)
        cell.leagueImg.kf.setImage(with: url,placeholder: UIImage(named: "noData.png"))
        //print(leaguesArr[indexPath.row].name)
        //cell.leagueImg.image=UIImage(named: leaguesArr[indexPath.row].image)
       
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
       }
   
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let vc = storyboard?.instantiateViewController(withIdentifier: "leaguesDetail") as? NewLeagueDetailsViewController
        vc?.leagueItem = ResultView(name: leaguesArr[indexPath.row].name, image: leaguesArr[indexPath.row].image, youtubeLink: leaguesArr[indexPath.row].youtubeLink, id: leaguesArr[indexPath.row].id,countryName: leaguesArr[indexPath.row].countryName)
        print("In League Table View...\(leaguesArr[indexPath.row].countryName)")
        vc?.strSport = sportName
        navigationController?.pushViewController(vc!, animated: true)
        print("from raw id \(leaguesArr[indexPath.row].id)")
    
    }
    
   

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension LeaguesTableViewController : LeaguesTableViewProtocol {
    func stopAnimating() {
        indicator.stopAnimating()
    }
    func renderTableView(){
        leaguesArr = presenter.result.map({ (item) -> ResultView in
            let res:ResultView = ResultView(name: item.name, image: item.image, youtubeLink: item.youtubeLink,id: item.id,countryName: item.countryName)
            print(" In Leage.....\(item.name)")
                return res
            })
        
              if leaguesArr.count == 0 {
               let myRes:ResultView=ResultView(name: "No Data Found !!!", image: "youtube.png", youtubeLink: "",id: "", countryName: "")
               leaguesArr.append(myRes)
                
                       }
              
           self.tableView.reloadData()
        }
    
}

