//
//  SeedData.swift
//  MoveIn
//
//  Created by Suthan Suresh on 2026-04-09.
//

import Foundation
import SwiftData

enum SeedData {
    static func seedMoversIfNeeded(modelContext: ModelContext) {
        let descriptor = FetchDescriptor<Mover>()
        
        do{
            let existingMovers = try modelContext.fetch(descriptor)
            
            if !existingMovers.isEmpty{
                return
            }
            
            let movers = [
                Mover(
                    moverName: "Swift Movers",
                    Image: nil,
                    rating: 4.8,
                    reviewCount: 250,
                    hourlyRate: 125.00,
                    moverDescription: "Professional moving services with over 10+ years of experience.",
                    city: "Toronto",
                    services: ["Long Distance moving", "Packing assistance"],
                    isVerified: true
                ),
                
                Mover(
                    moverName: "EasyMove Pro",
                    Image: nil,
                    rating: 4.9,
                    reviewCount: 456,
                    hourlyRate: 180.00,
                    moverDescription: "Premium moving service with insurance coverage included.",
                    city: "Toronto",
                    services: ["Local Moving", "Packing Service", "Furniture Protection"],
                    isVerified: true
                ),
                
                Mover(
                    moverName: "Family Movers Co",
                    Image: nil,
                    rating: 4.7,
                    reviewCount: 289,
                    hourlyRate: 140.00,
                    moverDescription: "Friendly and affordable movers for homes and apartments.",
                    city: "Hamilton",
                    services: ["Family Moves", "Apartment Relocation", "Packing", "Loading Help"],
                    isVerified: false
                ),

                Mover(
                    moverName: "Urban Move Co.",
                    Image: nil,
                    rating: 4.6,
                    reviewCount: 198,
                    hourlyRate: 160.00,
                    moverDescription: "Reliable local and long-distance moving with secure handling.",
                    city: "Kitchener",
                    services: ["Office Moves", "Apartment Moves", "Packing", "Storage Support"],
                    isVerified: false
                ),
                
                Mover(
                    moverName: "Golden Route Movers",
                    Image: nil,
                    rating: 4.5,
                    reviewCount: 165,
                    hourlyRate: 120.00,
                    moverDescription: "Budget-friendly moving team with quick booking options.",
                    city: "Vaughan",
                    services: ["Budget Moves", "Quick Booking", "Local Relocation", "Basic Packing"],
                    isVerified: true
                ),
                Mover(
                    moverName: "Prime Relocation",
                    Image: nil,
                    rating: 4.8,
                    reviewCount: 321,
                    hourlyRate: 200.00,
                    moverDescription: "Trusted relocation specialists for large and complex moves.",
                    city: "Brampton",
                    services: ["Large Moves", "Commercial Moving", "Packing", "Special Item Handling"],
                    isVerified: true
                ),
            ]
            
            for mover in movers{
                modelContext.insert(mover)
            }
            
            try modelContext.save()
            print("Movers successfully seeded!")
        }catch{
            print("Movers seed failed: \(error)")
        }
    }
}
