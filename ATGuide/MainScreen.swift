//
//  MainScreen.swift
//  ATGuide
//
//  Created by Michaelyoussef on 11/10/2023.
//
import SwiftUI

struct MainScreen: View {
    let email: String
    let username: String 
    let language: String 
    let country: String
    let phone: String
    let userID: String // Include userID here
    @State private var tabIndex = 0 // Track the selected tab index 
    @State private var presentSideMenu = false
    @State private var title = "Planning Section" // Track the title 
    
    var body: some View {
        ZStack {
            
        NavigationStack {
            
            VStack(spacing: 0) {
                
                
                TabView(selection: $tabIndex)
                {
                    
                    
                    Group{
                        
                        PlanningScreen(userID: userID)
                            .tabItem {
                                Image(systemName: "calendar")
                              //  Image(systemName: "map")
                                Text("Plan")
                                    
                            }.tag(0)
                        //   .toolbar(.visible, for: .tabBar)
                        //   .toolbarBackground(Color.yellow, for: .tabBar)
                        
                        SecoundScreen()
                            .tabItem {
                                Image(systemName: "qrcode.viewfinder")
                                Text("QR")
                            }.tag(1)
                         
                        
                        ContentView7()
                            .padding(.bottom,20)
                            .tabItem {
                                Image(systemName: "magnifyingglass")
                                Text("Search")
                            }.tag(2)
                        
                        FavoriteScreen(userID: userID)
                            .padding(.bottom,20)
                            .tabItem {
                                Image(systemName: "cart.fill")
                                Text("Cart")
                            }.tag(3)
                        
                        Profile(email: email, username: username,language:language,country: country, phone: phone)
                            .tabItem {
                                Image(systemName: "person.circle")
                              //  Image(systemName: "map")
                                Text("Profile")
                
                            }.tag(4)
                    }
                  
                    
                

                    .toolbarBackground(.indigo, for: .tabBar)
                    .toolbarBackground(.visible, for: .tabBar)
                    .toolbarBackground(Color(UIColor(hex: 0x0bb9c0)), for: .tabBar)
                    .toolbarColorScheme(.dark, for: .tabBar)
                    
                    
                }
               
                .onChange(of: tabIndex) {
                                       // Update the title based on the selected tab
                                       switch tabIndex {
                                           case 0:
                                               title = "Planning Section"
                                        
                                           case 1:
                                               title = "QR Code Scanner"
                                           case 2:
                                               title = "Search"
                                           case 3:
                                               title = "Your Cart"
                                           case 4:
                                               title = "Profile"
                                       default:
                                           title = ""
                                       } 
                    
                                   }
            }
            
            .navigationBarTitleDisplayMode(.inline) // Display the title inline
                .navigationBarItems(leading:  HStack {
                    
                    Text(title)
                        
                        .fontWeight(.bold)
                        .foregroundColor(Color(UIColor(hex: 0x313F54)))
                        .font(Font.custom("GillSans-SemiBoldItalic", size: 32))
                        .bold()
                    
                    
                }
                .frame(height:35) 
                .padding(.bottom,5)
                                    
                                    
                                    
//                                    , trailing:
//                                        HStack {
//                        Button(action: {
//                            // Toggle side menu visibility
//                            withAnimation(.easeInOut) {
//                                presentSideMenu.toggle()
//                            }
//                        }) {
//                            Image(systemName: "line.horizontal.3")
//                                .imageScale(.large)
//                                .foregroundColor(Color(UIColor(hex: 0x313F54)))
//                        }
//                         
//                       
//                    
////                        Text() // Display the changing title
////                            .font(.headline)
////                            .multilineTextAlignment(.center) // Align the text in the center
//                   
//                    }
               
                                //    Card("4444333388882222", "12/24", "William Black", "789")
            )
//                .navigationBarHidden(false)
//            if presentSideMenu {
//                SideMenu(email: email, username: username, language: language, country: country, presentSideMenu: $presentSideMenu)
//            }
            
        }
 
        .navigationBarHidden(true)
        if presentSideMenu {
            SideMenu(email: email, username: username,language:language,country: country, phone: phone, userID: userID, presentSideMenu: $presentSideMenu)
        }
    }
        .padding(0)
   

        }
        
        
       
    }

