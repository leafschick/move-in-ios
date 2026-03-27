# Move In

A native iOS app that connects users with local moving companies. Browse movers, view details, and book a moving service all from your phone.

Built for **COMP3097 – Mobile App Development II** by Group 11.

---

## Screens

| Screen | Description |
|---|---|
| **Login** | Email + password authentication |
| **Sign Up** | New account creation with validation |
| **Home** | Featured movers and search entry point |
| **Find Movers** | Full mover list with Top Rated / Best Price filters |
| **Vendor Detail** | Mover info, services, pricing, and Book Now |
| **Book Service** | Date, time, pickup/delivery address, booking summary |
| **Bookings Dashboard** | Upcoming and history tabs |
| **Profile** | Account info and logout |

---

## Tech Stack

- **Swift + SwiftUI** — 100% declarative UI
- **Xcode 16** — minimum iOS 17 target
- `@AppStorage` for lightweight auth persistence
- No third-party dependencies

---

## Project Structure

```
MoveIn/
├── MoveInApp.swift          # App entry point
├── ContentView.swift        # Delegates to AppFlowView
├── AppFlowView.swift        # Auth routing (login vs main app)
├── MainTabView.swift        # Bottom tab bar
│
├── MoverData.swift          # Shared HomeMover model + dataset
│
├── HomeView.swift           # Home tab
├── SearchView.swift         # Search/filter tab
├── VendorDetailView.swift   # Mover detail page
├── BookingView.swift        # Booking form
├── DashboardView.swift      # Bookings tab
├── ProfileView.swift        # Profile tab
│
├── LoginView.swift          # Login screen
├── SignUpView.swift         # Sign up screen
└── AuthTextField.swift      # Reusable auth text field
```

---

## Getting Started

1. Clone the repo:
   ```bash
   git clone https://github.com/leafschick/move-in-ios.git
   ```
2. Open `MoveIn.xcodeproj` in Xcode.
3. Select a simulator (iPhone 15 or later recommended).
4. Press **Run** (`⌘R`).

No API keys or additional setup required.

---

## Team — Group 11

| Name | Student ID |
|---|---|
| Arina Mirzakhani | 101418340 
| Ayesha Akbar | 100949840 
| Lakshay Dhawan | 101464867 
| Sofiia Beliak | 101469384 
| Suthan Sureshkumar | 101511337 
| Vincente Sequeira | 101484793 