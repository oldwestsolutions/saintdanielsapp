import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authManager: AuthenticationManager
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Image(systemName: "shield.checkered")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .foregroundColor(Theme.accentColor)
                
                Text("Saint Daniels")
                    .font(Theme.titleFont)
                    .foregroundColor(Theme.primaryColor)
                
                Text("Royal Healthcare")
                    .font(Theme.headingFont)
                    .foregroundColor(Theme.accentColor)
                
                if authManager.isAuthenticated {
                    DashboardView()
                } else {
                    Button(action: {
                        authManager.signIn(email: "demo@example.com", password: "password")
                    }) {
                        Text("Sign In")
                            .frame(maxWidth: .infinity)
                    }
                    .royalButtonStyle()
                    .padding(.horizontal)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Theme.backgroundColor)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview("Content View - Signed Out") {
    ContentView()
        .environmentObject(AuthenticationManager())
}

#Preview("Content View - Signed In") {
    let authManager = AuthenticationManager()
    authManager.signIn(email: "demo@example.com", password: "password")
    
    return ContentView()
        .environmentObject(authManager)
}

struct AuthenticationView: View {
    @State private var isShowingLogin = true
    
    var body: some View {
        NavigationView {
            VStack {
                Image("SaintDanielsLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                
                Text("ROYAL HEALTHCARE")
                    .font(Theme.titleFont)
                    .foregroundColor(Theme.primaryColor)
                    .padding(.bottom, 30)
                
                if isShowingLogin {
                    LoginView()
                } else {
                    SignUpView()
                }
                
                Button(action: {
                    withAnimation {
                        isShowingLogin.toggle()
                    }
                }) {
                    Text(isShowingLogin ? "Don't have an account? Sign up" : "Already have an account? Login")
                        .font(Theme.bodyFont)
                        .foregroundColor(Theme.accentColor)
                }
                .padding()
            }
            .padding()
            .background(Theme.backgroundColor)
        }
    }
}

struct LoginView: View {
    @EnvironmentObject var authManager: AuthenticationManager
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        VStack(spacing: 20) {
            TextField("Email address", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button(action: {
                authManager.signIn(email: email, password: password)
            }) {
                Text("SIGN IN")
                    .frame(maxWidth: .infinity)
            }
            .royalButtonStyle()
        }
    }
}

struct SignUpView: View {
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                TextField("First Name", text: $firstName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Last Name", text: $lastName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Email Address", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                
                TextField("Phone Number", text: $phone)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.phonePad)
                
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                SecureField("Confirm Password", text: $confirmPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: {
                    // TODO: Implement sign up
                }) {
                    Text("CREATE YOUR ROYAL ACCOUNT")
                        .frame(maxWidth: .infinity)
                }
                .royalButtonStyle()
            }
        }
    }
} 