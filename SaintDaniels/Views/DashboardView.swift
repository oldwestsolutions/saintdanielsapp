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
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Points Balance Card
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Points Balance")
                            .font(Theme.headingFont)
                        
                        Text("\(rewardPoints)")
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
                    
                    // Coverage Card
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Coverage Level")
                            .font(Theme.headingFont)
                        
                        Text("Premium Plus")
                            .font(.title2)
                            .foregroundColor(Theme.accentColor)
                        
                        VStack(spacing: 10) {
                            coverageRow(label: "Deductible", value: "$500")
                            coverageRow(label: "Co-pay", value: "$20")
                            coverageRow(label: "Out-of-pocket Max", value: "$2,000")
                        }
                    }
                    .padding()
                    .royalCardStyle()
                }
                .padding()
            }
            .background(Theme.backgroundColor)
            .navigationTitle("Welcome Back!")
        }
    }
    
    private func coverageRow(label: String, value: String) -> some View {
        HStack {
            Text(label)
                .font(Theme.bodyFont)
            Spacer()
            Text(value)
                .font(Theme.bodyFont)
                .foregroundColor(Theme.primaryColor)
        }
    }
}

struct ProfileView: View {
    @EnvironmentObject var authManager: AuthenticationManager
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Account Settings")) {
                    NavigationLink(destination: Text("Find a Doctor")) {
                        Label("Find a Doctor", systemImage: "stethoscope")
                    }
                    
                    NavigationLink(destination: Text("Contact Support")) {
                        Label("Contact Support", systemImage: "questionmark.circle")
                    }
                }
                
                Section {
                    Button(action: {
                        authManager.signOut()
                    }) {
                        Label("Sign Out", systemImage: "arrow.right.square")
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationTitle("Profile")
            .listStyle(InsetGroupedListStyle())
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
            .environmentObject(AuthenticationManager())
    }
} 