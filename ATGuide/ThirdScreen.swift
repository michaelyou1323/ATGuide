import SwiftUI
import UIKit

struct ThirdScreen: View {
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
                .sheet(isPresented: $isShowingCamera) {
                    CameraView(capturedImage: $capturedImage, recognizedText: $recognizedText)
                }

                Spacer()
            }
        }
    }
}

struct CameraView: UIViewControllerRepresentable {
    @Binding var capturedImage: UIImage?
    @Binding var recognizedText: String

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: CameraView

        init(parent: CameraView) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.capturedImage = image
                // Call the text recognition logic here
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
                        }
                    } else {
                        print("Error: \(error?.localizedDescription ?? "Unknown error")")
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

struct ThirdScreen_Previews: PreviewProvider {
    static var previews: some View {
        ThirdScreen()
    }
}
