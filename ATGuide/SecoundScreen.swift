import SwiftUI
import AVFoundation
import WebKit

struct QRCodeScannerView: UIViewControllerRepresentable {
    class Coordinator: NSObject, AVCaptureMetadataOutputObjectsDelegate {
        var parent: QRCodeScannerView

        init(parent: QRCodeScannerView) {
            self.parent = parent
        }

        func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
            if let metadataObject = metadataObjects.first {
                guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
                guard let stringValue = readableObject.stringValue else { return }
                AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
                parent.didFindCode(stringValue, metadataObject)
            }
        }
    }

    var didFindCode: (String, AVMetadataObject) -> Void

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        let session = AVCaptureSession()

        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return viewController }
        let videoInput: AVCaptureDeviceInput

        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return viewController
        }

        if (session.canAddInput(videoInput)) {
            session.addInput(videoInput)
        } else {
            return viewController
        }

        let metadataOutput = AVCaptureMetadataOutput()

        if (session.canAddOutput(metadataOutput)) {
            session.addOutput(metadataOutput)

            metadataOutput.setMetadataObjectsDelegate(context.coordinator, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            return viewController
        }

        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.frame = viewController.view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        viewController.view.layer.addSublayer(previewLayer)

        session.startRunning()

        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

struct SecoundScreen: View {
    @State private var scannedCode: String?
    @State private var isScannerSheetPresented = false
    @State private var highlightFrame: CGRect?

    var body: some View {
        NavigationView {
            VStack {
                if let scannedCode = scannedCode {
                    if let url = URL(string: scannedCode), UIApplication.shared.canOpenURL(url) {
                        NavigationLink(destination: WebView(url: url)) {
                            Text("Open URL")
                                .padding()
                                .foregroundColor(Color(UIColor(hex: 0x0bb9c0)))
                        }
                    } else {
                        Text("Scanned code: \(scannedCode)")
                            .padding()
                    }
                } else {

                    VStack{
                        
                        Button {
                            self.isScannerSheetPresented.toggle()
                        } label: {
                            HStack{
                                Image(systemName:"qrcode.viewfinder")// Use a QR code icon
                                        Text("Scan QR Code")
                                
                            }
                        }
                        .padding()
                        .background(Color(red: 0.192, green: 0.259, blue: 0.333)) // Set the background color
                        .foregroundColor(.white) // Set the text color to white
                        .cornerRadius(8) // Optional: Add corner radius for a rounded button appearance
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.white, lineWidth: 2)
                        )
                        .sheet(isPresented: $isScannerSheetPresented) {
                            QRCodeScannerView { code, metadataObject in
                                self.scannedCode = code
                                self.isScannerSheetPresented = false
                                if let visualCodeObject = metadataObject as? AVMetadataMachineReadableCodeObject {
                                    let visualCodeBounds = visualCodeObject.bounds
                                    self.highlightFrame = visualCodeBounds
                                }
                            }
                        }
                        .overlay(
                            highlightFrame.map { frame in
                                Rectangle()
                                    .stroke(Color.green, lineWidth: 2)
                                    .frame(width: frame.width, height: frame.height)
                                    .offset(x: frame.minX, y: frame.minY)
                            }
                        )
                        
                        
//                        Image("phone-scanning-qr-code-via-mobile-app-icon_212005-593-transformed")
//                            .frame(width:50,height: 50)// Use a QR code icon
                            
                    }
                    
                }
            }
          
            .foregroundColor(Color(UIColor(hex: 0x313F54)))
        }
    }
}



struct WebView: View {
    let url: URL

    var body: some View {
        WebViewRepresentable(url: url)
            .navigationBarTitle("Web View")
    }
}

struct WebViewRepresentable: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.load(URLRequest(url: url))
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {}
}

struct SecoundScreen_Previews4: PreviewProvider {
    static var previews: some View {
        SecoundScreen()
    }
}
