# Stockee

Stockee is a mobile application that enables users to search for financial instruments (stocks, ETFs, commodities, crypto) on the NYSE/Nasdaq stock exchanges, learn more information about the stocks, and add them to their portfolio.

## Features

- User authentication
  - Allows user to register and login using their phone number and one-time password
- Search for financial instruments by ticker, common name, or other terms
  - Maximized speed of search and discovery using AI-powered Algolia Search
- View information on the financial instrument
  - Realtime price of the financial instrument
  - Historical price data of the financial instrument
  - Candlestick chart displaying dynamic price data
  - News related to the financial instrument
- Share the financial instrument with external parties
- Follow the financial instrument and add them into user's personal watchlist
  - User can manage their watchlist by adding or removing financial instrument
- Overview of the losses and gains in their portfolio

## Technology

- [Flutter](https://flutter.dev/)

- **Authentication:** [Firebase Authentication](https://firebase.google.com/)

- **Database System:** [Cloud Firestore](https://firebase.google.com/)

- **Financial instrument Provider:** [Alpha Vantage](https://www.alphavantage.co/)

- **Search platform:** [Algolia Search](https://www.algolia.com/)

## Installation

#### Step 1:

Download or clone this repo by using the link below:

```
  https://github.com/nicolas-lukita/stockee.git
```

#### Step 2:

Go to project root and execute the following command in console to get the required dependencies:

```
flutter pub get
```

#### Step 3:

Setup Firebase
Create a new firebase project. Follow the instructions at https://console.firebase.google.com

1.  Firebase Authentication

- Enable Phone as a Sign-In method in the Firebase console.
- Set app's SHA-1 hash in the Firebase console.
- Follow instructions to download google-services.json and place it inside the repository

2.  Cloud Firestore

- Navigate to the Cloud Firestore section of the Firebase console
- Select mode for security rules and set cloud firestore location

## Directory Structure

This project is using feature-based structure which seperates each project feature screens.

```bash
│   firebase_options.dart
│   generated_plugin_registrant.dart
│   main.dart
│
├───authentication_page
│       login_screen.dart
│       otp_screen.dart
│       user_data_screen.dart
│
├───dashboard
│       dash_screen.dart
│       gain_lose_section.dart
│       square_info_card.dart
│       watchlist_item_card.dart
│       watchlist_section.dart
│
├───details_page
│       candlestick_chart.dart
│       collapsed_panel_section.dart
│       details_header.dart
│       details_screen.dart
│       details_section.dart
│
├───helpers
│       button_functions.dart
│       custom_buttons.dart
│       custom_date_time_formatter.dart
│       custom_text_decorator.dart
│       helper_functions.dart
│
├───home_page
│       custom_navigation_bar.dart
│       home_screen.dart
│       tab_bar_wrapper.dart
│
├───models
│       global_quote.dart
│       news_sentiment.dart
│       stock_daily.dart
│       stock_intraday.dart
│       stock_listing.dart
│       stock_monthly.dart
│       stock_weekly.dart
│
├───news_page.dart
│       news_card.dart
│       news_section.dart
│
├───portfolio_page
│       balanced_table.dart
│       overview_card.dart
│       overview_section.dart
│       portfolio_screen.dart
│       portfolio_watchlist_card.dart
│       portfolio_watchlist_section.dart
│
├───search_page
│       algolia_search_page.dart
│       search_bar.dart
│       search_screen.dart
│       stock_card.dart
│
└───services
        alpha_vantage_api.dart
        api_key.dart
        firebase_auth_methods.dart
```

## App Navigation

![NavigationFlowchart](https://github.com/nicolas-lukita/stockee/blob/main/assets/Media/Navigation%20Flowchart.jpg)

## Future Improvement

Things to improve or implement to this project in the Future

- Add more test coverage
  - unit tests, widget tests, implementation tests
- Improve authentication
  - add more login methods
  - get more user presonalization data (email, profile picture, etc)
- More customizable profile
- Add animations
- Display more detailed data on:
  - Details page
  - Dashboard
  - Portfolio page
- Create more reusable and customizable custom widget or functions

## Screenshots

![Authentication](https://github.com/nicolas-lukita/stockee/blob/main/assets/Gif/Authentication.gif)
![Homescreen](https://github.com/nicolas-lukita/stockee/blob/main/assets/Gif/Homescreen.gif)
![DetailScreen](https://github.com/nicolas-lukita/stockee/blob/main/assets/Gif/Details-screen.gif)
![NewsSection](https://github.com/nicolas-lukita/stockee/blob/main/assets/Gif/News-section.gif)
![SearchScreen](https://github.com/nicolas-lukita/stockee/blob/main/assets/Gif/Search-screen.gif)

