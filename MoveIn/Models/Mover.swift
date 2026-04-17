//
//  Mover.swift
//  MoveIn
//
//  Created by Suthan Suresh on 2026-04-05.
//

import Foundation
import SwiftData

@Model
final class Mover{
    var moverId: UUID
    var moverName: String
    var Image : String?
    var rating: Double
    var reviewCount: Int
    var hourlyRate: Double
    var moverDescription : String
    var city: String
    var services: [String] // ???????
    var isVerified: Bool
    var isFavorite: Bool
    var createdAt: Date
    
    init(
        moverId: UUID = UUID(),
        moverName: String,
        Image: String? = nil,
        rating: Double,
        reviewCount: Int,
        hourlyRate: Double,
        moverDescription: String,
        city: String,
        services: [String],
        isVerified: Bool,
        isFavorite: Bool = false,
        createdAt: Date = Date()
    ){
        self.moverId = moverId
        self.moverName = moverName
        self.Image = Image
        self.rating = rating
        self.reviewCount = reviewCount
        self.hourlyRate = hourlyRate
        self.moverDescription = moverDescription
        self.city = city
        self.services = services
        self.isVerified = isVerified
        self.isFavorite = isFavorite
        self.createdAt = createdAt
    }
}

