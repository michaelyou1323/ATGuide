import SwiftUI

struct ContentView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isShowingNewView = false
    @State private var presentSideMenu = false

    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    TextField("Username", text: $username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    SecureField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    Button(action: {
                        // Perform login action
                        
                        isShowingNewView = true
                        login()
                    }) {
                        NavigationLink(destination: MainScreen()) {
                            Text("Login")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                        
                        .padding()
                    }
                    Button(action: {
                        // Perform signup action
                        signUp()
                    }) {
                        Text("Sign Up")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.green)
                            .cornerRadius(10)
                    }
                    .padding()
                }
              
            }
            
        }
        .background(Color.black.opacity(0.05))
    }
    
    func login() {
        // Perform login functionality
        
    }
    
    func signUp() {
        print("Sign Up tapped with username: \(username) and password: \(password)")
    }
}


struct ContentView_Previews1 : PreviewProvider {
    static var previews : some View{
        ContentView()
    }
}
