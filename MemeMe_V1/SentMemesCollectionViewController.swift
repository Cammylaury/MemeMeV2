//
//  SentMemesCollectionViewController.swift
//  MemeMe_V1
//
//  Created by Cameron Laury on 2/8/17.
//  Copyright © 2017 Beauty Bag Co. All rights reserved.
//

import UIKit
import Foundation


class SentMemesCollectionViewController: UICollectionViewController {
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var _collectionView = SentMemesCollectionViewController!.self
    
    
    //calling memes from array in Delegate
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var memes: [Meme] {
        return appDelegate.memes
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView?.reloadData()
        
        flowLayoutSettings()

    }
    // Here is where I can't figure out how to fix it!
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MemeDetailViewController" {
                let nextScene: MemeDetailViewController = segue.destination as! MemeDetailViewController
                let cell = sender as! MemeCollectionViewCell
                let indexPath = self.collectionView!.indexPath(for: cell)
                let memeDetail = self.memes[(indexPath?.row)!]
                nextScene.sentMemeView = memeDetail as? UIImageView
                performSegue(withIdentifier: "MemeDetailViewController", sender: Any?.self)
        } else {
            if segue.identifier == "MemeEditorViewController" {
                _ = segue.destination as? MemeEditorViewController
                performSegue(withIdentifier: "MemeEditorViewController", sender: Any?.self)
        }
        }
        
    }
    func flowLayoutSettings() {
        
        let space: CGFloat = 3.0
        let dimension = (self.view.frame.size.width - (2 * space)) / 3
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
                return memes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionViewCell", for: indexPath) as! MemeCollectionViewCell
        
        let meme = self.memes[indexPath.item]
        cell.getCellMeme(meme.memedImage)
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        self.performSegue(withIdentifier: "MemeDetailViewController", sender: self.self)
    }
}
