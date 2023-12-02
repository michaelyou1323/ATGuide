import SwiftUI
import Firebase


struct ToastModifier1: ViewModifier {
    @Binding var showToast: Bool
    let toastText: String

    func body(content: Content) -> some View {
        ZStack {
            content

            if showToast {
                VStack {
                    Text(toastText)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.gray)
                        .cornerRadius(15)
                        .padding()
                }
                .transition(.asymmetric(insertion: .slide, removal: .slide))
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation {
                            showToast = false
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center) // Set frame alignment to top
            }
        }
    }
}



struct ContentView: View {
    @State private var username: String = ""
      @State private var password: String = ""
      @State private var isShowingNewView = false
      @State private var showToast = false
      @State private var toastText = ""
      @State private var showAlert = false
      @State private var alertMessage = ""
      @State private var signUp = false
    @State private var resetPassword = false
    @State private var userData: User? // Add state to hold user data

    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    ZStack{
                        
                        RoundedRectangle(cornerRadius: 10
                                           ).stroke(Color(red: 85 / 255, green: 85 / 255, blue: 85 / 255), lineWidth: 1)
                                               .frame(height: 45)
                                               .padding(.horizontal ,15 )
                                               .padding(.vertical ,1 )
                                               .backgroundStyle(Color(.white))
                                               .foregroundColor(.white)
                        
                        TextField("Username", text: $username)
                                               .textFieldStyle(RoundedBorderTextFieldStyle())
                                               .padding(.horizontal, 25)
                        
                    }

                    ZStack{
                        
                        RoundedRectangle(cornerRadius: 10
                                           ).stroke(Color(red: 85 / 255, green: 85 / 255, blue: 85 / 255), lineWidth: 1)
                                               .frame(height: 45)
                                               .padding(.horizontal ,15 )
                                               .padding(.vertical ,10 )
                                               .backgroundStyle(Color(.white))
                                               .foregroundColor(.white)
                        
                        SecureField("Password", text: $password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal, 25)
                    }
                    
                    
                   
                    
                    NavigationLink(destination: MainScreen(email: userData?.email ?? "", username: userData?.name ?? "", language: userData?.language ?? "" ,country: userData?.country ?? ""), isActive: $isShowingNewView) {
                                        EmptyView()
                                    }
                    NavigationLink(destination: SignUp(), isActive: $signUp ) {
                                        EmptyView()
                                    }
                    Button(action: {
                                      Auth.auth().signIn(withEmail: username, password: password) { result, error in
                                          if let error = error {
                                              showAlert(message: error.localizedDescription)
                                          } else if let authResult = result {
                                              isShowingNewView = true
                                              fetchUserData(uid: authResult.user.uid) // Fetch user data after successful login
                                          }
                                      }
                                  }) {
                                           Text("Login")
                                               .frame(maxWidth: .infinity)
                                               .padding()
                                               .foregroundColor(.white)
                                               .background(Color.blue)
                                               .cornerRadius(10)
                                       }
                                       .padding(.top, 30)
                                       .padding(.horizontal, 14)
                                       .alert(isPresented: $showAlert) {
                                           Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                                       }
                    
                    Button(action: {
                                           resetPassword = true
                                       }) {
                                           Text("Forgot Password?")
                                               .foregroundColor(.blue)
                                               .padding(.top, 8)
                                       }
                                       .sheet(isPresented: $resetPassword) {
                                           PasswordResetView()
                                       }
                    
                    Button(action: {
                      
                        signUp = true
                    }
                    
                    ) {
                        Text("Sign Up")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.green)
                            .cornerRadius(10)
                           
                    }
                    .padding(.top,10)
                    .padding(.horizontal,14)
                }
                
            }
            
        }
        .background(Color.black.opacity(0.05))
    }
    
    private func fetchUserData(uid: String) {
          let db = Firestore.firestore()
          let userRef = db.collection("users").document(uid)

          userRef.getDocument { document, error in
              if let document = document, document.exists {
                  if let data = document.data() {
                      // Assuming User model has 'name' and 'email' properties
                      let name = data["name"] as? String ?? ""
                      let email = data["email"] as? String ?? ""
                      let phonenumber = data["phonenumber"] as? String ?? ""
                      let country = data["country"] as? String ?? ""
                      let language = data["language"] as? String ?? ""
                   
                      // Fetch other user data properties similarly

                      // Assign fetched data to userData
                      self.userData = User(id: uid, name: name, email: email, password: password,phonenumber: phonenumber,country: country,language: language )
                  }
              } else {
                  print("User document does not exist")
              }
          }
      }
    
    private func showAlert(message: String) {
           alertMessage = message
           showAlert = true
       }
}
   

struct PasswordResetView: View {
    @State private var email: String = ""
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        VStack {
            Text("Reset Password")
                .font(.title)
                .padding()

            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 25)
                .padding(.bottom, 20)

            Button(action: {
                Auth.auth().sendPasswordReset(withEmail: email) { error in
                    if let error = error {
                        alertMessage = error.localizedDescription
                        showAlert = true
                    } else {
                        alertMessage = "Password reset email sent. Check your email."
                        showAlert = true
                    }
                }
            }) {
                Text("Reset Password")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.bottom, 30)
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Password Reset"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
        .padding()
    }
}

struct ContentView_Previews1 : PreviewProvider {
    static var previews : some View{
        ContentView()
    }
}

// Added a new struct for the main screen view
