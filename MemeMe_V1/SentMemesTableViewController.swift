//
//  SentMemesTableViewController.swift
//  MemeMe_V1
//
//  Created by Cameron Laury on 2/8/17.
//  Copyright © 2017 Beauty Bag Co. All rights reserved.
//

import UIKit

class SentMemesTableViewController: UITableViewController {
    
    var _tableView: UITableView!
    
    
    
    //calling memes from array in Delegate
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var memes: [MemeImage] {
        return appDelegate.memes
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.isScrollEnabled = true
   
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.isBeingPresented {
            performSegue(withIdentifier: "MemeDetailViewController", sender: Any?.self)
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return memes.count
    }

    // Here it is! -----
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "sentMemesTableView") as! MemeTableViewCell
        let meme = memes[indexPath.row]
        
        tableViewCell.tableViewImage.image = meme.memedImage
        tableViewCell.tableViewLabel.text = "\(meme.topText)...\(meme.bottomText)"
        
        
        
        return tableViewCell
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return false
    }

    func deleteMemesInTableViewCell(_ index: Int) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memes.remove(at: index)
    }
}

