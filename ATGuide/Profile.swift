//
//  Profile.swift
//  ATGuide
//
//  Created by Michaelyoussef on 18/12/2023.
//

import SwiftUI



struct CustomCorner: Shape {
    let topLeft: CGFloat
    let topRight: CGFloat
    let bottomLeft: CGFloat
    let bottomRight: CGFloat

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height

        path.move(to: CGPoint(x: topLeft, y: 0))
        path.addQuadCurve(to: CGPoint(x: 0, y: topLeft), control: CGPoint.zero)

        path.addLine(to: CGPoint(x: 0, y: height - bottomLeft))
        path.addQuadCurve(to: CGPoint(x: bottomLeft, y: height), control: CGPoint(x: 0, y: height))

        path.addLine(to: CGPoint(x: width - bottomRight, y: height))
        path.addQuadCurve(to: CGPoint(x: width, y: height - bottomRight), control: CGPoint(x: width, y: height))

        path.addLine(to: CGPoint(x: width, y: topRight))
        path.addQuadCurve(to: CGPoint(x: width - topRight, y: 0), control: CGPoint(x: width, y: 0))

        path.closeSubpath()

        return path
    }
}

class ImagePickerCoordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @Binding var selectedImage: UIImage?
    @Binding var isImagePickerPresented: Bool

    init(selectedImage: Binding<UIImage?>, isImagePickerPresented: Binding<Bool>) {
        _selectedImage = selectedImage
        _isImagePickerPresented = isImagePickerPresented
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selected = info[.editedImage] as? UIImage {
            selectedImage = selected
        } else if let selected = info[.originalImage] as? UIImage {
            selectedImage = selected
        }
        isImagePickerPresented = false
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        isImagePickerPresented = false
    }
}


struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Binding var isImagePickerPresented: Bool

    func makeCoordinator() -> ImagePickerCoordinator {
        return ImagePickerCoordinator(selectedImage: $selectedImage, isImagePickerPresented: $isImagePickerPresented)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = context.coordinator
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // Update the view controller if needed
    }
}







