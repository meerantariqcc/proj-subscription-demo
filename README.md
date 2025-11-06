# SubscriptionDemo

## Overview

SubscriptionDemo is a simple iOS application that allows users to track their subscriptions. Users can create new subscriptions by providing details such as the service name, amount, category, start date, frequency, and active status. All created subscriptions are displayed in a list.

## Features

- **Create Subscription**: Add new subscriptions with various details.
- **List Subscriptions**: View all active and inactive subscriptions in a consolidated list.

## Architecture

The application follows the Model-View-Controller (MVC) architectural pattern, a standard for iOS development. This pattern separates the application into three main components:

- **Models**: Represents the data and business logic of the application (e.g., `Service.swift`, `Subscription.swift`).
- **Views**: Responsible for the visual representation of the data (e.g., UI elements in storyboards or programmatically created views).
- **Controllers**: Acts as an intermediary between Models and Views, handling user input and updating the View or Model accordingly (e.g., `CreateSubscriptionViewController.swift`, `SubscriptionListViewController.swift`).

## Directory Structure

- `SubscriptionDemo/`: The main application directory.
  - `AppDelegate.swift`: Handles app-level lifecycle events.
  - `SceneDelegate.swift`: Manages the app's scenes and window.
  - `Controllers/`: Contains `UIViewController` subclasses that manage views and handle user interactions.
    - `CreateSubscriptionViewController.swift`: Manages the screen for creating new subscriptions.
    - `SubscriptionListViewController.swift`: Displays a list of all created subscriptions.
    - `Pickers/`: Contains view controllers for various pickers (e.g., `CategoryPickerViewController.swift`, `DatePickerViewController.swift`, `FrequencyPickerViewController.swift`, `ServiceListViewController.swift`).
  - `Models/`: Contains data structures and business logic.
    - `Service.swift`: Defines the structure for a service.
    - `Subscription.swift`: Defines the structure for a user's subscription.
  - `Resources/`: Stores application assets like images and plists.
  - `Views/`: Contains UI-related files, such as storyboards.
- `SubscriptionDemo.xcodeproj/`: The Xcode project file.

## Setup and Installation

To set up and run the SubscriptionDemo application on your local machine, follow these steps:

1.  **Clone the Repository (if applicable):**
    ```bash
    git clone <repository-url>
    cd SubscriptionDemo
    ```

2.  **Open in Xcode:**
    Navigate to the project directory and open the `.xcodeproj` file:
    ```bash
    open SubscriptionDemo.xcodeproj
    ```

3.  **Select a Simulator or Device:**
    In Xcode, select your desired iOS simulator or a connected physical device from the scheme dropdown menu.

4.  **Build and Run:**
    Click the "Run" button ( ▶ ) in Xcode or press `Cmd + R` to build and run the application.

## Usage

1.  **View Subscriptions**: Upon launching the app, you will see a list of your subscriptions.
2.  **Add New Subscription**: Tap the "+" button in the top right corner to open the "Create Subscription" screen.
3.  **Fill in Details**: Enter the subscription details such as:
    -   **Service**: Choose a service from the list.
    -   **Amount**: The cost of the subscription.
    -   **Category**: The category of the subscription.
    -   **Start Date**: The date when the subscription begins.
    -   **Frequency**: How often the subscription renews.
    -   **Active**: Toggle whether the subscription is currently active.
4.  **Save Subscription**: Tap the "Save" button to add the subscription to your list. The input fields will reset for a new entry.
5.  **Navigate Back**: If you navigate away from the SubscriptionListViewController, you can use the back button to return.