//struct CustomCorner: Shape {
//    let topLeft: CGFloat
//    let topRight: CGFloat
//    let bottomLeft: CGFloat
//    let bottomRight: CGFloat
//
//    func path(in rect: CGRect) -> Path {
//        var path = Path()
//        let width = rect.size.width
//        let height = rect.size.height
//
//        path.move(to: CGPoint(x: topLeft, y: 0))
//        path.addQuadCurve(to: CGPoint(x: 0, y: topLeft), control: CGPoint.zero)
//
//        path.addLine(to: CGPoint(x: 0, y: height - bottomLeft))
//        path.addQuadCurve(to: CGPoint(x: bottomLeft, y: height), control: CGPoint(x: 0, y: height))
//
//        path.addLine(to: CGPoint(x: width - bottomRight, y: height))
//        path.addQuadCurve(to: CGPoint(x: width, y: height - bottomRight), control: CGPoint(x: width, y: height))
//
//        path.addLine(to: CGPoint(x: width, y: topRight))
//        path.addQuadCurve(to: CGPoint(x: width - topRight, y: 0), control: CGPoint(x: width, y: 0))
//
//        path.closeSubpath()
//
//        return path
//    }
//}
//
//class ImagePickerCoordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//    @Binding var selectedImage: UIImage?
//    @Binding var isImagePickerPresented: Bool
//
//    init(selectedImage: Binding<UIImage?>, isImagePickerPresented: Binding<Bool>) {
//        _selectedImage = selectedImage
//        _isImagePickerPresented = isImagePickerPresented
//    }
//
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        if let selected = info[.editedImage] as? UIImage {
//            selectedImage = selected
//        } else if let selected = info[.originalImage] as? UIImage {
//            selectedImage = selected
//        }
//        isImagePickerPresented = false
//    }
//
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        isImagePickerPresented = false
//    }
//}
//
//
//struct ImagePicker: UIViewControllerRepresentable {
//    @Binding var selectedImage: UIImage?
//    @Binding var isImagePickerPresented: Bool
//
//    func makeCoordinator() -> ImagePickerCoordinator {
//        return ImagePickerCoordinator(selectedImage: $selectedImage, isImagePickerPresented: $isImagePickerPresented)
//    }
//
//    func makeUIViewController(context: Context) -> UIImagePickerController {
//        let imagePicker = UIImagePickerController()
//        imagePicker.delegate = context.coordinator
//        imagePicker.sourceType = .photoLibrary
//        imagePicker.allowsEditing = true
//        return imagePicker
//    }
//
//    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
//        // Update the view controller if needed
//    }
//}
//
//
//
struct SideMenu: View {
    let email: String
    let username: String
    let language: String
    let country: String
    let phone: String
    let userID: String // Include userID here
 
      @State private var selectedImage: UIImage? = UserDefaults.standard.getImage(forKey: "profileImage")
    

    @Binding var presentSideMenu: Bool
    @State private var isProfileScreenActive = false
    var body: some View {
        NavigationStack{
            ZStack(alignment: .trailing ) {
                // Background overlay
                Color.gray.opacity(0.8)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture { withAnimation { presentSideMenu = false } }
                 
                VStack(alignment: .leading, spacing: 10) {
                    
                    VStack(alignment: .center){
                        
                        
                        Image(uiImage: selectedImage ?? UIImage(systemName: "person.crop.circle")!)
                            .resizable()
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                            .padding(.top,40)
                            .onTapGesture {
                                   // Here, trigger a navigation to the profile screen
                                   // by updating a state variable that controls navigation
                                   // For example:
                                    isProfileScreenActive = true
                               
                               }
                               .background(
                                   // Instead of using NavigationLink here directly,
                                   // use it at the appropriate place in your view hierarchy
//                                NavigationLink(destination: Profile(email: email, username: username,language:language,country: country, phone: phone), isActive: $isProfileScreenActive) {
//                                       
//                                       EmptyView()
//                                   }
                               )
                               .navigationDestination(
                                    isPresented: $isProfileScreenActive) {
                                        Profile(email: email, username: username,language:language,country: country, phone: phone)
                                    }
                        Text(username)
                            .font(.headline)
                        
                        Text(email)
                            .padding(.leading, 5)
                            .font(.system(size: 15))
                            .foregroundColor(.white)
                    }
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                    .frame(maxWidth: .infinity, minHeight: 250, alignment: .center)
                    .background(Color(UIColor(hex: 0x0bb9c0)))
                    
                    .clipShape(
                        CustomCorner(
                            topLeft: 0, topRight: 0, // No change for top corners
                            bottomLeft: 20, bottomRight: 20 // Apply the corner radius only to the bottom corners
                        )
                    )
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                    .edgesIgnoringSafeArea(.all)
                    .padding(.bottom,0)
                    
                    // Language with padding, background, border, and corner radius
                    HStack {
                                    Image(systemName: "globe")
                            .padding(.leading,10) 
                                    Text("language")
                                        .padding(.leading, 5)
                                        .font(.headline)
                                        .background(Color.white)
                                        .padding(.top, 0)
                    Spacer()
                        Text(language)
                            .padding(.trailing, 5)
                            .font(.headline)
                            .foregroundColor(Color.gray).opacity(0.6)
                            .padding(.top, 0)
                                }
                                .padding(.top, 5)
                                .background(Color.white)
                                .cornerRadius(5)
    //                    .frame(maxWidth: .infinity,minHeight:50 ,alignment: .leading)
    //                    .border(Color.gray, width: 1) // Adding a border
                
                    Divider().background(.black)
                    
                    HStack {
                        Image(systemName: "flag")
                            .padding(.leading,10)
                                    Text("Country")
                                        .padding(.leading, 5)
                                        .font(.headline)
                                        .background(Color.white)
                                        .padding(.top, 0)
                        
                        Spacer()
                            Text(country)
                                .padding(.trailing, 5)
                                .font(.headline)
                                .foregroundColor(Color.gray).opacity(0.6)
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
                            .padding(.leading,10)
                                    Text("Phone")
                                        .padding(.leading, 5)
                                        .font(.headline)
                                        .background(Color.white)
                                        .padding(.top, 0)
                        Spacer()
                            Text(phone)
                                .padding(.trailing, 5)
                                .font(.headline)
                                .foregroundColor(Color.gray).opacity(0.6)
                                .padding(.top, 0)
                                }
                                .padding(.top, 5) 
                                .background(Color.white)
                                .cornerRadius(5)
                       
                    Divider().background(.black)
                    HStack {
                        Image(systemName: "id")
                            .padding(.leading,10)
                                    Text("id")
                                        .padding(.leading, 5)
                                        .font(.headline)
                                        .background(Color.white)
                                        .padding(.top, 0)
                        
                        Spacer()
                             Text(userID)
                                .padding(.trailing, 5)
                                .font(.headline)
                                .foregroundColor(Color.gray).opacity(0.6)
                                .padding(.top, 0)
                                }
                                .padding(.top, 5)
                                .background(Color.white)
                                .cornerRadius(5)
                       
                    Divider().background(.black)
                    
                    
                }
                .frame(maxWidth: 270, maxHeight: .infinity, alignment: .top)
                .background(Color.white.ignoresSafeArea(.all))
                .offset(x: self.presentSideMenu ? 0 : -UIScreen.main.bounds.width/0)
                //            .sheet(isPresented: $isImagePickerPresented) {
                //                       ImagePicker(selectedImage: $selectedImage, isImagePickerPresented: $isImagePickerPresented)
                //                           .onDisappear {
                //                               UserDefaults.standard.saveImage(image: selectedImage, forKey: "profileImage")
                //                           }
                //                   }
            }
            
        }
    }
}




#Preview {
    MainScreen( email: "ertert", username: "erttr",language: "ert", country: "46456", phone: "456456", userID: "t17QMgg7C0QoRNr401O9Z93zTMl1")
}
 
