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

var didLaunchBefore: Bool {
    get {
        UserDefaults.standard.bool(forKey: "didLaunchBefore")
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "didLaunchBefore")
    }
}



struct ContentView: View {
    @State private var isShowingMainScreen = false
    @State private var isShowingLogin = false

    var body: some View {
        Group {
            if didLaunchBefore {
                         if isLoggedIn() {
                             if let userData = getUserDataFromUserDefaults() {
                                 MainScreen(email: userData["email"] as? String ?? "",
                                            username: userData["name"] as? String ?? "",
                                            language: userData["language"] as? String ?? "",country: userData["country"] as? String ?? "", phone: userData["phonenumber"] as? String ?? "", userID:  userData["id"] as? String ?? "")
                             } else {
                                 LoginScreen(isShowingLogin: $isShowingLogin)
                                     .onDisappear {
                                         if isLoggedIn() {
                                             isShowingMainScreen = true
                                         }
                                     }
                             }
                         } else {
                             LoginScreen(isShowingLogin: $isShowingLogin)
                                 .onDisappear {
                                     didLaunchBefore = true
                                     if isLoggedIn() {
                                         isShowingMainScreen = true
                                     }
                                 }
                         }
                     } else {
                         LoginScreen(isShowingLogin: $isShowingLogin)
                             .onDisappear {
                                 didLaunchBefore = true
                                 if isLoggedIn() {
                                     isShowingMainScreen = true
                                 }
                             }
                     }
                 }
                 .fullScreenCover(isPresented: $isShowingMainScreen) {
                     if let userData = getUserDataFromUserDefaults() {
                         MainScreen(email: userData["email"] as? String ?? "",
                                    username: userData["name"] as? String ?? "",
                                    language: userData["language"] as? String ?? "",
                                    country: userData["country"] as? String ?? "", phone: userData["phonenumber"] as? String ?? "", userID:  userData["id"] as? String ?? "")
                     } else {
                         MainScreen(email: "", username: "", language: "", country: "", phone: "", userID: "")
                     }
                 }
             }

    // Check if the user is logged in
    func isLoggedIn() -> Bool {
        // Add your logic to check if the user is logged in"
        // For example, check if the user session is still valid
        return /* Your logic to check if user is logged in */ true
    }
    
    func getUserDataFromUserDefaults() -> [String: Any]? {
            return UserDefaults.standard.dictionary(forKey: "userData")
        }
}
   
