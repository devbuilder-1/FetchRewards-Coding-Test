//
//  DetailedEventViewController.swift
//  FetchRewards
//
//  Created by Prithiv Dev on 23/06/21.
//

import Foundation
import UIKit

class DetailedEventViewController : UIViewController {
    
    
    
    /// this is the event passed from the main viewcontroller
    var event = Event(type: "", id: 2, datetimeUTC: nil, venue: nil, performers: nil, datetimeLocal: nil, short_title: nil, visibleUntilUTC: nil, url: nil, score: nil, announceDate: nil, createdAt: nil, title: nil, popularity: nil, eventDescription: nil, status: nil, enddatetimeUTC: nil)
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    ///the image with a cool parallex effect
    @IBOutlet weak var eventImage: UIImageView!
    
    
    ///title label
    @IBOutlet weak var titleLabel: UITextView!
    @IBOutlet weak var venueLabel: UITextView!
    @IBOutlet weak var locationLabel: UITextView!
    
    
    ///the view model that calls uses the Backend funcs
    private var eventsViewModel = DetailedEventViewModel()
    
    
    ///update the fave title accordingly
    @IBOutlet weak var faveLabel: UITextView!
    
    
    ///all the event ids that are faved
    var fav = [Double]()
    
    
    
    ///this function setfaves and de-sets faves
    @IBAction func faveThis(_ sender: UIButton) {
        if !fav.contains(self.event.id!) {
            self.eventsViewModel.setFave(id: self.event.id!)
            print(self.fav)
            self.faveLabel.text = "You favourited this event"
            return
        }
        
        if fav.contains(self.event.id!) {
            self.eventsViewModel.desetFave(id: self.event.id!)
            // self.getFaves()
            // print(self.fav)
            self.faveLabel.text = ""
            return
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ///load the image
        self.loadImage()
        
        
        ///add labels, title and etc.
        self.loadInfo()
        
        
        ///get faves
        self.getFaves()
        
        ///set fave label
        self.setFaveLabel()
        
    }
    
    
    
    func setFaveLabel()  {
        if self.fav.contains(self.event.id!) {
            self.faveLabel.text = "You favourited this event"
        }
        
        if !self.fav.contains(self.event.id!) {
            self.faveLabel.text = ""
        }
    }
    
    
    ///this function get the image from the URL and adds a parrallex effect
    func loadImage()  {
        let imageURL = URL(string: event.performers?[0].image ?? "" )!
        self.eventImage.load(url: imageURL)
        self.addParallaxToView(vw: self.eventImage)
    }
    
    
    ///set the title, venue name and other info
    func loadInfo()  {
        self.titleLabel.text = self.event.short_title
        self.titleLabel.sizeToFit()
        
        self.venueLabel.text = self.event.venue?.name_v2
        self.venueLabel.sizeToFit()
        
        self.locationLabel.text = self.event.venue?.display_location
        self.locationLabel.sizeToFit()
    }
    
    
    ///get all the faves
    func getFaves() {
        self.fav = eventsViewModel.getAllFaves()
    }
    
    
    
    
    // MARK: - Parallax
    func addParallaxToView(vw: UIView) {
        let amount = 30
        
        let horizontal = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        horizontal.minimumRelativeValue = -amount
        horizontal.maximumRelativeValue = amount
        
        let vertical = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
        vertical.minimumRelativeValue = -amount
        vertical.maximumRelativeValue = amount
        
        let group = UIMotionEffectGroup()
        group.motionEffects = [horizontal, vertical]
        vw.addMotionEffect(group)
    }
}
