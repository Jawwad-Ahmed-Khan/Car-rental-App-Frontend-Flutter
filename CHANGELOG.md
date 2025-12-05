# Changelog

All notable changes to this project will be documented in this file.

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
