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
    @State private var passTextToast = ""
    @State private var isLoading = false
    @State private var isNavigate = false
    
    
    
    @State var firstname = ""
    @State var email = ""
    @State var phonenumber = ""
    @State var country = ""
    @State var language = ""
    @State var password = ""
    @State var confirmPassword = ""
    @State private var userID: String = ""
    
    
    private var foods = ["Cheese","Milk","Cauliflower","Cabbage","Carrots","Wine","Bacon","Olives","Yoghurt","Apples","Bananas","Oranges","Pasta","Rice","Soy Sauce",
                            "Chicken","Chives","Potato","Sparkling Water","Coffee"]
       @State private var searchText = ""
 //   @StateObject var viewModel = WriteViewModel()
    
    
    var searchResults: [String] {
           if searchText.isEmpty {
               return foods
           } else {
               return foods.filter { $0.contains(searchText) }
           }
       }
    
    var body: some View {
        VStack(alignment: .center) {
            
            
            VStack(alignment: .center) {
                Text("Your Information")
                    .font(.system(size: 27))
                    .foregroundColor(Color(UIColor(hex: 0x313F54)))
                    .bold()
                    .padding(.bottom,20)
                   
                VStack (alignment: .center){
                    ScrollView {
                        
                        ZStack{
                            
                            RoundedRectangle(cornerRadius: 10
                            ).stroke(Color(red: 85 / 255, green: 85 / 255, blue: 85 / 255), lineWidth: 1)
                                .frame(height: 45)
                                .padding(.horizontal ,15 )
                                .padding(.vertical ,6 )
                                .backgroundStyle(Color.clear)
                                .foregroundColor(.white)
                            
                            TextField("Name ", text: $firstname)
                                .textFieldStyle(PlainTextFieldStyle())
                                .padding(.horizontal, 25)
                                .background(.clear)
                            
                        }
                        
                         
                        
                        ZStack {
                                                RoundedRectangle(cornerRadius: 10)
                                                    .stroke(Color(red: 85 / 255, green: 85 / 255, blue: 85 / 255), lineWidth: 1)
                                                    .frame(height: 45)
                                                    .padding(.horizontal, 15)
                                                    .padding(.vertical, 6)
                                                    .backgroundStyle(Color.clear)                                                    .foregroundColor(.white)

                                                TextField("E-mail", text: $email)
                                .textFieldStyle(PlainTextFieldStyle())
                                .padding(.horizontal, 25)
                                .background(.clear)
                                .keyboardType(.emailAddress)
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
                                .backgroundStyle(Color.clear)
                                .foregroundColor(.white)
                            
                            TextField("phone", text: $phonenumber)
                                .textFieldStyle(PlainTextFieldStyle())
                                .padding(.horizontal, 25)
                                .background(.clear)
                                .keyboardType(.numberPad)
                        }
                        ZStack{
                            
                            RoundedRectangle(cornerRadius: 10
                            ).stroke(Color(red: 85 / 255, green: 85 / 255, blue: 85 / 255), lineWidth: 1)
                                .frame(height: 45)
                                .padding(.horizontal ,15 )
                                .padding(.vertical ,6 )
                                .backgroundStyle(Color.clear)
                                .foregroundColor(.white)
                            
                            TextField("Country", text: $country)
                                .textFieldStyle(PlainTextFieldStyle())
                                .padding(.horizontal, 25)
                                .background(.clear)
                        }
                        
                        ZStack{
                            
                            RoundedRectangle(cornerRadius: 10
                            ).stroke(Color(red: 85 / 255, green: 85 / 255, blue: 85 / 255), lineWidth: 1)
                                .frame(height: 45)
                                .padding(.horizontal ,15 )
                                .padding(.vertical ,6 )
                                .backgroundStyle(Color.clear)
                                .foregroundColor(.white)
                            
                            TextField("Language", text: $language)
                                .textFieldStyle(PlainTextFieldStyle())
                                .padding(.horizontal, 25)
                                .background(.clear)
                        }
//                            NavigationView{
//                                           
//                                           List {
//                                               ForEach(searchResults, id: \.self) { food in
//                                                   Text(food)
//                                               }
//                                               
//                                               }.searchable(text: $searchText)
//                                   
//                                       }
//                            .frame(height: 150)
//                            .ignoresSafeArea()
                        VStack(alignment: .leading){
                            ZStack{
                                
                                RoundedRectangle(cornerRadius: 10
                                ).stroke(Color(red: 85 / 255, green: 85 / 255, blue: 85 / 255), lineWidth: 1)
                                    .frame(height: 45)
                                    .padding(.horizontal ,15 )
                                    .padding(.vertical ,6)
                                    .backgroundStyle(Color.clear)
                                    .foregroundColor(.white)
                                
                                TextField("password", text: $password)
                                    .textFieldStyle(PlainTextFieldStyle())
                                    .padding(.horizontal, 25)
                                    .background(.clear)
                                
                                
                            }
                            
//                            Text(passTextToast).foregroundColor(.red)
//                                .onAppear(perform: {
//                                    validateData()
//                                })
//                                .padding(.leading,14)
                        }
                        ZStack{
                            
                            RoundedRectangle(cornerRadius: 10
                            ).stroke(Color(red: 85 / 255, green: 85 / 255, blue: 85 / 255), lineWidth: 1)
                                .frame(height: 45)
                                .padding(.horizontal ,15 )
                                .padding(.vertical ,6)
                                .backgroundStyle(Color.clear)
                                .foregroundColor(.white)
                            
                            TextField("confirm password", text: $confirmPassword)
                                .textFieldStyle(PlainTextFieldStyle())
                                .padding(.horizontal, 25)
                                .background(.clear)
                            
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
                                            userID = authResult.user.uid // Capture user ID here
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
                    .padding(.bottom, 0)
                    .padding(.horizontal, 15)
                    .navigationDestination(isPresented: $isNavigate) {
                        MainScreen(email: email, username: firstname, language:language, country:country, phone: phonenumber, userID: userID)
                    }
                    //                .' '#' '$' '[' or ']
                    
                    
                }
                
                
                .modifier(ToastModifier(showToast: $showToast, toastText: toastText))
            }
            
            
            
            
        } .padding()
            .background(Image("IMG_20240104_181119 (2)").resizable().scaledToFill().clipped().edgesIgnoringSafeArea([.all]).opacity(0.5))

            
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

        
        if password.count < 8 {
               showToast = true
               toastText = "Password must be at least 8 characters long"
            passTextToast = "Password must be at least 8 characters long"
               return false
           }

           // Check for uppercase and lowercase characters
           if !password.contains(where: { $0.isUppercase }) || !password.contains(where: { $0.isLowercase }) {
               showToast = true
               toastText = "Password must contain both uppercase and lowercase characters"
               passTextToast = "Password must contain both uppercase and lowercase characters"
               return false
           }

           // Check for at least one numeric digit
           if !password.contains(where: { $0.isNumber }) {
               showToast = true
               toastText = "Password must contain at least one numeric digit"
               passTextToast = "Password must contain at least one numeric digit"

               return false
           }

           // Check for special characters
           let specialCharacterRegex = ".*[^A-Za-z0-9].*"
           if !NSPredicate(format: "SELF MATCHES %@", specialCharacterRegex).evaluate(with: password) {
               showToast = true
               toastText = "Password must contain at least one special character"
               passTextToast = "Password must contain at least one special character"

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
   
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        HStack {
            TextField("Search", text: $text)
                .padding(8)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 10)
        }
    }
}

struct FormScreen_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
        
    }
}

