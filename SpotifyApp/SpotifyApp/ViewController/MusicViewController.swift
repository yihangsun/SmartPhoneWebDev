//
//  MusicViewController.swift
//  SpotifyApp
//
//  Created by Yihang Sun on 4/20/21.
//

import UIKit

class MusicViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        getNewReleases()
    }
    
    
    public func getNewReleases() {
        print(baseAPIURL + "/browse/new-releases?limit=50")
    }

}
