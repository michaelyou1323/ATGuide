import SwiftUI
import UIKit
import FirebaseMLModelDownloader


struct ThirdScreen: View {
//    @State private var isShowingCamera = false
//    @State private var capturedImage: UIImage?
//    @State private var recognizedText = ""
//    @State private var translatedText = ""
//    let options = VisionFaceDetectorOptions()
//    lazy var vision = Vision.vision()
    var body: some View {
        
//        let image = VisionImage(image: UIImage)
//        visionImage.orientation = image.imageOrientation
//
//        let labeler = ImageLabeler.imageLabeler()
//
//        // Or, to set the minimum confidence required:
//        // let options = ImageLabelerOptions()
//        // options.confidenceThreshold = 0.7
//        // let labeler = ImageLabeler.imageLabeler(options: options)
//        
//        labeler.process(image) { labels, error in
//            guard error == nil, let labels = labels else { return }
//
//            // Task succeeded.
//            // ...
//        }
//        
//        
//        for label in labels {
//            let labelText = label.text
//            let confidence = label.confidence
//            let index = label.index
//        }
//        
//        
//        let image = VisionImage(buffer: sampleBuffer)
//        image.orientation = imageOrientation(
//          deviceOrientation: UIDevice.current.orientation,
//          cameraPosition: cameraPosition)
//        
        
        VStack {
//            if let image = capturedImage {
//                Image(uiImage: image)
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .padding()
////
//                Text("Recognized Text:")
//                    .font(.headline)
//                    .padding()
////
//                Text(recognizedText)
//                    .padding()
//
//                Text("Translated Text:")
//                    .font(.headline)
//                    .padding()
//
//                Text(translatedText)
//                    .padding()
//            } else {
//                Spacer()
//
//                Button(action: {
//                    isShowingCamera = true
//                }) {
//                    Text("Capture Photo")
//                        .font(.headline)
//                        .foregroundColor(.white)
//                        .padding()
//                        .background(Color.blue)
//                        .cornerRadius(10)
//                }
//                .sheet(isPresented: $isShowingCamera) {
//                    CameraView(capturedImage: $capturedImage, recognizedText: $recognizedText, translatedText: $translatedText)
//                }
//
//                Spacer()
//            }
            ScrollView{
//                       ForEach(UIFont.familyNames.sorted(), id: \.self) { family in
//                           let names = UIFont.fontNames(forFamilyName: family)
//                           ForEach(names, id: \.self) { name in
//                               Text(name).font(Font.custom(name, size: 20))
//                           
//                           }
//                       }
//                ScrollView{
//                            ForEach(UIFont.familyNames.sorted(), id: \.self) { family in
//                                let names = UIFont.fontNames(forFamilyName: family)
//                                ForEach(names, id: \.self) { name in
//                                    Text(name).font(Font.custom(name, size: 20))
//                                }
//                            }
//                        }
         
               
                
                ZStack(alignment: .center) {
                    
                    
                    Image("Modern and Minimal Company Profile Presentation (2)") // Replace "your_background_image" with your image name
                           .resizable()
                           .aspectRatio(contentMode: .fill)
                           .frame(maxWidth: .infinity, maxHeight: .infinity)
                           .edgesIgnoringSafeArea(.all)
                           .opacity(0.8)
                           .frame(maxWidth: 175)
//                                   RoundedRectangle(cornerRadius: 20)
//                                       .fill(Color.white) // Background color of the card
//                                       .shadow(color: Color.gray.opacity(0.7), radius: 5, x: 0, y: 3) // Shadow effect

                    let shape = RoundedRectangle(cornerRadius: 20)
                    shape.fill().foregroundColor(Color.gray.opacity(0.01))
                    
                      
                    VStack {
                      
                        
                     
                        
                        
                        HStack {
                      //      if let firstLocation = recommendationsPlan12.first?.location {
                                Text("firstLocation")
                                    .font(Font.custom("Charter-BlackItalic", size: 20))
                                    .foregroundColor(Color(UIColor(hex: 0x313F54)))
                                    .padding(.top, 5)
                                    .fontWeight(.bold)
                                    .padding(.leading, 10) // Align to the left
                                Spacer() // Pushes text to the left
                                // Cochin-Bold
                                Text("Plan 1")
                                .font(Font.custom("Cochin-Bold", size: 20))
                                    .foregroundColor(Color(UIColor(hex: 0x313F54)))
                                    .padding(.top, 5)
                                    .fontWeight(.bold)
                                    .padding(.trailing, 5) // Al
                                
                            //   }
//
//
                        }
                        Spacer()
                        VStack {
                         //  if let firstImage = recommendationsPlan12.first?.Image {
                                AsyncImage(url: URL(string: convertGoogleDriveLinkToDirectImageURL(googleDriveLink: "firstImage") ?? "")) { phase in
                                    switch phase {
                                        case .empty:
                                        Image("museum2")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill) // Maintain the aspect ratio by filling the frame
                                        .frame(maxWidth: 250, maxHeight: 120)
                                        case .success(let image):
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fill) // Maintain the aspect ratio by filling the frame
                                                .frame(maxWidth: 185, maxHeight: 110) // Set the fixed size of the image
                                        case .failure:
                                            Image("1024 1")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit) // Maintain the aspect ratio by filling the frame
                                            .frame(maxWidth: 185, maxHeight: 110)
                                    @unknown default:
                                        fatalError()
                                    }
                                }
                                .cornerRadius(20)
                          ///  }
//
                        }
                        
                        .background(Color.white) // Add a white background for the image container
                        .cornerRadius(10) // Round corners of the image container
              
                        Spacer()
                        HStack {
                          
                      //     if let firstplace = recommendationsPlan12.first?.place {// Pushes text to the right
                                Text("firstplace") // Replace with your card number
                                .font(Font.custom("Charter-BlackItalic", size: 20))
                                    .foregroundColor(Color(red: 0.043, green: 0.725, blue: 0.753))
                                    
                                    .padding(.bottom,5)
                          //  }
                        }
                    }
                    
                    
               
                }
                .frame(maxHeight: 175) // Adjust the height as needed
                                           .padding(.vertical, 10)
                                           
