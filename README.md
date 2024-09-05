# README

## Introduction

### Overview
This website allows users to share YouTube videos with other users, providing a platform for discovering and watching shared videos. It includes features for registration, login, and real-time updates.

### Key Features
- **User Authentication**: Registration, login, and logout.
- **Video Sharing**: Users can share YouTube videos with others.
- **Video Watching**: View videos shared by other users.
- **Real-time Updates**: Get notifications and update the list when new videos are shared by other users.

## Prerequisites

### Backend
- **Ruby**: 3.3.4
- **Rails**: 7.2.1
- **Websocket**: ActionCable with Redis 7
- **Authentication**: Devise and devise-jwt

### Frontend
- **ReactJS**: 18.3.1 with Vite
- **State Management**: [Zustand](https://github.com/pmndrs/zustand) (4.5.5)
- **HTTP Request**: Axios
- **UI Libraries**: [shadcn/ui](https://ui.shadcn.com/) and [TailwindCSS](https://tailwindcss.com/) (3.4.10)

### Database
- **Sqlite**: 3

### Deployment
- **Platform**: [Fly.io](https://fly.io/) for both Backend and Frontend applications.

### Dockerization
- **Docker**: For containerization
- **Docker Compose**: For development setup

### Testing
- **Unit Testing**: RSpec
- **Automation Testing**: Capybara + Selenium

## Installation
### Prerequisites
1. Clone the repository:
  ```bash
  git clone git@github.com:datlm-2209/remi.git
  cd remi
  ```

2. Create `config/master.key`
  ```bash
  touch config/master.key
  vi config/master.key
  # For demo purposes, using below master.key for development.
  # In a real project, we should only share the key between dev in a secure channel and should not be pushed to github.
  # 8cf056c983e9f873718ed8a42520e44b
  ```
### Docker

1. Install:
  ```bash
  cd /frontend
  cp .env.example .env
  npm install
  ```

### Without Docker (Not Recommended)
1. Install Ruby 3.3.4:

  https://www.ruby-lang.org/en/documentation/installation/

2. Install Ruby dependencies:
  ```bash
  gem install bundler
  bundle install
  ```
3. Configure the database:
  ```bash
  rails db:create
  rails db:migrate
  rails db:seed
  ```
4. Install JavaScript dependencies:
  ```bash
  cd /frontend
  npm install
  ```
5.  Create .env
  ```bash
  cp .env.example .env
  ```
6.  Start the React application:
  ```bash
  npm run dev
  ```
7.  Access the application in your browser at http://localhost:8080.

## Database Setup
### With Docker
Docker compose will automatically create and migrate database upon start.
1. Seed the database with initial data:
  ```bash
  make seed
  ```

### Without Docker
1. Create and migrate the database:
  ```bash
  rails db:prepare
  ```
2. Seed the database with initial data:
  ```bash
  rails db:seed
  ```

## Running the Application
### With Docker
1. Start the development server and application:
  ```bash
    make up
  ```
2. Access the application in your web browser at http://localhost:8080.
### Without Docker
1. Start the development server:
  ```bash
    rails s
  ```
2. Start the development React application:
  ```bash
    npm run dev
  ```
3. Access the application in your web browser at http://localhost:8080.
### Test
  Run the test suite (Unit test and Automation test)

  ```bash
    rspec
  ```

https://github.com/user-attachments/assets/c0fd9856-cde2-482b-bb72-f3c5b7a5f4ba

## Docker Deployment
1. Install flyctl:
   https://fly.io/docs/flyctl/install/
2. Deploy Backend:
  ```bash
    fly deploy
  ```
3. Build and Deploy Frontend:
  ```bash
    cd /frontend
    vi .env
    # Update URL to match server URL
    # VITE_API_URL: "https://remi-app.fly.dev"
    # VITE_WS_URL: "wss://remi-app.fly.dev/cable"
    npm run build
    fly deploy
  ```
4. Access the Backend and Frontend applications via https://remi-frontend.fly.dev/ for FE and https://remi-app.fly.dev/ for BE.

## Usage
- **Registration**: Sign up for a new account.
- **Login**: Log in with your credentials.
- **Share Videos**: Use the share feature to add new YouTube videos.
- **Watch Videos**: Browse and watch videos shared by other users.
- **Real-time Notifications**: Receive updates when new videos are shared.

## Live Demo
A live demo of the application can be accessed at https://remi-frontend.fly.dev/.

Demo account: `demo/12345678`

*The website might be empty upon first load because of cold start, please be patient and reload the page.*
