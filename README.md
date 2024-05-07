# VerimiChallenge

## Description

VerimiChallenge is a mobile app that allows users to browse a gallery of images from the Placeholder API and mark their favorite images. It consists of two tabs: Gallery and Favorites.

Key Features:
- Gallery: Displays a mosaic representation of images fetched from the Placeholder API. Users can view images in full size by tapping on them and mark them as favorites.
- Favorites: Displays a list of images marked as favorites by the user. Users can view the full-size image and remove items from the favorites list.

## Architecture

VerimiChallenge follows the MVVM (Model-View-ViewModel) architecture pattern for clean separation of concerns. SwiftUI is used for building the user interface.

## File Organization

The code files and resources are organized as follows:

- `Views`: Contains SwiftUI views and viewmodels for different screens and components.
- `Networking`: Contains the networking service for fetching images from the Placeholder API.
  - `Repositories`: Contains repositories that handle data operations.
- `Models`: Contains data models used throughout the app.
- `Extensions`: Contains Swift extensions for adding functionality to existing types.
- `Shared`: Contains shared utilities and helper files used across the app.
- `ViewModifiers`: Contains custom modifiers for SwiftUI views to enhance reusability.

## Testing

Unit tests have been implemented for critical components of the app to ensure its functionality and stability.

## Dependencies

VerimiChallenge uses the following dependencies:

- SwiftUI
- SwiftData (for handling data persistence)
- CachedAsyncImage (for image caching)

## Localization

Localization support is not implemented in this version of the app.

## Extras

- **Pagination**: Implemented pagination to load images in batches for improved performance.
- **Caching**: Utilizes caching to enhance the loading speed of images and reduce network requests.
- **Dynamic Layout**: Users can dynamically change the layout between 2, 3, or 4 columns.
- **Delete Functionality**: Users can delete images from the Photos tab for testing purposes.

