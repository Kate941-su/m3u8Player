# 05.10.2024

## swipeAction()
Add additional actions in the row in the list

## Navigation Stack
- It has the most highest hierarchy
- It is used 'Lazy Loading' which means that the app doesn't render all of screens where the app might visit the screen.
- It distincts each item by Int type id.
- `[$stackPath`](https://www.youtube.com/watch?v=GZ-hQWMjT0s) can make a limitation of which path you will go as a next screen.
- `Equtable` can create the two ways. 
  - Creating automatically if the struct is structed as premitive types.
  ```
   struct VideoData: Identifiable, Equatable {
       var id: UUID = UUID() // Assuming you have this property
       var title: String
       var url: URL
   }
  ```

  - Defining yourself
  ```
   struct VideoData: Identifiable {
    var id: UUID = UUID()
    var title: String
    var url: URL
    
    // Manually implement Equatable
    static func ==(lhs: VideoData, rhs: VideoData) -> Bool {
        return lhs.id == rhs.id &&
               lhs.title == rhs.title &&
               lhs.url == rhs.url
    }
  }
  ```


## 05.10 Summay
I learned that composable architecture thinks about project wants to struct state as each component unit it doesn't have to depend on `view` (because I'm familiar with MVVM so I tend to connect state as view model)

I can add simple Composable Architecture features.

I am getting used to using SwiftUI grammers.

## TODO
- Adding items and holding item state (delete, add, update )
- Adding a persistence layer (SQLite?)
- AVFoundation to play HLS stream sounds🎼
