//
//  ViewControllerProfile.swift
//  MapTrip
//
//  Created by 김민경 on 2022/11/01.
//

import Foundation
import UIKit

class ViewControllerProfile: UIViewController {
    
    @IBOutlet var sampleImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        sampleImageView.layer.masksToBounds = false
        sampleImageView.layer.cornerRadius = sampleImageView.frame.height/2
        sampleImageView.clipsToBounds = true
        
        tapGasture()
    }
    
    //MARK: -Add TapGasture in ImageView
    func tapGasture(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        sampleImageView.isUserInteractionEnabled = true
        sampleImageView.addGestureRecognizer(tap)
    }
    @IBAction func imageTapped(){
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
    }
}
extension ViewControllerProfile: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        sampleImageView.image = info[.originalImage] as? UIImage
        dismiss(animated:true, completion: nil)
    }
}
