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
    var memeData: [Meme] = []
    
    
    
    //calling memes from array in Delegate
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var memes: [Meme] {
        return appDelegate.memes
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.isScrollEnabled = true

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "MemeDetailViewController" ,
        let nextScene = segue.destination as? MemeDetailViewController,
            let indexPath = tableView.indexPathForSelectedRow {
            let selectedMeme = memeData[indexPath.row]
            let sentMemeImage = SentMemeImage(memedImage: selectedMeme.memedImage)
            nextScene.meme = sentMemeImage
        } else {
            if segue.identifier == "MemeEditorViewController" {
                _ = segue.destination as? MemeEditorViewController
            }
        }
    }
    
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
            //navigationController!.pushViewController(MemeDetailViewController, animated: true)
        
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
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            tableView.beginUpdates()
            deleteMemesInTableViewCell(indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.left)
            tableView.endUpdates()
        }
        
    }
}

