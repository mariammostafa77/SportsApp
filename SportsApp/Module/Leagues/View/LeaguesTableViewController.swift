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
        cell.viewController = self
        
        let url = URL(string: leaguesArr[indexPath.row].image)
        cell.leagueImg.kf.setImage(with: url,placeholder: UIImage(named: "noData.png"))
       
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
    
    func handleEmptyTable(){
        let imgNoData = UIImageView(frame:CGRect(x:(UIScreen.main.bounds.width/2)-40,y:100,width:80,height:80))
        let labelNoData=UILabel(frame: CGRect(x: imgNoData.frame.origin.x-20, y: imgNoData.frame.maxY+10, width:130, height: 16))
        if(leaguesArr.count == 0){
            imgNoData.image=UIImage(named: "noData.png")
            imgNoData.tintColor = .lightGray
            labelNoData.text="No Data Found!!"
            labelNoData.textAlignment = .center
            self.view.addSubview(imgNoData)
            self.view.addSubview(labelNoData)
        }else{
            imgNoData.isHidden=true
            labelNoData.isHidden=true
        }
    }

}
extension LeaguesTableViewController : LeaguesTableViewProtocol {
    func stopAnimating() {
        indicator.stopAnimating()
    }
    func renderTableView(){
        leaguesArr = presenter.result.map({ (item) -> ResultView in
            let res:ResultView = ResultView(name: item.name, image: item.image, youtubeLink: item.youtubeLink,id: item.id,countryName: item.countryName)
                return res
            })
        
        self.handleEmptyTable()
           self.tableView.reloadData()
        }
    
}

