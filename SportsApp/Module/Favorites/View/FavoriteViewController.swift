//
//  FavoriteViewController.swift
//  SportsApp
//
//  Created by user189298 on 5/13/22.
//  Copyright © 2022 mariam mostafa. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {

    @IBOutlet weak var favoriteTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        /////// For table View
        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self
        
        favoriteTableView.separatorStyle = .none
        favoriteTableView.showsVerticalScrollIndicator = false
       
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
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FavoriteTableViewCell
        cell.legueNameLabel.text = "Asmaa"
        
        cell.favoriteView.layer.cornerRadius = cell.favoriteView.frame.height / 1.5
        cell.favLegueImageView.layer.cornerRadius = cell.favLegueImageView.frame.height / 2
        cell.favYoutubeImageView.layer.cornerRadius = cell.favYoutubeImageView.frame.height / 2
        cell.favYoutubeImageView.layer.masksToBounds = true
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    }




