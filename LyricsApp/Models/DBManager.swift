//
//  DBManager.swift
//  LyricsApp
//
//  Created by Javier Sapia on 16/04/2021.
//  Copyright © 2021 Javier Sapia. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DBManager {
    
    internal let context: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    enum Constants: String {
        case ENTITY_NAME = "LyricsApp"
        case ENTITY_TITLE = "title"
        case ENTITY_LYRICS = "lyrics"
        case ENTITY_ARTIST = "artist"
    }
    
    /**
        Removes a lyric from the device
        - Parameters: lyric: The NSManagedObject instance to be deleted
     */
    internal func remove(lyric: NSManagedObject) {
        context.delete(lyric)
        save()
    }
    
    /**
        Saves the changes, if any, in the device memory
     */
    internal func save() {
        if context.hasChanges {
            do {
                try context.save()
            } catch let error {
                print(error.localizedDescription)
            }
        } else {
            print("No new data to save")
        }
    }
    
    internal func fetch(fetchRequest: NSFetchRequest<NSFetchRequestResult>) -> [Any] {
        do {
            return try context.fetch(fetchRequest)
        } catch let error {
            print(error.localizedDescription)
        }
        return []
    }
    
}
