import SwiftUI

@main
struct SaintDanielsApp: App {
    @StateObject private var authManager = AuthenticationManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authManager)
        }
    }
}

class AuthenticationManager: ObservableObject {
    @Published var isAuthenticated = false
    @Published var currentUser: User?
    
    func signIn(email: String, password: String) {
        // TODO: Implement actual authentication
        isAuthenticated = true
        currentUser = User(firstName: "John", lastName: "Doe", email: email)
    }
    
    func signOut() {
        isAuthenticated = false
        currentUser = nil
    }
} 