//
//  MainVC.swift
//  MemeMe_V1
//
//  Created by Cameron Laury on 1/19/17.
//  Copyright © 2017 Beauty Bag Co. All rights reserved.
//

import UIKit

class memeEditorViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate {
    
    // MainVC!

    // Top of the storyboard
    @IBOutlet weak var topBar: UIToolbar!
    @IBOutlet weak var shareBtn: UIBarButtonItem!
    @IBOutlet weak var cancelBtn: UIBarButtonItem!
    
    // Middle of the storyboard
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var bottomTextField: UITextField!
    
    // Bottom of the storyboard
    @IBOutlet weak var bottomBar: UIToolbar!
    @IBOutlet weak var cameraBtn: UIBarButtonItem!
    @IBOutlet weak var albumBtn: UIBarButtonItem!
    
    
    // text attributes
    let topTextDefault = "TOP TEXT"
    let bottomTextDefault = "BOTTOM TEXT"
    let noText = ""
    
    let topTextDelegate = textDelegate()
    let bottomTextDelegate = textDelegate()
    
    
    
    
    
    // meme attributes
    let memeTextAttributes:[String: Any] = [NSStrokeColorAttributeName: UIColor.black, NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!, NSStrokeWidthAttributeName: NSNumber( value: -4.0 )]

    
    var isKeyboardVisible = false

    
    
    // Use of undeclared type 'MemeImage'
    var meme: MemeImage!
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTextFields(textField: topTextField, initialText: "Top Text", delegate: topTextDelegate)
        initTextFields(textField: bottomTextField, initialText: "Bottom Text", delegate: bottomTextDelegate)
        
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.subscribeToKeyboardNotifications()
        cameraBtn.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    func initTextFields(textField: UITextField, initialText: String, delegate: UITextFieldDelegate) {
        
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = NSTextAlignment.center
        textField.text = initialText
        textField.delegate = delegate
        
    }
    
    func keyboardWillShow(_ notification:Notification) {
        
        
        if bottomTextField.isFirstResponder {
            view.frame.origin.y = getKeyboardHeight(notification) * (-1)
        }
    
    }
    
    func keyboardWillHide(_ notification:Notification) {
        if bottomTextField.isFirstResponder {
            view.frame.origin.y = 0.0
        }
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        
        // Unexpected non-void return value in void function---------
        return keyboardSize.cgRectValue.height

    }
    
    @IBAction func imagePickCancel(_ picker: UIImagePickerController) {
        
        topTextField.text = topTextDefault
        bottomTextField.text = bottomTextDefault
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
                imageView.contentMode = .scaleAspectFit
                imageView.image = image
                shareBtn.isEnabled = true
                cancelBtn.isEnabled = true
            
                dismiss(animated: true, completion: nil)
        }
    }
    
    func pickImageType(sourceType: UIImagePickerControllerSourceType) {
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = sourceType
        
        self.present(pickerController, animated: true, completion: nil)
        
    }
    
    @IBAction func getImageFromCamera(_ sender: Any) {
        
        pickImageType(sourceType: UIImagePickerControllerSourceType.camera)
        
    }
    
    @IBAction func getImageFromAlbum(_ sender: Any) {
        
        if albumBtn.isEnabled == true {
        
        }
        
        pickImageType(sourceType: UIImagePickerControllerSourceType.photoLibrary)
    }
    
    @IBAction func cancel(_ sender: Any) {
        
        shareBtn.isEnabled = false
        imageView.image = nil
        topTextField.text = topTextDefault
        bottomTextField.text = bottomTextDefault
        
    }
    
    @IBAction func share(_ sender: Any) {
        
        
        let memedImage = generateMemedImage()
        let socialController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        socialController.completionWithItemsHandler = {
            
            
            (UIActivityType, completed, returnedItems, activityError) in
            
            if completed {
            
            self.save(memedImage)
                self.dismiss(animated: true, completion: nil)
            }
        }
        present(socialController, animated: true, completion: nil)
    }
    
    func hideUnHideToolBars(hide: Bool) {
        
        topBar.isHidden = hide
        bottomBar.isHidden = hide
        
    }
    
    func generateMemedImage() -> UIImage {
        
        //Hide the toolbars
        hideUnHideToolBars(hide: true)
        
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        //unhide the toolbars
        hideUnHideToolBars(hide: false)
        
        return memedImage
        
    }
    func save(_ memedImage: UIImage) {
            let meme = MemeImage.init(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imageView.image!, memedImage: memedImage)
        
        // Adding to the array of memes!
        
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)

        }

    }

        
    
        


    











