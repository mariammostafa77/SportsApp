//
//  TestViewController.swift
//  SportsApp
//
//  Created by mariam mostafa on 5/16/22.
//  Copyright © 2022 mariam mostafa. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var MyScroll: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()

        MyScroll.contentSize=CGSize(width: UIScreen.main.bounds.width, height: 1000)
        myView.sizeThatFits(CGSize(width: MyScroll.contentSize.width, height: MyScroll.contentSize.height))
    }
    

    

}
