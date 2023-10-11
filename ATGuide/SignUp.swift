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
    
    
    
    
    @State var firstname = ""
    @State var lastname = ""
    @State var phonenumber = ""
    @State var country = ""
    @State var city = ""
    @State var region = ""
    @State var church = ""
    @State var email = ""
    
 //   @StateObject var viewModel = WriteViewModel()
    
    var body: some View {
        VStack {
            Text("Your Information")
                .font(.system(size: 27))
                .bold()
            
            VStack {
                ScrollView {
                    TextField("Name ", text: $firstname)
                        .border(Color.black)
                        .font(.title2)
                        .padding()
                        .textFieldStyle(.roundedBorder)
                        .multilineTextAlignment(.leading)
                    
                    TextField("E-mail", text: $lastname)
                        .border(Color.black)
                        .font(.title2)
                        .padding()
                        .textFieldStyle(.roundedBorder)
                        .multilineTextAlignment(.leading)
                    
                    TextField("phone", text: $phonenumber)
                        .border(Color.black)
                        .font(.title2)
                        .padding()
                        .textFieldStyle(.roundedBorder)
                        .multilineTextAlignment(.leading)
                    
                    TextField("Country", text: $country)
                        .border(Color.black)
                        .font(.title2)
                        .padding()
                        .textFieldStyle(.roundedBorder)
                        .multilineTextAlignment(.leading)
                    
                    TextField("language", text: $city)
                        .border(Color.black)
                        .font(.title2)
                        .padding()
                        .textFieldStyle(.roundedBorder)
                        .multilineTextAlignment(.leading)
                    
                    TextField("password", text: $region)
                        .border(Color.black)
                        .font(.title2)
                        .padding()
                        .textFieldStyle(.roundedBorder)
                        .multilineTextAlignment(.leading)
                    
                    TextField("confirm password", text: $church)
                        .border(Color.black)
                        .font(.title2)
                        .padding()
                        .textFieldStyle(.roundedBorder)
                        .multilineTextAlignment(.leading)
                    
                 
                }
//                .' '#' '$' '[' or ']
                Button(action: {
                    if firstname.isEmpty || firstname.contains(".") || firstname.contains("#") || firstname.contains("$") || firstname.contains("[") || firstname.contains("]") || firstname.contains(" "){
                        showToast = true
                        toastText = " Please Enter your name "
                    }else if lastname.isEmpty || lastname.contains(" "){
                        showToast = true
                        toastText = "Please Enter your E-mail "
                    }else if phonenumber.isEmpty || phonenumber.contains(".") || phonenumber.contains("#") || phonenumber.contains("$") || phonenumber.contains("[") || phonenumber.contains("]") || phonenumber.contains(" ") {
                        showToast = true
                        toastText = " Please Enter your Phone "
                    }else if country.isEmpty || country.contains(" ") {
                        showToast = true
                        toastText = " Please Enter your Country "
                    }else if city.isEmpty || city.contains(" ") {
                        showToast = true
                        toastText = "Please Enter your Language "
                    }else if region.isEmpty || region.contains(" ") {
                        showToast = true
                        toastText = "Please Enter valid Password  "
                    }else if church.isEmpty || church.contains(" ") {
                        showToast = true
                        toastText = "Passwords must be idintical "
                    } else {
                        
                        isLoading = true // Start loading animation
                        showToast = true
                        
//                                               viewModel.pushObject(firstname: firstname, lastname: lastname, phonenumber: phonenumber, country: country, city: city, region: region, church: church, email: email)

                        toastText = " تم تسجيل بياناتك ٫ سنقوم بالتواصل معك ..."
                       
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {
                            isLoading = false // Stop loading animation after 3 seconds
                            presentationMode.wrappedValue.dismiss()
                           

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
                .padding()
                
                .padding(.bottom, 55)
            }
            .modifier(ToastModifier(showToast: $showToast, toastText: toastText))
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
