# TheChefzTask

TheChefzTask is a project build for TheChefz company.

## Description
This is my implementation for the task requested by TheChefz company. An iOS books app to fetch books connected to google books API with some cool features.
It's an iOS app that shows books to the user based on the user's search with the ability to save books from last search.

## Getting started
To run the project, clone the project and run the following commands:

```
cd "The path to the project on your machine"
pod install
```

## Features
- Search screen with search bar for the user to search for his favorite book.
- List the result books for the user in the Main and Search screens.
- Detailed cell to show the name and the thumbnail of the book in a good looking border.
- MVVM architecture using <b>RxSwift</b> and <b>RxCocoa</b> with Clean Code principles.
- Supporting iOS 15.5 and newer.
- Supporting all of the iPhone devices in the Portrait mode.
- <b>Unit test for the ViewModel components of the app. </b>

## Pods
- Alamofire: Used for all of the heavy work of networking in the app.
- Kingfisher: Used for fetching images for the books, totally built on Alamofire.
- RxSwift: Used as a Reactive wrapper for the app.
- RxCocoa: The Reactive library for UIKit.
- RealmSwift: Used for saving and persisting the books for the user.

## Project status
The project is completed in what was mentioned in the requirements document, however, it could have been done with better Unit testing and better UX if possible.
