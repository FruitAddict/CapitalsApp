# Capitals app

## Running the project

This project doesn't use any external dependencies. You can just clean the project and run it normally.

## Running Unit Tests

You can run the tests from both Capitals or CityBrowser targets, but only CityBrowser target contains unit tests.

## Project structure

This project is divided into several modules:

Capitals - the core of this app. It ties modules together and runs the CityBrowser flow.

CityBrowser - contains the view controllers and business logic for the european capital cities browser.

Networking - contains the HTTP client. 

PersistentStore- contains database logic.

Common - Logger etc.

## Additional considerations and comments

- Things I didn't do due to time constraints:
        - Strings are hardcoded.
        - The app only supports GET requests, but the networking module is easily extendable.
        - Cities should be identified by their unique ID instead of name.
        - Some things should be moved to extensions/ module-level constants 
        - I fetch the same image for every city.
        - UI Tests. 
        - Only the city list presenter is unit tested (not all cases are covered) (CityListPresenterTests).
        - Table view handling is pretty basic. I usually diff the dataset for nice updates.

- I found the european capital list on the web - thats it's weirdly formatted (name for the country/capital for the city name)

- I decided to make the modules as loosely coupled as possible. For example I decided against linking the Networking module to the CityBrowser module directly and inject implementations from the Core instead. This way I'm free to add any middleware from the core module ( for example I could add local persistence of the api call results for offline mode etc. ) or change the data source entirely without touching the feature module.

- I messed up the naming convention a little - should've sticked with ,,DefaultX'' for implementations but ended up with java-like ,,XImpl'' in some classes



