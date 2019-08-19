# On the Map
On the Map app allows a student to share information with others and posting it on the map using coordinates associated with students location. 

<img width="298" alt="Screen Shot 2019-08-18 at 9 48 35 PM" src="https://user-images.githubusercontent.com/46335329/63234165-2059f400-c202-11e9-8cbb-d2b54f630e07.png">

<img width="299" alt="Screen Shot 2019-08-18 at 9 35 32 PM" src="https://user-images.githubusercontent.com/46335329/63234191-41224980-c202-11e9-9e6d-90168ddb5433.png">

<img width="298" alt="Screen Shot 2019-08-18 at 9 36 03 PM" src="https://user-images.githubusercontent.com/46335329/63234223-66af5300-c202-11e9-8af0-3f67cfe18602.png">



## Architecture
#### The app has three view controller scenes:
- Login View: Allows the user to log in using their Udacity credentials.
- Map and Table Tabbed View: Allows users to see the locations of other students in two formats.  
- Information Posting View: Allows the users specify their own locations and links with information.

## Functionality
The map contains pins that show the location where other students have reported studying. By tapping on the pin users can see a URL for something the student finds interesting. The user able to add his own data by posting a string that can be reverse geocoded to a location, and a URL.

## API
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
If the submission fails to post the data to the server, then the user sees an alert with an error message describing the failure.

## Requirements

- Xcode 9.2
- Swift 4.0
