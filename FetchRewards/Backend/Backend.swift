//
//  Backend.swift
//  FetchRewards
//
//  Created by Prithiv Dev on 15/06/21.
//

import Foundation
import UIKit


extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}


extension Array where Element: Equatable {
    mutating func removeDuplicates() {
        var result = [Element]()
        for value in self {
            if !result.contains(value) {
                result.append(value)
            }
        }
        self = result
    }
}


class Backend {
    
    let clientID = "MjIyNTE2MDZ8MTYyMzgxMDcwMi4xNTgxOQ"
    var url :URL {
        return URL(string: "https://api.seatgeek.com/2/events?client_id=" + clientID)!
    }
    
    var urlWithQuery :URL{
        return URL(string: "https://api.seatgeek.com/2/events?client_id=" + clientID)!
    }
    
    
    
    
    ///this function takes a query and makes a call with it
    func fetchEventWithQuery(query:String, completionHandler: @escaping ([Event]) -> Void)  {
        var urlWithQuery :URL {
            return URL(string: "https://api.seatgeek.com/2/events?q=\(query)&client_id=" + clientID) ?? url
        }
        
        let task = URLSession.shared.dataTask(with: urlWithQuery, completionHandler: { (data, response, error) in
            if let error = error {
                print("Error with fetching films: \(error)")
                return
            }
            
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
                return
            }
     
            
            if let data = data,
               let _ = String(bytes: data, encoding: .utf8) {
                //  print("\n\n\(serverResponse)\n\n")
                
                do {
                    let decodedResponse = try JSONDecoder().decode(Events.self, from: data)
                    
                    //print(decodedResponse)
                    completionHandler(decodedResponse.events ?? [])
                    
                } catch let jsonError as NSError {
                    print("JSON decode failed: \(jsonError.localizedDescription)")
                }
                return
            }
            
        })
        task.resume()

        
        
    }
    
    
    
    
    
    
    ///this function just gets all the events
    func fetchAllMainEvents(completionHandler: @escaping ([Event]) -> Void) {
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error {
                print("Error with fetching films: \(error)")
                return
            }
            
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
                return
            }
     
            
            if let data = data,
               let _ = String(bytes: data, encoding: .utf8) {
                //  print("\n\n\(serverResponse)\n\n")
                
                do {
                    let decodedResponse = try JSONDecoder().decode(Events.self, from: data)
                    
                    //print(decodedResponse)
                    completionHandler(decodedResponse.events ?? [])
                    
                } catch let jsonError as NSError {
                    print("JSON decode failed: \(jsonError.localizedDescription)")
                }
                return
            }
            
        })
        task.resume()
        
    }
    
}
