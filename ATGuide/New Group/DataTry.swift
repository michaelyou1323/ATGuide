//import SwiftUI
//
//class RecommendationsViewModel: ObservableObject {
//    @Published var recommendations: [WelcomeElement] = []
//    
//    func fetchData() {
//        guard let url = URL(string: "https://32bb-156-210-170-81.ngrok-free.app/recommendations") else {
//            print("Invalid URL")
//            return
//        }
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        // Additional configurations if needed, e.g., setting headers or request body
//        
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            if let error = error {
//                print("Error: \(error.localizedDescription)")
//                return
//            }
//            
//            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
//                print("Invalid response")
//                return
//            }
//            
//            if let data = data {
//                do {
//                    let decoder = JSONDecoder()
//                    let decodedData = try decoder.decode(Welcome.self, from: data)
//                    
//                    DispatchQueue.main.async {
//                        self.recommendations = decodedData
//                    }
//                } catch {
//                    print("Error decoding JSON: \(error.localizedDescription)")
//                }
//            }
//        }.resume()
//    }
//    
//    
//    
//    
//    // MARK: - Welcome
//    struct Welcome: Codable {
//        let bestRecommendationsPlans: [BestRecommendationsPlan]
//
//        enum CodingKeys: String, CodingKey {
//            case bestRecommendationsPlans = "best_recommendations_plans"
//        }
//    }
//
//    // MARK: - BestRecommendationsPlan
//    struct BestRecommendationsPlan: Codable, Identifiable {
//        let id = UUID()
//        let bestRecommendationsPlan1, bestRecommendationsPlan2, bestRecommendationsPlan3, bestRecommendationsPlan4: [BestRecommendationsPlan1_Element]?
//        let bestRecommendationsPlan5, bestRecommendationsPlan6, bestRecommendationsPlan7, bestRecommendationsPlan8: [BestRecommendationsPlan1_Element]?
//        let bestRecommendationsPlan9, bestRecommendationsPlan10: [BestRecommendationsPlan1_Element]?
//
//        enum CodingKeys: String, CodingKey {
//            case bestRecommendationsPlan1 = "best_recommendations_plan 1"
//            case bestRecommendationsPlan2 = "best_recommendations_plan 2"
//            case bestRecommendationsPlan3 = "best_recommendations_plan 3"
//            case bestRecommendationsPlan4 = "best_recommendations_plan 4"
//            case bestRecommendationsPlan5 = "best_recommendations_plan 5"
//            case bestRecommendationsPlan6 = "best_recommendations_plan 6"
//            case bestRecommendationsPlan7 = "best_recommendations_plan 7"
//            case bestRecommendationsPlan8 = "best_recommendations_plan 8"
//            case bestRecommendationsPlan9 = "best_recommendations_plan 9"
//            case bestRecommendationsPlan10 = "best_recommendations_plan 10"
//        }
//    }
//
//    // MARK: - BestRecommendationsPlan1_Element
//    struct BestRecommendationsPlan1_Element: Codable {
//        let hotel: Hotel
//        let place: String
//        let restaurant: Restaurant
//        let totalCost: Int
//
//        enum CodingKeys: String, CodingKey {
//            case hotel = "Hotel"
//            case place = "Place"
//            case restaurant = "Restaurant"
//            case totalCost = "Total Cost"
//        }
//    }
//
//    enum Hotel: String, Codable {
//        case bahariyaOasisCamp = "Bahariya Oasis Camp"
//    }
//
//    enum Restaurant: String, Codable {
//        case alexandriaSeafoodHavenAlexandria = "Alexandria Seafood Haven - Alexandria"
//        case bazaarDelicaciesCairo = "Bazaar Delicacies - Cairo"
//        case feluccaFloatingCafeNileRiver = "Felucca Floating Cafe - Nile River"
//        case luxorOasisGrillLuxor = "Luxor Oasis Grill - Luxor"
//        case luxorRiversideBrasserieLuxor = "Luxor Riverside Brasserie - Luxor"
//    }
//
//}
//
//
//struct ContentView3: View {
//    @StateObject var viewModel = RecommendationsViewModel()
//    
//    var body: some View {
//        NavigationView {
//            List(viewModel.recommendations, id: \.self) { element in
//                // Display elements from the recommendations here
//                Text("Element: \(element)")
//            }
//            .onAppear {
//                viewModel.fetchData()
//            }
//            .navigationBarTitle("Recommendations")
//        }
//    }
//}
//
//
