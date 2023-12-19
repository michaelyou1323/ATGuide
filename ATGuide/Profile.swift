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

 
    @State private var isImagePickerPresented = false

      @State private var selectedImage: UIImage? = UserDefaults.standard.getImage(forKey: "profileImage")


//    @Binding var presentSideMenu: Bool


    
    var body: some View {

            
            VStack(alignment: .leading, spacing: 10) {
                
                    VStack(alignment: .center){
                        
                     
                        Image(uiImage: selectedImage ?? UIImage(systemName: "person.crop.circle")!)
                            .resizable()
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                            .padding(.top,40)
                            .onTapGesture {
                                isImagePickerPresented = true
                            }
                        Text("username")
                            .font(.headline)
                        
                        Text("email")
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
                Text("language")
                    .padding(.leading,5)
                    .font(.headline)
                    .background(Color.white)
                    .padding(.top,0)
//                    .frame(maxWidth: .infinity,minHeight:50 ,alignment: .leading)
//                    .border(Color.gray, width: 1) // Adding a border
            
                Divider().background(.black)
                
                Text("country")
                    .padding(.leading,5)
                    .font(.headline)
                    .background(Color.white)
                   
                Divider().background(.black)
//                    .frame(maxWidth: .infinity,minHeight:50 ,alignment: .leading)
//                    .border(Color.gray, width: 1) // Adding a border
                
                Text("phone")
                    .padding(.leading,5)
                    .font(.headline)
                    .background(Color.white)
                   
                Divider().background(.black)
                
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
    Profile()
}
