# 📦 Expyr

## 📌 Index

- [📝 Project Overview](#-project-overview)
- [🎨 UI Enhancements](#-ui-enhancements)
- [🌎 State Management & Architecture](#-state-management--architecture)
- [⚙️ Setup](#-setup)
- [🚀 Improvements & Future Scope](#-improvements--future-scope)

---

## 📝 Project Overview

I started building the app on the provided codebase, which was then refactored and enhanced to support the required functionalities.
### ✅ Core Features

- **Mark food items as consumed** from the available list
- **View consumed items separately** in a dedicated tab
- **Drag item to left to quickly move item between available & consumed lists**
- **Error handling with a global handler and UI-level feedback**
- **Theme management for easy customization**
- **Dependency Injection & Loose Coupling for scalability**

---

## 🎨 UI Enhancements

1. **Bottom Navigation Bar**:
  - Two tabs: **Available Items** & **Consumed Items**
  - Users can switch between lists effortlessly

2. **Swipe to Move**:
  - Dragging an item left moves it to the other list (**consumed → available and vice versa**)
  - Quick and intuitive way to manage food items

3. **Theming System**:
  - Introduced a theme folder
  - Created `app_color.dart`, `app_theme.dart`, and `app_text_theme.dart`
  - Centralized theme management for easy scalability


---

## 🌎 State Management & Architecture

- **Provider**: Used for state management
- **Freezed for Models**: Eliminates the need for manually writing `fromJson`, `toJson`, and `copyWith` methods
- **Dependency Injection**: Abstracted `MockFirebaseService` for better testability and scalability
- **Error Handling**:
  - **Global Error Handler**: `runZonedGuarded` for catching unexpected errors
  - **Localized UI Errors**: Display known errors within the UI

---

## ⚙️ Setup

```bash
# Clone the repository
git clone <repository-url>

# Navigate to the project directory
cd expyr_assignment_1

# Install dependencies
flutter pub get

# Generate model classes using Freezed
dart run build_runner build

# Run the app
flutter run
```

## 🚀 Improvements & Future Scope
### 🔹 Architectural Enhancements
- Use MVVM Architecture to improve separation of concerns and make the codebase more scalable.
- Switch to Riverpod for robust state management, better performance, and enhanced error handling.
- Improve Error Handling by adding more user-friendly UI feedback and structured exception handling
### 🔹 Feature Enhancements
- **Partial Consumption Tracking**: Allow users to mark only part of an item as consumed instead of the entire item

