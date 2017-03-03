//
//  MemeDetailViewController.swift
//  MemeMe_V1
//
//  Created by Cameron Laury on 2/8/17.
//  Copyright © 2017 Beauty Bag Co. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    
    var meme: Meme!
    
    @IBOutlet weak var sentMemesBtn: UIBarButtonItem!
    @IBOutlet weak var editBtn: UIBarButtonItem!
    @IBOutlet weak var sentMemeView: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sentMemeView.image = meme.memedImage
    }
    
    
    @IBAction func launchMemeEditorViewController(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    
    }
    
    //unwinding to the view before (the collectionView, or the tableView)
    
    @IBAction func unwindVC(for unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
        self.dismiss(animated: true, completion: nil)
    }
}
