//import SwiftUI
//
//struct ContentView5: View {
//    @State private var recommendationsPlan1: [Recommendation] = []
//    @State private var recommendationsPlan2: [Recommendation] = []
//    @State private var recommendationsPlan3: [Recommendation] = []
//    
//    var body: some View {
//        NavigationView {
//            VStack(spacing: 20) {
//                List(recommendationsPlan1, id: \.self) { recommendation in
//                    RecommendationView(recommendation: recommendation)
//                }
//                
////                Text("----------")
////                
////                List(recommendationsPlan2, id: \.self) { recommendation in
////                    RecommendationView(recommendation: recommendation)
////                }
////                Text("---------- ")
////                List(recommendationsPlan3, id: \.self) { recommendation in
////                    RecommendationView(recommendation: recommendation)
////                }
//            }
//            .navigationTitle("Recommendations")
//            .onAppear {
//                fetchData()
//            }
//        }
//    }
//
//    func fetchData() {
//        guard let url = URL(string: "https://56bc-156-210-170-81.ngrok-free.app/recommendations") else {
//            return
//        }
//
//        let body: [String: Any] = [
//            "place_type": "culture_places",
//            "budget": 500,
//            "city_day": [
//                ["city": "Cairo", "days": 3],
//                ["city": "Alexandria", "days": 3],
//                ["city": "Luxor", "days": 3]
//            ]
//        ]
//
//        let jsonData = try? JSONSerialization.data(withJSONObject: body)
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.httpBody = jsonData
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            if let error = error {
//                print("Error: \(error.localizedDescription)")
//                return
//            }
//
//            guard let httpResponse = response as? HTTPURLResponse else {
//                print("Invalid response")
//                return
//            }
//
//            print("HTTP Status Code: \(httpResponse.statusCode)")
//
//            if let data = data {
//                do {
//                    if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
//                        for plan in jsonResponse {
//                            if let recommendations = plan["best_recommendations_plan_1"] as? [[String: Any]] {
//                                for recommendationData in recommendations {
//                                    if let recommendation = createRecommendation(from: recommendationData) {
//                                        DispatchQueue.main.async {
//                                            self.recommendationsPlan1.append(recommendation)
//                                        }
//                                    }
//                                }
//                            } else if let recommendations = plan["best_recommendations_plan_2"] as? [[String: Any]] {
//                                for recommendationData in recommendations {
//                                    if let recommendation = createRecommendation(from: recommendationData) {
//                                        DispatchQueue.main.async {
//                                            self.recommendationsPlan2.append(recommendation)
//                                        }
//                                    }
//                                }
//                            } else if let recommendations = plan["best_recommendations_plan_3"] as? [[String: Any]] {
//                                for recommendationData in recommendations {
//                                    if let recommendation = createRecommendation(from: recommendationData) {
//                                        DispatchQueue.main.async {
//                                            self.recommendationsPlan3.append(recommendation)
//                                        }
//                                    }
//                                }
//                            }
//                        }
//                    }
//                } catch {
//                    print("JSON serialization error: \(error.localizedDescription)")
//                }
//            }
//        }.resume()
//    }
//    
//    
//    
//    func createRecommendation(from data: [String: Any]) -> Recommendation? {
//        guard let hotel = data["Hotel"] as? String,
//              let image = data["Image"] as? String,
//              let location = data["Location"] as? String,
//              let place = data["Place"] as? String,
//              let restaurant = data["Restaurant"] as? String,
//              let totalCost = data["Total Cost"] as? Int else {
//            return nil
//        }
//        
//        return Recommendation(hotel: hotel, Image: image, location: location, place: place, Restaurant: restaurant, TotalCost: "\(totalCost)")
//    }
//}
//
//struct Recommendation: Codable, Hashable {
//    let hotel: String
//    let Image: String
//    let location: String
//    let place: String
//    let Restaurant: String
//    let TotalCost: String
//}
//
//struct RecommendationView: View {
//    let recommendation: Recommendation
//    
//    var body: some View {
//       
//        ZStack(alignment: .center) {
//            let shape = RoundedRectangle(cornerRadius: 20)
//            shape.fill().foregroundColor(Color.gray.opacity(0.01))
//            
//            
//            VStack {
//                HStack {
//                    Text("Day 1")
//                        .font(.headline)
//                        .foregroundColor(.black)
//                        .padding(.top, 10)
//                        .padding(.leading, 10) // Align to the left
//                    Spacer()// Pushes text to the left
//                    
//                    Text(recommendation.location)
//                        .font(.headline)
//                        .foregroundColor(Color(red: 0.043, green: 0.725, blue: 0.753))
//                        .padding(.top, 10)
//                        .padding(.trailing, 10) // Align to the left
//                }
//                
//                VStack {
//                    Image(recommendation.Image)
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(maxWidth: .infinity) // Stretches horizontally
//                        .padding(.horizontal, 10)
//                        .padding(.vertical, 5) // Add padding to the image
//                }
//                .background(Color.white) // Add a white background for the image container
//                .cornerRadius(10) // Round corners of the image container
//                
//                
//                HStack{
//                    
//                    
//                    VStack {
//                        
//                        Text("Hotel: \(recommendation.hotel)") // Replace with your card number
//                            .font(.callout)
//                        
//                        Text("Restorant:  \(recommendation.Restaurant)") // Replace with your card number
//                            .font(.callout)
//                        
//                    }.frame(height:30)
//                        .padding(.top, 5)
//                        .foregroundColor(Color(red: 0, green: 0.243, blue: 0.502))
//                    Spacer()
//                    Text("90 $")
//                        .font(.headline)
//                        .foregroundColor(Color(red: 0.043, green: 0.725, blue: 0.753))
//                        .padding(.top, 10)
//                        .padding(.trailing, 10) // Align to the left
//                }
//                
//                
//            }
//            .padding(10) // Add padding for the whole content
//            
//        }
//        .frame(height: 170) // Adjust the height as needed
//        
//        .background(Color.white) // Add a white background to the entire card
//        .cornerRadius(20) // Round corners of the card
//        .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 0) // Add a shadow effect
//        .padding(.horizontal, 40)
//        .padding(.vertical, 10)
//    }
//}
//
//struct ContentView5_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView5()
//    }
//}
