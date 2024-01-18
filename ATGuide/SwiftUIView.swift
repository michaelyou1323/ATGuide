//import SwiftUI
//import WebKit
//
//struct WebView2: UIViewRepresentable {
//    let urlString: String
//
//    func makeUIView(context: Context) -> WKWebView {
//        let webView = WKWebView()
//        webView.navigationDelegate = context.coordinator
//        return webView
//    }
//
//    func updateUIView(_ uiView: WKWebView, context: Context) {
//        if let url = URL(string: urlString) {
//            let request = URLRequest(url: url)
//            uiView.load(request)
//        }
//    }
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//    class Coordinator: NSObject, WKNavigationDelegate {
//        var parent: WebView2 // Corrected to use WebView2
//
//        init(_ parent: WebView) {
//            self.parent = parent
//        }
//    }
//}
//
//struct ContentView8: View {
//    var body: some View {
//        NavigationView {
//            WebView(urlString: "https://www.penn.museum/cgi/hieroglyphsreal.php")
//                .navigationBarTitle("Your Name in Heroglyphics", displayMode: .inline)
//        }
//    }
//}
//
//struct ContentView_Previews20: PreviewProvider {
//    static var previews: some View {
//        ContentView8()
//    }
//}
//
//@main
//struct YourApp: App {
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//        }
//    }
//}
