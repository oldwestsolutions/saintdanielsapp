import Foundation

struct User: Codable, Identifiable {
    let id: UUID
    let firstName: String
    let lastName: String
    let email: String
    var phoneNumber: String?
    
    init(id: UUID = UUID(), firstName: String, lastName: String, email: String, phoneNumber: String? = nil) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.phoneNumber = phoneNumber
    }
}

struct Coverage: Codable {
    let level: String
    let activeUntil: Date
    let deductible: Double
    let copay: Double
    let outOfPocketMax: Double
}

struct RewardActivity: Identifiable {
    let id: UUID
    let date: Date
    let points: Int
    let description: String
    let type: ActivityType
    
    enum ActivityType: String {
        case earned = "Earned"
        case redeemed = "Redeemed"
    }
}

struct Offer: Identifiable {
    let id: UUID
    let title: String
    let description: String
    let pointsCost: Int?
} 