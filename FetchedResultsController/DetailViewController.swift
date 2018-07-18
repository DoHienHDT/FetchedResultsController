//
//  ViewController.swift
//  FetchedResultsController
//
//  Created by dohien on 7/18/18.
//  Copyright © 2018 hiền hihi. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {
    @IBOutlet weak var inputTextField: UITextField!
    
    var object: Student?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let dataOjbect = object {
            inputTextField.text = dataOjbect.name
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func saveData(_ sender: UIBarButtonItem) {
        if object == nil {
            object = Student(context: DataService.shared.fetchedResultsController.managedObjectContext)
        }
        object?.name = inputTextField.text
        DataService.shared.saveData()
        navigationController?.popViewController(animated: true)
    }
}

