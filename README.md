#  FetchRewards Coding Project - Prithiv Dev Devendran 




## Aim : To build an application that fetches events from the SeatGeek API, the application also dynamically fetches events when the user is searching through the search bar. The user can favourite and un-favourite events. The app is an universal app.



## Application Logic : When the app is started, we make a call to https://api.seatgeek.com/2/events?, this gives back some events, a UITableView is used to populate the view with these events. The https://api.seatgeek.com/2/events?q= API endpoint is use to get the text from UISearchBar and pass it on and get back results. CoreData is used to save all the favorited events. This persists through out app launches. 



## Architecture used : MVVM 











## P.S : run the app on an actual device and check out the parralex effect when you click on an event. 
