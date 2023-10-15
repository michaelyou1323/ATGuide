import SwiftUI
import Vision
import VisionKit

struct FirstScreen: View {
    @State private var scannedText: String = ""
    @State private var isShowingScanner: Bool = false
    
    var body: some View {
        VStack {
            Button(action: {
                isShowingScanner = true
            }) {
                Text("Scan Text")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .sheet(isPresented: $isShowingScanner) {
                ScannerView(scannedText: $scannedText)
            }
            
            Text("Scanned Text: \(scannedText)")
                .padding()
        }
    }
}

struct ScannerView: UIViewControllerRepresentable {
    @Binding var scannedText: String
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> VNDocumentCameraViewController {
        let scannerViewController = VNDocumentCameraViewController()
        scannerViewController.delegate = context.coordinator
        return scannerViewController
    }
    
    func updateUIViewController(_ uiViewController: VNDocumentCameraViewController, context: Context) {
        // Update the view controller if needed
    }
    
    class Coordinator: NSObject, VNDocumentCameraViewControllerDelegate {
        let parent: ScannerView
        
        init(_ parent: ScannerView) {
            self.parent = parent
        }
        
        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
            for pageIndex in 0..<scan.pageCount {
                let image = scan.imageOfPage(at: pageIndex)
                
                // Perform OCR on the captured image
                recognizeText(image: image)
            }
            
            controller.dismiss(animated: true)
        }
        
        func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
            controller.dismiss(animated: true)
        }
        
        func recognizeText(image: UIImage) {
            guard let cgImage = image.cgImage else {
                return
            }
            
            let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
            let request = VNRecognizeTextRequest { (request, error) in
                if let error = error {
                    print("Error recognizing text: \(error.localizedDescription)")
                    return
                }
                
                guard let observations = request.results as? [VNRecognizedTextObservation] else {
                    return
                }
                
                let detectedText = observations.compactMap { observation in
                    observation.topCandidates(1).first?.string
                }.joined(separator: " ")
                
                DispatchQueue.main.async {
                    self.parent.scannedText = detectedText
                }
            }
            
            do {
                try requestHandler.perform([request])
            } catch {
                print("Error performing OCR: \(error.localizedDescription)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        FirstScreen()
    }
}
