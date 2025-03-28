import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var authManager: AuthenticationManager
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(0)
            
            OffersView()
                .tabItem {
                    Image(systemName: "gift.fill")
                    Text("Offers")
                }
                .tag(1)
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
                .tag(2)
        }
    }
}

struct HomeView: View {
    @State private var rewardPoints = 1250
    @State private var recentActivities: [RewardActivity] = [
        RewardActivity(id: UUID(), date: Date(), points: 100, description: "Health Check-up", type: .earned),
        RewardActivity(id: UUID(), date: Date().addingTimeInterval(-7*24*60*60), points: 200, description: "Gift Card", type: .redeemed),
        RewardActivity(id: UUID(), date: Date().addingTimeInterval(-12*24*60*60), points: 150, description: "Dental Visit", type: .earned)
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    PointsBalanceCard(points: rewardPoints)
                    
                    RecentActivityCard(activities: recentActivities)
                    
                    CoverageCard(coverage: Coverage(
                        level: "Premium Plus",
                        activeUntil: Date().addingTimeInterval(180*24*60*60),
                        deductible: 500,
                        copay: 20,
                        outOfPocketMax: 2000
                    ))
                }
                .padding()
            }
            .background(Theme.backgroundColor)
            .navigationTitle("Welcome Back!")
            .navigationBarItems(trailing: Button(action: {
                // TODO: Implement sign out
            }) {
                Text("Logout")
                    .foregroundColor(Theme.accentColor)
            })
        }
    }
}

struct PointsBalanceCard: View {
    let points: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Points Balance")
                .font(Theme.headingFont)
            
            Text("\(points)")
                .font(.system(size: 48, weight: .bold))
                .foregroundColor(Theme.accentColor)
            
            Text("Available Rewards Points")
                .font(Theme.bodyFont)
                .foregroundColor(.gray)
            
            ProgressView(value: 0.75)
                .accentColor(Theme.accentColor)
            
            Text("Next tier: 500 points away")
                .font(Theme.bodyFont)
                .foregroundColor(.gray)
        }
        .padding()
        .royalCardStyle()
    }
}

struct RecentActivityCard: View {
    let activities: [RewardActivity]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Recent Activity")
                .font(Theme.headingFont)
            
            ForEach(activities) { activity in
                HStack {
                    VStack(alignment: .leading) {
                        Text(activity.description)
                            .font(Theme.bodyFont)
                        Text(activity.date, style: .date)
                            .font(Theme.bodyFont)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                    Text("\(activity.type == .earned ? "+" : "-")\(activity.points)")
                        .font(Theme.bodyFont)
                        .foregroundColor(activity.type == .earned ? .green : .red)
                }
                
                if activity.id != activities.last?.id {
                    Divider()
                }
            }
            
            Button(action: {
                // TODO: Implement view all activities
            }) {
                Text("VIEW ALL ACTIVITIES")
                    .frame(maxWidth: .infinity)
            }
            .royalButtonStyle()
        }
        .padding()
        .royalCardStyle()
    }
}

struct CoverageCard: View {
    let coverage: Coverage
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Coverage Level")
                .font(Theme.headingFont)
            
            Text(coverage.level)
                .font(.title2)
                .foregroundColor(Theme.accentColor)
            
            Text("Active until \(coverage.activeUntil, style: .date)")
                .font(Theme.bodyFont)
                .foregroundColor(.gray)
            
            VStack(spacing: 10) {
                CoverageDetailRow(label: "Deductible", value: coverage.deductible)
                CoverageDetailRow(label: "Co-pay", value: coverage.copay)
                CoverageDetailRow(label: "Out-of-pocket Max", value: coverage.outOfPocketMax)
            }
            
            Button(action: {
                // TODO: Implement view coverage details
            }) {
                Text("VIEW COVERAGE DETAILS")
                    .frame(maxWidth: .infinity)
            }
            .royalButtonStyle()
        }
        .padding()
        .royalCardStyle()
    }
}

struct CoverageDetailRow: View {
    let label: String
    let value: Double
    
    var body: some View {
        HStack {
            Text(label)
                .font(Theme.bodyFont)
            Spacer()
            Text("$\(Int(value))")
                .font(Theme.bodyFont)
                .foregroundColor(Theme.primaryColor)
        }
    }
} 