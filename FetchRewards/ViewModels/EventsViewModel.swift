//
//  EventsViewModel.swift
//  FetchRewards
//
//  Created by Prithiv Dev on 20/06/21.
//

import Foundation
import UIKit
import CoreData

class EventsViewModel: NSObject {
    private var backend = Backend()
    var allEvents = [Event]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    
    ///get all the events, no query here
    func getEvents(completionHandler: @escaping ([Event]) -> Void) {
        DispatchQueue.global(qos: .background).async {
            self.backend.fetchAllMainEvents(completionHandler: { event in
            completionHandler(event)
        })
        }
    }
    
    
    
    ///get the events for this query
    func getEventsForQuery(query:String,completionHandler: @escaping ([Event]) -> Void)  {
        DispatchQueue.global(qos: .background).async {
        self.backend.fetchEventWithQuery(query: query, completionHandler: { event in
            completionHandler(event)
        })}
    }
    

    
    ///get all the faves from coredata
    func getAllFaves() -> [Double] {
        var returnFaves = [Double]()
        do {
            let favs = try context.fetch(Favorites.fetchRequest()).map({Double($0.id)})
            returnFaves = favs
        }
        catch {
        }
        
        return returnFaves
    }
    
}
