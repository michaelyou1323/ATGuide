import SwiftUI
import AVFoundation
import Firebase

struct VideoThumbnailView: View {
    let videoURL: URL
    
    @State private var thumbnailImage: UIImage? = nil
    
    var body: some View {
        if let image = thumbnailImage {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
        } else {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .onAppear {
                    generateThumbnail()
                }
        }
    }
    
    func generateThumbnail() {
        let asset = AVURLAsset(url: videoURL)
        let generator = AVAssetImageGenerator(asset: asset)
        generator.appliesPreferredTrackTransform = true
        
        let time = CMTimeMake(value: 1, timescale: 60)
        generator.generateCGImagesAsynchronously(forTimes: [NSValue(time: time)]) { _, image, _, _, _ in
            if let image = image {
                DispatchQueue.main.async {
                    self.thumbnailImage = UIImage(cgImage: image)
                }
            }
        }
    }
}


struct ToastModifier: ViewModifier {
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


struct SignUp: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var showToast = false
    @State private var toastText = ""
    @State private var isLoading = false
    @State private var isNavigate = false
    
    
    
    @State var firstname = ""
    @State var email = ""
    @State var phonenumber = ""
    @State var country = ""
    @State var language = ""
    @State var password = ""
    @State var confirmPassword = ""

    
 //   @StateObject var viewModel = WriteViewModel()
    