struct LoginScreen: View {
    @Binding var isShowingLogin: Bool
    @State private var isShowingMainScreen = false
    
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
            NavigationStack {
                 VStack {
                     GeometryReader { geometry in
                         Image("Screenshot 2024-01-02 at 4.16.52 PM (1)")
                            
                             .resizable()
                             .aspectRatio(contentMode: .fit)
                            // Adjust the height as needed
                             .frame(width: geometry.size.width, height:230)
                             .clipped()
                             .padding(.bottom, 20)
                     }
                    
                     .frame( height:230)
                     
//                     HStack(spacing: 0) {
//                         Text("A")
//                             .font(Font.custom("Baskerville-BoldItalic", size: 30))
//                             .foregroundColor(Color(UIColor(hex: 0x0bb9c0)))
//                
//                         Text("T")
//                             .font(Font.custom("Baskerville-Bold", size: 30))
//                             .foregroundColor(Color(UIColor(hex: 0x0bb9c0)))
//                            
//                    
//                         Text("Guide")
//                             .font(Font.custom("Baskerville-Bold", size: 30))
//                             .foregroundColor(Color(UIColor(hex: 0x313F54)))
//                            
//                     }
                     VStack {
                         ZStack {
                             RoundedRectangle(cornerRadius: 10)
                                 .stroke(Color(red: 85 / 255, green: 85 / 255, blue: 85 / 255), lineWidth: 1)
                                 .frame(height: 45)
                                 .padding(.horizontal ,15)
                                 .padding(.vertical ,1)
                                 .background(Color.clear)
                                
                             
                             TextField("E-mail", text: $username)
                                 .textFieldStyle(PlainTextFieldStyle()) // Remove the rounded border
                                 .keyboardType(.emailAddress)
                                 .padding(.horizontal, 25)
                                 .background(Color.clear) // Set background to clear
                         }
                         
                         ZStack{
                             RoundedRectangle(cornerRadius: 10)
                                 .stroke(Color(red: 85 / 255, green: 85 / 255, blue: 85 / 255), lineWidth: 1)
                                 .frame(height: 45)
                                 .padding(.horizontal ,15)
                                 .padding(.vertical ,10)
                                 .background(Color.clear)
                                
                             
                          
                            
                             SecureField("Password", text: $password)
                                 .textFieldStyle(PlainTextFieldStyle()) // Remove the rounded border style
                                 
                                 .padding(.horizontal, 25)
                                 .background(Color.clear) // Set background to clear
                                
                         }
                         
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
                                               .background(Color(red: 0.043, green: 0.725, blue: 0.753))
                                               .cornerRadius(10)
                                       }
                                       .padding(.top, 30)
                                       .padding(.horizontal, 14)
                                       .navigationDestination(
                                            isPresented: $signUp) {
                                                SignUp()
                                            }
                                       .navigationDestination(
                                            isPresented: $isShowingNewView) {
                                               MainScreen(email: userData?.email ?? "", username: userData?.name ?? "", language: userData?.language ?? "" ,country: userData?.country ?? "", phone: userData?.phonenumber ?? "", userID: userData?.id ?? "")
                                            }
                     
                                       .alert(isPresented: $showAlert) {
                                           Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                                       }
                    
                
                    
                    Button(action: {
                      
                        signUp = true
                    }
                    
                    ) {
                        Text("Sign Up")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color(red: 0.192, green: 0.259, blue: 0.333) )
                     //   #c65b25
                            .cornerRadius(10)
                           
                    }
                    .padding(.top,10)
                    .padding(.horizontal,14)
                     
                     Button(action: {
                                            resetPassword = true
                                        }) {
                                            Text("Forgot Password?")
                                                .foregroundColor(Color(red: 0.722, green: 0.275, blue: 0.114))
                                                .padding(.top, 8)
                                        }
                                        .sheet(isPresented: $resetPassword) {
                                            PasswordResetView()
                                        }
                }
                 .background(Image("IMG_20240104_181119 (2)").resizable().scaledToFill().clipped().edgesIgnoringSafeArea([.all]).opacity(0.5))
            }
            
        }
       
    }
    
    private func saveUserDataLocally(user: User) {
        let userDataDict: [String: Any] = [
            "id": user.id,
            "name": user.name,
            "email": user.email,
            "phonenumber": user.phonenumber,
            "country": user.country,
            "language": user.language
            // Add other properties as needed
        ]

        UserDefaults.standard.set(userDataDict, forKey: "userData")
    }

    
    private func fetchUserData(uid: String) {
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(uid)

        userRef.getDocument { document, error in
            if let document = document, document.exists {
                if let data = document.data() {
                    let name = data["name"] as? String ?? ""
                    let email = data["email"] as? String ?? ""
                    let phonenumber = data["phonenumber"] as? String ?? ""
                    let country = data["country"] as? String ?? ""
                    let language = data["language"] as? String ?? ""
                    

                    // Create the User object
                    let user = User(id: uid, name: name, email: email, password: password, phonenumber: phonenumber, country: country, language: language)
                    
                    // Save user data locally
                    saveUserDataLocally(user: user)

                    // Assign fetched data to userData
                    self.userData = user
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
                .foregroundColor(Color(UIColor(hex: 0x313F54)))
                .padding()

            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 25)
                .padding(.bottom, 20)
                .keyboardType(.emailAddress)
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
                    .background(Color(red: 0.192, green: 0.259, blue: 0.333))
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
