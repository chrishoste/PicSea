![logo](https://github.com/chrishoste/PicSea/assets/22995847/49a98ca2-da1d-443b-9cfa-edc4a1c234fa)
[![iOS](https://img.shields.io/badge/iOS-16-green)](https://img.shields.io/badge/iOS-16-Green)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)

# PicSea
This project demonstrates my skills in building a functional iOS application that interacts with a REST API, retrieves photo data, and incorporates various features like viewing, filtering, and exploring photo albums.

In PicSea, I've created an iOS app that fetches photo data from a REST API endpoint. The app's core functionality includes displaying a list of photo albums, allowing users to explore albums, switch between different layouts, and view individual photos in detail. It also provides options to copy photo URLs and offers a seamless user experience.

## Features
- [x] The app presents a user-friendly list of photo albums, providing key album information.
- [x] Users can conveniently explore albums and switch between list and grid layouts to suit their preference.
- [x] Each album can be expanded to view individual photos and navigate through them.
- [x] Users can copy the URL of a photo to share or save it.
- [x] The app offers a smooth and responsive user interface for an enjoyable photo browsing experience.
- [x] It showcases best practices in Swift, SwiftUI, and asynchronous programming for iOS development.
- [x] And it also contains some simple unit testing.

## Requirements
To run this application, you will need the following:
- iOS 16
- Stable internet connection

## Technology Stack
- SwiftUI & UIKit

## Future Features Ideas

While PicSea currently showcases essential functionalities, there are exciting possibilities for future enhancements and features ideas:

1. **Customizable Grid View Rows**: Implementing a pinch-to-zoom feature, similar to the Apple Photos app, could allow users to adjust the number of rows displayed in the grid view according to their preferences.

2. **Improved Photo Source**: Consider exploring and integrating a more extensive and diverse photo API to provide users with a wider range of real photos to explore and enjoy.

3. **Enhanced User Interaction**: Enhance user interaction by adding context menus or long-press gestures on images in the list/grid view, enabling features like "peek and pop" to provide quick previews or actions.

These are just a few ideas to consider for potential future improvements.

## Reflection

### What Was Done Well
1. **Modular and Flow**: The app's modular architecture and flow have been designed effectively, making it easy to understand and maintain. This modular approach enhances scalability and code organization.

2. **Layout Flexibility**: The ability to switch between list and grid views provides users with flexibility in how they explore and interact with photo albums.

### Areas for Improvement
1. **Data Loading** In this demonstration app, I fetch all the data (5000 items) from a JSON API at once for simplicity and clarity. However, in a production app, it's advisable to implement more efficient data loading strategies, such as pagination or lazy loading, to minimize unnecessary overhead and improve performance. These strategies help ensure a smoother user experience, especially when dealing with a large dataset.

2. **Image Caching and Third-Party Libraries**: While the app initially used Apple's `AsyncImage` for image loading, it presented limitations in terms of caching and placeholder display, leading to the development of the `CachedAsyncImage`. This experience highlights the importance of choosing the right image handling approach. In future iterations, considering the integration of third-party libraries like [Kingfisher](https://github.com/onevcat/Kingfisher) or [Nuke](https://github.com/kean/Nuke) may further improve image caching, rendering, and overall image handling for a smoother user experience.

## Screenshots

|Screen |Screen |
|-------|-------|
|![IMG_0625](https://github.com/chrishoste/PicSea/assets/22995847/f47900f7-9790-4d1a-b304-69ca6ad617dc)|![IMG_0626](https://github.com/chrishoste/PicSea/assets/22995847/cc453ba6-dd18-4f25-b1e3-c0c1bdfba296)|
|![IMG_0627](https://github.com/chrishoste/PicSea/assets/22995847/a149383e-8969-45ba-9c78-7863bfd85384)|![IMG_0628](https://github.com/chrishoste/PicSea/assets/22995847/c685bce5-8159-4d99-bcbe-7a9ffaf2952a)|
|![IMG_0629](https://github.com/chrishoste/PicSea/assets/22995847/48d80dfe-3e17-4c0a-aee7-c13a0ae14ec4)|![IMG_0630](https://github.com/chrishoste/PicSea/assets/22995847/446ae354-75c1-4fc1-95af-0d0b26b9906f)|
|![IMG_0631](https://github.com/chrishoste/PicSea/assets/22995847/b91269b7-e3a3-4426-9b84-f7e4de3a6de1)||





