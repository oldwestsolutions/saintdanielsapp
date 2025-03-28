import SwiftUI

struct OffersView: View {
    @State private var offers = [
        Offer(id: UUID(), title: "$50 Gift Card", description: "Complete your annual physical", pointsCost: nil),
        Offer(id: UUID(), title: "Free Dental Cleaning", description: "Schedule within 30 days", pointsCost: nil),
        Offer(id: UUID(), title: "Vision Discount", description: "20% off eyewear", pointsCost: 500)
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(offers) { offer in
                        OfferCard(offer: offer)
                    }
                }
                .padding()
            }
            .background(Theme.backgroundColor)
            .navigationTitle("Available Offers")
        }
    }
}

struct OfferCard: View {
    let offer: Offer
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(offer.title)
                .font(Theme.headingFont)
            
            Text(offer.description)
                .font(Theme.bodyFont)
                .foregroundColor(.gray)
            
            if let points = offer.pointsCost {
                Text("\(points) points")
                    .font(Theme.bodyFont)
                    .foregroundColor(Theme.accentColor)
            }
            
            Button(action: {
                // TODO: Implement claim offer
            }) {
                Text("CLAIM")
                    .frame(maxWidth: .infinity)
            }
            .royalButtonStyle()
        }
        .padding()
        .royalCardStyle()
    }
}

struct OffersView_Previews: PreviewProvider {
    static var previews: some View {
        OffersView()
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
                    
                    NavigationLink(destination: Text("Account Settings")) {
                        Label("Account Settings", systemImage: "gear")
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