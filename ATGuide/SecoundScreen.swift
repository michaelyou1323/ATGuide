import SwiftUI
import UIKit

struct SecoundScreen: View {
    @State private var isShowingCamera = false
    @State private var capturedImage: UIImage?
    @State private var recognizedText = ""
    
    var body: some View {
        VStack {
            if let image = capturedImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
                
                Text(recognizedText)
                    .padding()
            } else {
                Spacer()
                
                Button(action: {
                    isShowingCamera = true
                }) {
                    Text("Capture Photo")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                
                Spacer()
            }
        }
        .sheet(isPresented: $isShowingCamera) {
            CameraView(capturedImage: $capturedImage, recognizedText: $recognizedText, translatedText: $recognizedText)
        }
    }
}

#Preview {
    SecoundScreen()
}
//
//struct CameraView: UIViewControllerRepresentable {
//    @Binding var capturedImage: UIImage?
//    @Binding var recognizedText: String
//    
//    func makeUIViewController(context: Context) -> CameraViewController {
//        let cameraViewController = CameraViewController()
//        cameraViewController.delegate = context.coordinator
//        return cameraViewController
//    }
//    
//    func updateUIViewController(_ uiViewController: CameraViewController, context: Context) {}
//    
//    func makeCoordinator() -> Coordinator {
//        Coordinator(capturedImage: $capturedImage, recognizedText: $recognizedText)
//    }
//    
//    class Coordinator: NSObject, CameraViewControllerDelegate {
//        @Binding var capturedImage: UIImage?
//        @Binding var recognizedText: String
//        
//        init(capturedImage: Binding<UIImage?>, recognizedText: Binding<String>) {
//            _capturedImage = capturedImage
//            _recognizedText = recognizedText
//        }
//        
//        func cameraViewController(_ controller: CameraViewController, didCaptureImage image: UIImage) {
//            capturedImage = image
//            recognizeText(from: image)
//        }
//        
//        func recognizeText(from image: UIImage) {
//            guard let imageData = image.jpegData(compressionQuality: 0.8) else { return }
//            
//            // Set up your Google Cloud Vision API credentials and make the API call
//            let apiKey = "YOUR_API_KEY"
//            let urlString = "https://vision.googleapis.com/v1/images:annotate?key=\(apiKey)"
//            let url = URL(string: urlString)!
//            
//            var request = URLRequest(url: url)
//            request.httpMethod = "POST"
//            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//            
//            let imageContent = ImageContent(content: imageData.base64EncodedString())
//            let feature = Feature(type: "TEXT_DETECTION")
//            let requestObject = VisionAPIRequest(requests: [VisionAPIRequestItem(image: imageContent, features: [feature])])
//            
//            let encoder = JSONEncoder()
//            encoder.keyEncodingStrategy = .convertToSnakeCase
//            if let jsonData = try? encoder.encode(requestObject) {
//                request.httpBody = jsonData
//                
//                let task = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
//                    if let data = data, let response = try? JSONDecoder().decode(VisionAPIResponse.self, from: data) {
//                        let recognizedText = response.responses.first?.textAnnotations.first?.description ?? "Text recognition failed"
//                        DispatchQueue.main.async {
//                            self?.recognizedText = recognizedText
//                        }
//                    } else {
//                        print("Error: \(error?.localizedDescription ?? "Unknown error")")
//                    }
//                }
//                
//                task.resume()
//            }
//        }
//    }
//}
//
//protocol CameraViewControllerDelegate: AnyObject {
//    func cameraViewController(_ controller: CameraViewController, didCaptureImage image: UIImage)
//}
//
//class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//    weak var delegate: CameraViewControllerDelegate?
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        presentCameraPicker()
//    }
//    
//    private func presentCameraPicker() {
//        let picker = UIImagePickerController()
//        picker.delegate = self
//        picker.sourceType = .camera
//        picker.cameraCaptureMode = .photo
//        picker.allowsEditing = false
//        present(picker, animated: true, completion: nil)
//    }
//    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        guard let image = info[.originalImage] as? UIImage else {
//            picker.dismiss(animated: true, completion: nil)
//            return
//        }
//        
//        delegate?.cameraViewController(self, didCaptureImage: image)
//        picker.dismiss(animated: true, completion: nil)
//    }
//    
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        picker.dismiss(animated: true, completion: nil)
//    }
//}
//
//struct VisionAPIRequest: Codable {
//    let requests: [VisionAPIRequestItem]
//}
//
//structVisionAPIRequestItem: Codable {
//    let image: ImageContent
//    let features: [Feature]
//}
//
//struct ImageContent: Codable {
//    let content: String
//}
//
//struct Feature: Codable {
//    let type: String
//}
//
//struct VisionAPIResponse: Codable {
//    let responses: [VisionAPIResponseItem]
//}
//
//struct VisionAPIResponseItem: Codable {
//    let textAnnotations: [TextAnnotation]?
//}
//
//struct TextAnnotation: Codable {
//    let description: String
//}
