//
//  DetailedEventViewModel.swift
//  FetchRewards
//
//  Created by Prithiv Dev on 23/06/21.
//

import Foundation
import UIKit
import CoreData


class DetailedEventViewModel : NSObject {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
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
    
    
    
    ///set a fave
    func setFave(id:Double) {
        let newId = Favorites(context: context)
        newId.id = id
        do {try context.save()}
        catch {}
    }
    
    
    
    ///un-fave an event
    func desetFave(id:Double) {
        do {
        let favs = try context.fetch(Favorites.fetchRequest())
            for fav in favs{
                if Double((fav as AnyObject).id) == id {
                    context.delete(fav as! Favorites)
                    do {try context.save()}
                    catch {}
                }
            }
        }
        catch{}
    }
    
    
}
