import SwiftUI
import AVFoundation

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
                        
                        ZStack{
                            
                            RoundedRectangle(cornerRadius: 10
                            ).stroke(Color(red: 85 / 255, green: 85 / 255, blue: 85 / 255), lineWidth: 1)
                                .frame(height: 45)
                                .padding(.horizontal ,15 )
                                .padding(.vertical ,6)
                                .backgroundStyle(Color(.white))
                                .foregroundColor(.white)
                            
                            TextField("E-mail", text: $email)
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
                        
                        NavigationLink(destination: MainScreen(email: email, username: firstname), isActive: $isNavigate) {
                                            EmptyView()
                                        }
                     
                        
                    }
                    
                    
                    
                                         Button(action: {
                                             if firstname.isEmpty || firstname.contains(".") || firstname.contains("#") || firstname.contains("$") || firstname.contains("[") || firstname.contains("]") || firstname.contains(" "){
                                                 showToast = true
                                                 toastText = " Please Enter your name "
                                             }else if email.isEmpty || email.contains(" "){
                                                 showToast = true
                                                 toastText = "Please Enter your E-mail "
                                             }else if phonenumber.isEmpty || phonenumber.contains(".") || phonenumber.contains("#") || phonenumber.contains("$") || phonenumber.contains("[") || phonenumber.contains("]") || phonenumber.contains(" ") {
                                                 showToast = true
                                                 toastText = " Please Enter your Phone "
                                             }else if country.isEmpty || country.contains(" ") {
                                                 showToast = true
                                                 toastText = " Please Enter your Country "
                                             }else if language.isEmpty || language.contains(" ") {
                                                 showToast = true
                                                 toastText = "Please Enter your Language "
                                             }else if password.isEmpty || password.contains(" ") {
                                                 showToast = true
                                                 toastText = "Please Enter valid Password  "
                                             }else if confirmPassword.isEmpty || confirmPassword.contains(" ") {
                                                 showToast = true
                                                 toastText = "Passwords must be idintical "
                                             } else {
                                                 
                                                 isLoading = true // Start loading animation
                                                 showToast = true
                                                 
                                                 //                                               viewModel.pushObject(firstname: firstname, lastname: lastname, phonenumber: phonenumber, country: country, city: city, region: region, church: church, email: email)
                                                 
                                                 toastText = " تم تسجيل بياناتك ٫ سنقوم بالتواصل معك ..."
                                                 
                                                 
                                                 DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {
                                                     isLoading = false 
                                                     // Stop loading animation after 3 seconds
                                                     isNavigate = true
                                                     
                                                     
                                                     
                                                     //                                                  isLoading = false // Stop loading animation after 3 seconds
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
                                                     .background(Color.green)
                                                     .cornerRadius(10)
                                             }
                                         }
                                         .disabled(isLoading) // Disable button while loading
                                         .padding(.bottom,60)
                                         .padding(.horizontal,15)
                    
                                         
                    //                .' '#' '$' '[' or ']
                    
                    
                }
                
                .modifier(ToastModifier(showToast: $showToast, toastText: toastText))
            }
            
            
        }
    }
        
        
}
   


struct FormScreen_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
        
    }
}

//
//
//if firstname.isEmpty{
//
//    showToast = true
//    toastText = "برجاء كتابة الأسم الأول"
//}else if lastname.isEmpty{
//    showToast = true
//    toastText = "برجاء كتابة آسم العائلة"
//}else if phonenumber.isEmpty{
//    showToast = true
//    toastText = " برجاء كتابة رقم الموبايل "
//}else if country.isEmpty{
//    showToast = true
//    toastText = " برجاء كتابة الدولة"
//}else if city.isEmpty{
//    showToast = true
//    toastText = "برجاء كتابة المدينة"
//}else if region.isEmpty{
//    showToast = true
//    toastText = "برجاء كتابة المنطقة "
//}else if church.isEmpty{
//    showToast = true
//    toastText = "برجاء كتابة آسم الكنيسة"
//}else {
//    viewModel.pushObject(firstname: firstname, lastname: lastname, phonenumber: phonenumber, country: country, city: city, region: region, church: church, email: email)
//    presentationMode.wrappedValue.dismiss()
//}

// Rest of the code remains the same
