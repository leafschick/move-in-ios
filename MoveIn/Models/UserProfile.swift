//
//  UserProfile.swift
//  MoveIn
//
//  Created by Suthan Suresh on 2026-04-04.
//

import Foundation
import SwiftData

@Model
final class UserProfile{
    var userId: UUID
    var fullName: String
    var email: String
    var phoneNumber: String
    var password: String // ****
    var location: String
    var accountType: String
    var createdAt: Date
    
    init(
        userId: UUID = UUID(),
        fullName: String,
        email: String,
        phoneNumber: String,
        password: String,
        location: String = "Not Set", // *****
        accountType: String = "Move-In Customer", //*****
        createdAt: Date = Date()
    ) {
        self.userId = userId
        self.fullName = fullName
        self.email = email
        self.phoneNumber = phoneNumber
        self.password = password
        self.location = location
        self.accountType = accountType
        self.createdAt = createdAt
    }
}
