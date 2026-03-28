import SwiftUI
import UIKit

struct HomeMover: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String?
    let rating: Double
    let reviewCount: Int
    let priceRange: String
    let description: String
    let city: String
    let services: [String]
    let isFeatured: Bool
}

let allMovers: [HomeMover] = [
    HomeMover(
        name: "EasyMove Pro",
        imageName: nil,
        rating: 4.9,
        reviewCount: 456,
        priceRange: "$180-$350",
        description: "Premium moving service with insurance coverage included.",
        city: "Los Angeles, CA",
        services: ["Local Moving", "Insurance Coverage", "Packing Service", "Furniture Protection"],
        isFeatured: true
    ),
    HomeMover(
        name: "Swift Movers",
        imageName: nil,
        rating: 4.8,
        reviewCount: 234,
        priceRange: "$150-$300",
        description: "Professional moving services with 10+ years of experience.",
        city: "New York, NY",
        services: ["Local Moving", "Long Distance Moving", "Packing Assistance", "Furniture Handling"],
        isFeatured: true
    ),
    HomeMover(
        name: "Prime Relocation",
        imageName: nil,
        rating: 4.8,
        reviewCount: 321,
        priceRange: "$200-$380",
        description: "Trusted relocation specialists for large and complex moves.",
        city: "Chicago, IL",
        services: ["Large Moves", "Commercial Moving", "Packing", "Special Item Handling"],
        isFeatured: true
    ),
    HomeMover(
        name: "Family Movers Co",
        imageName: nil,
        rating: 4.7,
        reviewCount: 289,
        priceRange: "$140-$260",
        description: "Friendly and affordable movers for homes and apartments.",
        city: "San Diego, CA",
        services: ["Family Moves", "Apartment Relocation", "Packing", "Loading Help"],
        isFeatured: false
    ),
    HomeMover(
        name: "Urban Move Co.",
        imageName: nil,
        rating: 4.6,
        reviewCount: 198,
        priceRange: "$160-$290",
        description: "Reliable local and long-distance moving with secure handling.",
        city: "Brooklyn, NY",
        services: ["Office Moves", "Apartment Moves", "Packing", "Storage Support"],
        isFeatured: false
    ),
    HomeMover(
        name: "Golden Route Movers",
        imageName: nil,
        rating: 4.5,
        reviewCount: 165,
        priceRange: "$120-$220",
        description: "Budget-friendly moving team with quick booking options.",
        city: "Sacramento, CA",
        services: ["Budget Moves", "Quick Booking", "Local Relocation", "Basic Packing"],
        isFeatured: false
    )
]

struct RoundedCorner: Shape {
    var radius: CGFloat = 20
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}