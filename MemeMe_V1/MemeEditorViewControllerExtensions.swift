//
//  MemeEditorViewControllerExtensions.swift
//  MemeMe_V1
//
//  Created by Cameron Laury on 2/12/17.
//  Copyright © 2017 Beauty Bag Co. All rights reserved.
//

import UIKit

extension UIViewController {

    func launchMemeViewer(_ meme: MemeImage) {
        // Grab MemeDetailVC from Storyboard.
        let memeDetailViewController = storyboard?.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        
        // Present the view controller using navigation.
        navigationController!.pushViewController(memeDetailViewController, animated: true)
    }
}
