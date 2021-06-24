//
//  ViewController.swift
//  FetchRewards
//
//  Created by Prithiv Dev on 10/06/21.
//

import UIKit
import Foundation

class EventsViewController : UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    ///background gradient view
    @IBOutlet var backgroundView: UIView!
    
    ///main table view that shows all the events
    @IBOutlet weak var tableView: UITableView!
    
    ///the view model that calls uses the Backend funcs
    private var eventsViewModel = EventsViewModel()
    
    ///the main search bar
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    ///this textview shows how many events are in the list
    @IBOutlet weak var resultsTextView: UITextView!
    
    ///
    var failsafeURl = URL(string: "https://cdn.aarp.net/content/dam/aarp/entertainment/music/2018/03/1140-concert-ticket-prices.imgcache.rev.web.1140.655.jpg")
    
    ///all the events, reloads the tableview when it gets set
    var allevents = [Event]()
    {
        didSet {
            DispatchQueue.main.async {
                
                ///update the tableview whenever the events array is updated
                self.tableView.reloadData()
                
                ///update the results textview whenever the events array is updated
                self.updateResultsTextView()
            }
            
        }
    }
    
    
    ///all the event ids that are faved
    var fav = [Double]()
    
    
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // view.insetsLayoutMarginsFromSafeArea = false
        
        // Do any additional setup after loading the view.
        ///tableview stuff
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.searchBar.delegate = self
        
        
        ///gradient stuff
        self.setGradient()
        
        ///fetch all the events
        self.fetchEvents()
        
        ///get favs
        self.getFaves()
        
    }
    
    
    /// this function makes the API call to fetch all the events
    func fetchEvents()  {
        ///make the viewmodel fetch all the events
        self.eventsViewModel.getEvents(completionHandler: { allEvents in
            self.allevents = allEvents
        })
        
        
    }
    
    
    ///the query returns lots of duplicates, this function removes them
//    func removeDuplicateEvents(events:[Event]) -> [Event]{
//        var returnEvents = [Event]()
//        var eventsID = events.map({$0.id})
//
//        for event in events {
//            if !eventsID.contains(event.id){
//                returnEvents.append(event)
//                eventsID.append(event.id)
//            }
//        }
//        return returnEvents
//    }
//
    
    ///fetch events for query
    func fetchEventsForQuery(q:String)  {
        
        self.eventsViewModel.getEventsForQuery(query: q, completionHandler: { allevent in
            ///a potential solution to remove duplicates
          //  self.allevents = self.removeDuplicateEvents(events: allevent)
            
            self.allevents = allevent
        })
    }
    
    
    
    ///as the user types the result textview updates
    func updateResultsTextView()  {
        if allevents.count != 0 {
            self.resultsTextView.text = "Showing \(allevents.count) " + "\(allevents.count == 1 ? "event": "events")"
        }
        
        if allevents.count == 0{
            self.resultsTextView.text = "No events"
        }
        
        self.resultsTextView.text = self.resultsTextView.text.uppercased()
        
    }
    
    
    
    
    ///get all the faves
    func getFaves() {
        self.fav = eventsViewModel.getAllFaves()
        print(self.fav)
    }
    
    
    
    
    
    // MARK: - Background Gradient
    func setGradient()  {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor(red: 0.67, green: 0.71, blue: 0.90, alpha: 1.00).cgColor, UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00).cgColor]
        
        
        
        gradientLayer.shouldRasterize = true
        self.backgroundView.layer.addSublayer(gradientLayer)
    }
    
    
    
    
    
    
    
    // MARK: - TableView Functions
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allevents.count
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           
        print(allevents[indexPath.row])
        self.performSegue(withIdentifier: "detailSegue", sender: self)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        ///create a custom cell if possible, get event info and add it onto the cell, load the image in the background.
        if let cell = tableView.dequeueReusableCell(withIdentifier: "EventTableViewCell", for: indexPath) as? EventTableViewCell {
            let event = allevents[indexPath.row]
            let imageURL = URL(string: event.performers?[0].image ?? "" ) ?? failsafeURl!
            cell.eventName?.text = event.short_title
            cell.eventLocation?.text = event.venue?.display_location?.uppercased()
            cell.eventImage?.load(url: imageURL) 
            
            ///make the
            cell.eventName.sizeToFit()
            cell.eventTextBlurView.frame.size.width = cell.eventName.layer.frame.width + 20
            
            if self.fav.contains(event.id!) || event.id != nil {
                cell.faveImage.isHidden = false
                cell.faveImage.layer.shadowOpacity = 0.7
                cell.faveImage.layer.shadowOffset = CGSize(width: 20, height: 20)
                cell.faveImage.layer.shadowRadius = 25.0
                cell.faveImage.layer.shadowColor = UIColor.darkGray.cgColor
            }
            
            if !self.fav.contains(event.id!) || event.id == nil {
                cell.faveImage.isHidden = true
            }
            
            
            ///add all the shadows
            ///blurview
            cell.eventTextBlurView.layer.cornerRadius = 11
            cell.eventTextBlurView.layer.shadowOpacity = 0.7
            cell.eventTextBlurView.layer.shadowOffset = CGSize(width: 15, height: 15)
            cell.eventTextBlurView.layer.shadowRadius = 20.0
            cell.eventTextBlurView.layer.shadowColor = UIColor.darkGray.cgColor
            
            
            ///eventname
            cell.rightButton.layer.shadowOpacity = 0.7
            cell.rightButton.layer.shadowOffset = CGSize(width: 10, height: 10)
            cell.rightButton.layer.shadowRadius = 25.0
            cell.rightButton.layer.shadowColor = UIColor.darkGray.cgColor
            
            ///return the cell
            return cell
            
        }
        
        
        else {
            return EventTableViewCell()
        }
        
        
    }
    
    
    
    
    // MARK: - Search Bar Functions
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        ///if the xmark button is clicked or the search bar is cleared, just give all the events
        if searchBar.text == "" {
            ///fetch all the events
            self.fetchEvents()
            DispatchQueue.main.async {
                self.searchBar.resignFirstResponder()
            }
        }
        
        ///if the search bar has text to be searched for, search.
        else if searchBar.text != "" {
            
            self.fetchEventsForQuery(q: searchBar.text!)
            
            ///we are filtering events by if the title or address has the serach bar text
//            allevents = allevents.filter({$0.short_title!.lowercased().contains(searchBar.text!.lowercased()) || $0.venue!.display_location!.lowercased().contains(searchBar.text!.lowercased()) || $0.title!.lowercased().contains(searchBar.text!.lowercased())})
            
        }

    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
    }
    
    
    
    // MARK: - Segue Function
    ///this functions get to the detail view and passes on the event
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let controller = segue.destination as! DetailedEventViewController
                controller.event = allevents[indexPath.row]
            }
        }
    }

    
}




