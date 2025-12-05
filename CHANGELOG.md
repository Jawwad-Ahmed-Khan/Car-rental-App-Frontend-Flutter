# Changelog

All notable changes to this project will be documented in this file.

## [Unreleased] - 2025-12-06

### Booking & Payment Features
- **Booking Flow**:
    - Fixed data propagation issue where car details (Name, Price, Image) were not being passed to the Booking Details page, causing "Tesla" fallback data to appear.
    - Updated `BookingDetails` entity to include `carName` and `carImageUrl`.
    - Integrated `CarDetailPage` with `BookingDetailsPage` to pass selected car information.
- **Booking Creation**:
    - Resolved `400 Bad Request` error during booking submission.
    - Updated `Booking` entity and `BookingModel` to use `int` for `vehicleId` (matching backend requirement).
    - Corrected JSON serialization for `BookingModel` to use capitalized `Name` key.
- **Payment Flow**:
    - Fixed issue where rental dates were not reflecting on the Payment/Receipt screen.
    - Updated navigation to pass `pickupDate` and `returnDate` from Booking Details to Payment Methods.

### Search Feature
- **Real-time Search**:
    - Implemented `SearchRemoteDataSource` to fetch live car data from the backend (`/public/vehicles/list`).
    - Updated `SearchRepository` to filter cars locally based on search queries and brand filters.
    - Integrated `SearchBloc` with the new repository using Dependency Injection.
    - Replaced dummy data in `SearchPage` with actual backend data.
    - Updated `SearchCarCard` to display transmission type instead of dummy location.

### Receipt & Booking Fixes
- **Receipt Details**:
    - Added "Base Fare" and "Rent Days" to the Confirmation Page and Payment Receipt.
    - Passed `pricePerDay` through the entire booking flow to ensure accurate calculations.
- **Booking Bug Fixes**:
    - Fixed **Return Date Selection** bug where the date picker was not updating the field.
    - Fixed **Booking Failure** for non-primary emails:
        - Pre-filled booking form with logged-in user details (Name, Email, Phone).
        - Made Email field **read-only** to prevent mismatch between booking email and auth token.

### Favorite Cars Feature
- **User-Specific Favorites**:
    - Updated `ProfileLocalDataSource` to store favorites with user-specific keys (e.g., `favorite_cars_123`).
    - Registered `ProfileRepository` in Dependency Injection.
    - Updated `CarDetailPage` and `SearchPage` to persist and display favorites correctly.
    - Refactored `FavoritesPage` to use `ProfileRepository`.
    - Implemented real-time favorite status updates in `SearchBloc`.

### Navigation
- **Route Fixes**:
    - Updated Back button behavior in `SearchPage` and `ProfilePage` to correctly navigate back to `MainPage`.

## [Unreleased] - 2025-12-05

### Added
- **Authentication Feature**:
    - Implemented `AuthBloc` for state management (Login, Register, Logout).
    - Created `AuthRemoteDataSource` for API communication.
    - Created `AuthRepository` implementation.
    - Added Dependency Injection setup in `lib/di/injection_container.dart`.
- **Home Page**:
    - Merged Home Page changes from remote repository (commits `770da69`, `bc26d3e`).

### Modified
- **UI Integration**:
    - `lib/features/auth/pages/signup_page.dart`: Integrated `AuthBloc` for registration flow.
    - `lib/features/auth/pages/login_page.dart`: Integrated `AuthBloc` for login flow and resolved merge conflicts with remote branch.
- **App Configuration**:
    - `lib/main.dart`: Initialized Dependency Injection and wrapped the app with `MultiBlocProvider`.

### Fixed
- Resolved merge conflict in `login_page.dart` where local `AuthBloc` implementation conflicted with remote legacy code.

### Backend Integration (2025-12-05)
- **Auth Integration**:
    - Integrated Frontend with NestJS Backend Authentication API.
    - Updated `UserModel` to correctly map backend response fields (e.g., `first_name`, `contact`).
    - Updated `AuthRemoteDataSourceImpl`:
        - `login`: Parses nested `user` object and `access_token` from backend response.
        - `register`: Returns created user without auto-login.
- **Registration Flow**:
    - Refactored registration to **Manual Login** flow.
    - Added `AuthRegistered` state to `AuthBloc`.
    - Updated `SignupPage` to show success message and redirect to Login page upon successful registration.
