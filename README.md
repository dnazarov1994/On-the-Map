# On the Map
On the map app allows student to share any information with others

## Architecture
#### The app has three view controller scenes:
- Login View: Allows the user to log in using their Udacity credentials.
- Map and Table Tabbed View: Allows users to see the locations of other students in two formats.  
- Information Posting View: Allows the users specify their own locations and links with information.

## Functionality
The map contain pins that show the location where other students have reported studying. By tapping on the pin users can see a URL for something the student finds interesting. The user able to add his own data by posting a string that can be reverse geocoded to a location, and a URL.

## Data from network resources
The app using data from two network resources:
###### Parse API: "https://parse.udacity.com/parse/classes/"
###### Udacity API: "https://onthemap-api.udacity.com/v1/"

## User information
The app has a request with student information from the server:
```
struct LocationRequest: Codable {
    var uniqueKey: String
    var firstName: String
    var lastName: String
    var mapString: String
    var mediaUrl: String
    var latitude: Double
    var longtitude: Double
}
```
## Error handling
If the submission fails to post the data to the server, then the user see an alert with an error message describing the failure.

