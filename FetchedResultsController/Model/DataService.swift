//
//  DataService.swift
//  FetchedResultsController
//
//  Created by dohien on 7/18/18.
//  Copyright © 2018 hiền hihi. All rights reserved.
//

import Foundation
import CoreData

class DataService {
    static let shared: DataService = DataService()
    
    private var _fetchedResultsController: NSFetchedResultsController<Student>?
    var fetchedResultsController: NSFetchedResultsController<Student> {
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        let fetchRequest: NSFetchRequest<Student> = Student.fetchRequest()
        fetchRequest.fetchBatchSize = 20
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        _fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: AppDelegate.context, sectionNameKeyPath: nil, cacheName: "Master")
        do {
            try _fetchedResultsController?.performFetch()
        } catch  {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        return _fetchedResultsController!
    }
    func saveData() {
        let context = _fetchedResultsController?.managedObjectContext
        do {
            try context?.save()
            print("Saved")
        } catch  {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    func removeData(at indexPath: IndexPath) {
        guard let fetResults = _fetchedResultsController else { return }
        let context = fetResults.managedObjectContext
        context.delete(fetResults.object(at: indexPath))
        do {
            try context.save()
            print("Saved")
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
}
