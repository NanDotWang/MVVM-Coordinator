# MVVM + Coordinator Experiment

## Backend API
App uses [Food2Fork API](http://food2fork.com/about/api) as a backend service, following API requests are used:

| API Request           | Method  |                                                           Sample url |
|:--------------------- |:-------:| --------------------------------------------------------------------:|
| Top trending recipes  |   GET   |              http://food2fork.com/api/searchkey={key}&sort=t&count=10|
| Search recipes        |   GET   |    http://food2fork.com/api/search?key={key}&sort=r&q={searchKeyword}|
| Get recipe detail     |   GET   |                 http://food2fork.com/api/get?key={key}&rId={recipeId}|

## Architecture
App uses a similar concept of MVVM + Coordinators pattern:
 
* Each `ViewController` has a `DataProvider` which provides ready-to-use data for the `ViewController`.  
* `ViewController` acts as a dummy UI layer and delegates its actions to `Coordinator` 
* `Coordinator` instantiates view controllers, injects dependencies, handles push / present navigations. 

## Unit tests
Some basic unit tests are implemented to cover:

* Recipe url tests
* Recipe API resource tests
* Recipe API service tests

## UI tests
Some basic UI tests are implemented to cover:

* Show instructions web page
* Show orginal web page
* Search recipes with results
* Search recipes without results