struct Profile: View {
    let email: String
    let username: String
    var language: String
    let country: String
    var phone: String
    @State private var editedUsername = ""
       @State private var editedEmail = ""
       @State private var editedLanguage = "language"
       @State private var editedCountry = ""
       @State private var editedPhone = ""
    @State private var isImagePickerPresented = false
    @State private var isEditing = false
    @State private var navigateToYourPlans = false
      @State private var selectedImage: UIImage? = UserDefaults.standard.getImage(forKey: "profileImage")


//    @Binding var presentSideMenu: Bool


    
    var body: some View {

            
            VStack(alignment: .leading, spacing: 10) {
                
                    VStack(alignment: .center){
                        
                     
                        Image(uiImage: selectedImage ?? UIImage(systemName: "person.crop.circle")!)
                                       .resizable()
                                       .frame(width: 80, height: 80)
                                       .clipShape(Circle())
                                       .overlay(Circle().stroke(Color.white, lineWidth: 4))
                                       .shadow(radius: 5)
                                       .padding(.top, 40)
                                       .onTapGesture {
                                           isImagePickerPresented = true
                                       }
                        Text(username)
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundColor(.black)

                        
                        Text(email)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                        
                        
                        HStack(alignment:.bottom) {
                                           Spacer()
                                           if isEditing {
                                               Image(systemName: "checkmark.circle.fill")
                                                   .padding(.horizontal, 18)
                                                   .font(.system(size: 20))
                                                   .foregroundColor(.white)
                                                   .clipShape(Circle())
                                                   .onTapGesture {
                                                       // Handle save logic
                                                       isEditing = false
                                                   }
                                           } else {
                                               Image(systemName: "pencil")
                                                   .padding(.horizontal, 20)
                                                   .font(.system(size: 25))
                                                   .foregroundColor(.white)
                                                   .clipShape(Circle())
                                                   .onTapGesture {
                                                       // Handle enabling editing mode
                                                       isEditing = true
                                                   }
                                           }
                                       }
                                   
                        
                    }
                  
                    .frame(maxWidth: .infinity, minHeight: 250, alignment: .center)
                    .background(Color(red: 0.827, green: 0.827, blue: 0.827))
                
                  
                    .clipShape(
                        CustomCorner(
                            topLeft: 0, topRight: 0, // No change for top corners
                            bottomLeft: 20, bottomRight: 20 // Apply the corner radius only to the bottom corners
                        )
                        )
                  
                    .edgesIgnoringSafeArea(.all)
                    .padding(.bottom,0)
            
                // Language with padding, background, border, and corner radius
                HStack {
                    
                        Image(systemName: "globe")
                            .padding(.leading,10)
                            .foregroundColor(Color(UIColor(hex: 0x0bb9c0)))
                   
                        Text("language")
                            .padding(.leading, 5)
                            .font(.headline)
                            .foregroundColor(Color(red: 0.192, green: 0.259, blue: 0.333) )
                            .background(Color.white)
                            .padding(.top, 0)
                    
                   
                    Spacer()
                if isEditing {
                    
                    Spacer()
                    TextField("", text: $editedLanguage)
                        .padding(.trailing, 5)
                        .font(.headline)
                        .foregroundColor(Color(red: 0.722, green: 0.275, blue: 0.114))
                        .padding(.top, 0)
                    
                }else{
                    Spacer()
                    Text(language)
                        .padding(.trailing, 5)
                        .font(.headline)
                        .foregroundColor(Color(red: 0.722, green: 0.275, blue: 0.114))
                        .padding(.top, 0)
                }
                }
                           

            
                Divider().background(.black)
                
                HStack {
                    Image(systemName: "flag")
                        .padding(.leading,10)
                        .foregroundColor(Color(UIColor(hex: 0x0bb9c0)))
                                Text("Country")
                                    .padding(.leading, 5)
                                    .font(.headline)
                                    .background(Color.white)
                                    .foregroundColor(Color(red: 0.192, green: 0.259, blue: 0.333) )
                                    .padding(.top, 0)
                    
                    Spacer()
                        Text(country)
                            .padding(.trailing, 5)
                            .font(.headline)
                            .foregroundColor(Color(red: 0.722, green: 0.275, blue: 0.114))
                            .padding(.top, 0)
                            }
                            .padding(.top, 5)
                            .background(Color.white)
                            .cornerRadius(5)
                   
                Divider().background(.black)
//                    .frame(maxWidth: .infinity,minHeight:50 ,alignment: .leading)
//                    .border(Color.gray, width: 1) // Adding a border
                
                HStack {
                                Image(systemName: "phone")
                        .foregroundColor(Color(UIColor(hex: 0x0bb9c0)))
                        .padding(.leading,10)
                    
                                Text("Phone")
                                    .padding(.leading, 5)
                                    .font(.headline)
                                    .background(Color.white)
                                    .foregroundColor(Color(red: 0.192, green: 0.259, blue: 0.333) )
                                    .padding(.top, 0)
                    Spacer()
                        Text(phone)
                            .padding(.trailing, 5)
                            .font(.headline)
                            .foregroundColor(Color(red: 0.722, green: 0.275, blue: 0.114))
                            .padding(.top, 0)
                            }
                            .padding(.top, 5)
                            .background(Color.white)
                            .cornerRadius(5)
                   
                Divider().background(.black)
                    .padding(.bottom,30)
                
               
                HStack(alignment: .center){
                    Spacer()
                           
                    ZStack{
                        let shape = RoundedRectangle(cornerRadius: 9)
                        shape.fill().foregroundColor(.clear)
                        
                        shape.stroke(Color(red: 0, green: 0.243, blue: 0.502), lineWidth: 2)
                        Text("Try your name in hieroglyphics!")
                        
                            .font(Font.custom("", size: 22))
                            .padding(.bottom,2)
                        
                        //  SnellRoundhand-Bold
                        //
                    }
                    .frame(height:40)
                    .onTapGesture(perform: {
                        navigateToYourPlans = true
                    })
                    .navigationBarBackButtonHidden(true)
                
                    
                    

                  Spacer()
                            }
                .navigationDestination(
                     isPresented:$navigateToYourPlans) {
                       //  ReservationRowView(reservation: "t17QMgg7C0QoRNr401O9Z93zTMl1")
                         WebView2(urlString: "https://www.penn.museum/cgi/hieroglyphsreal.php")
                     
                                        .navigationBarTitle("Your Name in Hieroglyphics", displayMode: .inline)
                                        .navigationBarBackButtonHidden(true)
                     }
               
               
   
                .padding(.top, 5)
               
                .background(Color.white)
                .cornerRadius(5)
       
            
                
            }
         
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(Color.white.ignoresSafeArea(.all))
//            .offset(x: self.presentSideMenu ? 0 : -UIScreen.main.bounds.width/0)
            .sheet(isPresented: $isImagePickerPresented) {
                       ImagePicker(selectedImage: $selectedImage, isImagePickerPresented: $isImagePickerPresented)
                           .onDisappear {
                               UserDefaults.standard.saveImage(image: selectedImage, forKey: "profileImage")
                           }
                   }
        }
    
}
extension UserDefaults {
    func saveImage(image: UIImage?, forKey key: String) {
        guard let image = image else { return }
        if let data = image.jpegData(compressionQuality: 1.0) {
            set(data, forKey: key)
        }
    }

    func getImage(forKey key: String) -> UIImage? {
        if let data = data(forKey: key) {
            return UIImage(data: data)
        }
        return nil
    }
}

#Preview {
    Profile(email: "michaelyou200@gmail.com", username: "Michaelyou", language: "English", country: "Egypt", phone: "o12220140685")
}