    var body: some View {
        VStack(alignment: .center) {
            
            
            VStack(alignment: .center) {
                Text("Your Information")
                    .font(.system(size: 27))
                    .foregroundColor(Color(UIColor(hex: 0x313F54)))
                    .bold()
                    .padding(.bottom,40)
                    .padding(.top,15)
                VStack (alignment: .center){
                    ScrollView {
                        
                        ZStack{
                            
                            RoundedRectangle(cornerRadius: 10
                            ).stroke(Color(red: 85 / 255, green: 85 / 255, blue: 85 / 255), lineWidth: 1)
                                .frame(height: 45)
                                .padding(.horizontal ,15 )
                                .padding(.vertical ,6 )
                                .backgroundStyle(Color(.white))
                                .foregroundColor(.white)
                            
                            TextField("Name ", text: $firstname)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.horizontal, 25)
                            
                        }
                        
                        
                        
                        ZStack {
                                                RoundedRectangle(cornerRadius: 10)
                                                    .stroke(Color(red: 85 / 255, green: 85 / 255, blue: 85 / 255), lineWidth: 1)
                                                    .frame(height: 45)
                                                    .padding(.horizontal, 15)
                                                    .padding(.vertical, 6)
                                                    .backgroundStyle(Color(.white))
                                                    .foregroundColor(.white)

                                                TextField("E-mail", text: $email)
                                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                                    .padding(.horizontal, 25)
//                                                    .onChange(of: email) { newEmail in
//                                                        validateEmail(newEmail)
//                                                    }
                        }
                        ZStack{
                            
                            RoundedRectangle(cornerRadius: 10
                            ).stroke(Color(red: 85 / 255, green: 85 / 255, blue: 85 / 255), lineWidth: 1)
                                .frame(height: 45)
                                .padding(.horizontal ,15 )
                                .padding(.vertical ,6 )
                                .backgroundStyle(Color(.white))
                                .foregroundColor(.white)
                            
                            TextField("phone", text: $phonenumber)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.horizontal, 25)
                            
                        }
                        ZStack{
                            
                            RoundedRectangle(cornerRadius: 10
                            ).stroke(Color(red: 85 / 255, green: 85 / 255, blue: 85 / 255), lineWidth: 1)
                                .frame(height: 45)
                                .padding(.horizontal ,15 )
                                .padding(.vertical ,6 )
                                .backgroundStyle(Color(.white))
                                .foregroundColor(.white)
                            
                            TextField("Country", text: $country)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.horizontal, 25)
                            
                        }
                        ZStack{
                            
                            RoundedRectangle(cornerRadius: 10
                            ).stroke(Color(red: 85 / 255, green: 85 / 255, blue: 85 / 255), lineWidth: 1)
                                .frame(height: 45)
                                .padding(.horizontal ,15 )
                                .padding(.vertical ,6 )
                                .backgroundStyle(Color(.white))
                                .foregroundColor(.white)
                            
                            TextField("language", text: $language)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.horizontal, 25)
                            
                        }
                        ZStack{
                            
                            RoundedRectangle(cornerRadius: 10
                            ).stroke(Color(red: 85 / 255, green: 85 / 255, blue: 85 / 255), lineWidth: 1)
                                .frame(height: 45)
                                .padding(.horizontal ,15 )
                                .padding(.vertical ,6)
                                .backgroundStyle(Color(.white))
                                .foregroundColor(.white)
                            
                            TextField("password", text: $password)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.horizontal, 25)
                            
                        }
                        ZStack{
                            
                            RoundedRectangle(cornerRadius: 10
                            ).stroke(Color(red: 85 / 255, green: 85 / 255, blue: 85 / 255), lineWidth: 1)
                                .frame(height: 45)
                                .padding(.horizontal ,15 )
                                .padding(.vertical ,6)
                                .backgroundStyle(Color(.white))
                                .foregroundColor(.white)
                            
                            TextField("confirm password", text: $confirmPassword)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.horizontal, 25)
                            
                        }
                        
                        NavigationLink(destination: MainScreen(email: email, username: firstname, language:language, country:country), isActive: $isNavigate) {
                                            EmptyView()
                                        }
                     
                        
                    }
                    
                    
                    

                    Button(action: {
                                if validateData() {
                                    isLoading = true // Start loading animation
                                    showToast = true
                                    toastText = "Signing up, please wait..."

                                    // Perform sign-up logic here
                                    Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                                        if let error = error {
                                            isLoading = false
                                            showToast = true
                                            toastText = "Error: \(error.localizedDescription)"
                                        } else if let authResult = authResult {
                                            let newUser = User(id: authResult.user.uid, name: firstname, email: email, password: password , phonenumber: phonenumber, country: country, language: language )
                                            saveUserData(user: newUser) // Save user data to Firebase
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {
                                                isLoading = false
                                                isNavigate = true
                                            }
                                        }
                                    }
                                }
                            }) {
                                         if isLoading {
                                             ProgressView() // Show loading animation
                                         } else {
                            Text("Sign Up")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .foregroundColor(.white)
                                .background(Color(red: 0.192, green: 0.259, blue: 0.333))
                                .cornerRadius(10)
                        }
                    }
                    .disabled(isLoading) // Disable button while loading
                    .padding(.bottom, 60)
                    .padding(.horizontal, 15)
                                         
                    //                .' '#' '$' '[' or ']
                    
                    
                }
                
                
                .modifier(ToastModifier(showToast: $showToast, toastText: toastText))
            }
            
            
            
            
        } .padding()
            .background(Color.white)
            
            .onAppear {
                // Additional setup on appearance
            }
    }
       
        
    
    func saveUserData(user: User) {
           let db = Firestore.firestore()
        let userRef = db.collection("users").document(user.id)

           userRef.setData([
               "name": user.name,
               "email": user.email,
                
               "phonenumber" : phonenumber,
               "country" : country,
               "language" : language,
            
                 
           ]) { error in
               if let error = error {
                   print("Error adding user data: \(error.localizedDescription)")
               } else {
                   print("User data added for \(user.id)")
               }
           }
       }

    
    private func validateData() -> Bool {
        if firstname.isEmpty || firstname.contains(".") || firstname.contains("#") || firstname.contains("$") || firstname.contains("[") || firstname.contains("]") || firstname.contains(" ") {
            showToast = true
            toastText = "Please enter your name"
            return false
        } else if !isValidEmail(email) {
            showToast = true
            toastText = "Please enter a valid email address"
            return false
        } else if phonenumber.isEmpty || phonenumber.contains(".") || phonenumber.contains("#") || phonenumber.contains("$") || phonenumber.contains("[") || phonenumber.contains("]") || phonenumber.contains(" ") {
            showToast = true
            toastText = "Please enter your phone"
            return false
        } else if country.isEmpty || country.contains(" ") {
            showToast = true
            toastText = "Please enter your country"
            return false
        } else if language.isEmpty || language.contains(" ") {
            showToast = true
            toastText = "Please enter your language"
            return false
        } else if password.isEmpty || password.contains(" ") {
            showToast = true
            toastText = "Please enter a valid password"
            return false
        } else if confirmPassword.isEmpty || confirmPassword != password {
            showToast = true
            toastText = "Passwords must match"
            return false
        }

        return true
    }

    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
}
   


struct FormScreen_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
        
    }
}

