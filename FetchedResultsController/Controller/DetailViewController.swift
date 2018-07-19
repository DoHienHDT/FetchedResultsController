//
//  ViewController.swift
//  FetchedResultsController
//
//  Created by dohien on 7/18/18.
//  Copyright © 2018 hiền hihi. All rights reserved.
//

import UIKit
import CoreData
//import os.log
class DetailViewController: UIViewController , UITextFieldDelegate , UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    var object: Student?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let dataOjbect = object {
            inputTextField.text = dataOjbect.name
            ageTextField.text = String(dataOjbect.age)
            photoImage.image = dataOjbect.image as? UIImage
            
        }
        inputTextField.delegate = self
        updateSaveButtonSate()
        //        saveButton.isEnabled = false
        
    }
    //    override func viewWillAppear(_ animated: Bool) {
    //        super.viewWillAppear(true)
    //        saveButton.isEnabled = false
    //    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func saveData(_ sender: UIBarButtonItem) {
        if object == nil {
            object = Student(context: DataService.shared.fetchedResultsController.managedObjectContext)
        }
        object?.name = inputTextField.text
        object?.age = Int32(ageTextField.text ?? "") ?? 0
        object?.image = photoImage.image
        DataService.shared.saveData()
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        inputTextField.resignFirstResponder()
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion:  nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedImage  = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        photoImage.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonSate()
        // đặt tiêu đề
        navigationItem.title = textField.text
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        saveButton.isEnabled = false
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    
    
    // tắt nút lưu nè
    private func  updateSaveButtonSate() {
        let text = inputTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
}
