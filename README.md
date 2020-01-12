# CityFetcher
City fetching app

Architecture Used : MVC

Model: A model for the city object used to map the JSON object fetched form the api after being decoded and set to the array "cities" which is an array of "CityModel".

View: 
- A TableView to show the resulted array , unfortunately i wasn't able to user Google Maps static api because it required billing information (creadit card) and i do not have a credit card.
- A MapKit View where the coordinates of the chosen city appears on the map with an annotation on these coordinates.
- A nib file where i designed a custom table view cell , instead of using static google api maps , i used the default mapkit maps , but it consumed alot of memory so i had to remove it.
- A nib file with a simple activity indicator to use in the tableView when loading other pages (infinite scroll). 


Controller:
- CityFetchViewContoller which is the main controller for fetching and showing data on the table view , the function fetchJSON is the function responsible of fetching data from the given API and decoding it using the default decoder and passing it to a CODABLE model (CityModel).
- Adding an extra cell and checking whether the tableView is at the last cell so it can fetch the next page and sort the resulting array
- Filtering the existing data using searchText and the function (textDidChange) to observe the change in the search field and start filtering the data according to this filter.