                                           .background(Color.white) // Add a white background to the entire card
                                           .cornerRadius(20) // Round corners of the card
                                           .shadow(color: Color.gray.opacity(0.7), radius: 5, x: 0, y: 3) // Add a shadow effect
                                           .padding(.horizontal, 40)
                
                
                   }
     
        }
//        .onAppear {
//                        for family in UIFont.familyNames.sorted() {
//                            let names = UIFont.fontNames(forFamilyName: family)
//                            print("Family: \(family) Font names: \(names)")
//                        }
//                    }
    }
}



struct CameraView: UIViewControllerRepresentable {
    @Binding var capturedImage: UIImage?
    @Binding var recognizedText: String
    @Binding var translatedText: String

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: CameraView

        init(parent: CameraView) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.capturedImage = image
                parent.recognizedText = "Recognizing text..."
                recognizeText(from: image)
            }

            picker.dismiss(animated: true, completion: nil)
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
        }

        func recognizeText(from image: UIImage) {
            guard let imageData = image.jpegData(compressionQuality: 0.8) else { return }

            let apiKey = "AIzaSyByX8ehTCBZJt3Oc1kODD2K6-5Q5cQSRWo"
            let url = URL(string: "https://vision.googleapis.com/v1/images:annotate?key=\(apiKey)")!

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")

            let imageContent = ImageContent(content: imageData.base64EncodedString())
            let feature = Feature(type: "DOCUMENT_TEXT_DETECTION")
            let requestObject = VisionAPIRequest(requests: [VisionAPIRequestItem(image: imageContent, features: [feature])])

            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase

            if let jsonData = try? encoder.encode(requestObject) {
                request.httpBody = jsonData

                URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
                    if let data = data, let response = try? JSONDecoder().decode(VisionAPIResponse.self, from: data) {
                        let recognizedText = response.responses.first?.fullTextAnnotation?.text ?? "Text recognition failed"
                        DispatchQueue.main.async {
                            self?.parent.recognizedText = recognizedText
                            self?.translateText(text: recognizedText)
                        }
                    } else {
                        print("Error: \(error?.localizedDescription ?? "Unknown error")")
                    }
                }.resume()
            }
        }

        func translateText(text: String) {
            let apiKey = "YOUR_TRANSLATION_API_KEY"
            let sourceLanguage = "auto"
            let targetLanguage = "en"

            let urlString = "https://translation.googleapis.com/language/translate/v2?key=\(apiKey)&source=\(sourceLanguage)&target=\(targetLanguage)&q=\(text)"

            if let url = URL(string: urlString) {
                URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
                    if let data = data, let translationResponse = try? JSONDecoder().decode(TranslationAPIResponse.self, from: data) {
                        let translatedText = translationResponse.data.translations.first?.translatedText ?? "Translation failed"
                        DispatchQueue.main.async {
                            self?.parent.translatedText = translatedText
                        }
                    } else {
                        print("Translation Error: \(error?.localizedDescription ?? "Unknown error")")
                    }
                }.resume()
            }
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}

struct VisionAPIRequest: Codable {
    let requests: [VisionAPIRequestItem]
}

struct VisionAPIRequestItem: Codable {
    let image: ImageContent
    let features: [Feature]
}

struct ImageContent: Codable {
    let content: String
}

struct Feature: Codable {
    let type: String
}

struct VisionAPIResponse: Codable {
    let responses: [VisionAPIResponseItem]
}

struct VisionAPIResponseItem: Codable {
    let fullTextAnnotation: TextAnnotation?
}

struct TextAnnotation: Codable {
    let text: String?
}

struct TranslationAPIResponse: Codable {
    let data: TranslationData
}

struct TranslationData: Codable {
    let translations: [TranslationItem]
}

struct TranslationItem: Codable {
    let translatedText: String
}

#Preview {
    ThirdScreen()
}
