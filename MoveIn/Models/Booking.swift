//
//  Booking.swift
//  MoveIn
//
//  Created by Suthan Suresh on 2026-04-05.
//

import Foundation
import SwiftData

@Model
final class Booking{
    var userId: UUID
    var bookingId: UUID
    var moverId: UUID
    var moverName: String
    var City: String
    var hourlyRate: Double
    var movingDate: Date
    var movingStartTime: String
    var movingEndTime: String
    var startLocation: String
    var finalLocation: String
    var bookingStatus: String
    var createdAt: Date
    
    init(
        userId: UUID,
        bookingId: UUID = UUID(),
        moverId: UUID,
        moverName: String,
        City: String,
        hourlyRate: Double,
        movingDate: Date,
        movingStartTime: String,
        movingEndTime: String,
        startLocation: String,
        finalLocation: String,
        bookingStatus: String = "Pending",
        createdAt: Date = Date()
    ){
        self.userId = userId
        self.bookingId = bookingId
        self.moverId = moverId
        self.moverName = moverName
        self.City = City
        self.hourlyRate = hourlyRate
        self.movingDate = movingDate
        self.movingStartTime = movingStartTime
        self.movingEndTime = movingEndTime
        self.startLocation = startLocation
        self.finalLocation = finalLocation
        self.bookingStatus = bookingStatus
        self.createdAt = createdAt
    }
}
