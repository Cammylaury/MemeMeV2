//
//  TextDelegate.swift
//  MemeMe_V1
//
//  Created by Cameron Laury on 1/21/17.
//  Copyright © 2017 Beauty Bag Co. All rights reserved.
//

import UIKit

class textDelegate: NSObject, UITextFieldDelegate {
    

    func textFieldDidBeginEditing(_ textField: UITextField) {
        return
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
}
