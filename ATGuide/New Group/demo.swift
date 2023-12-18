//import SwiftUI
//
//struct ContentView4: View {
//    @State private var firstThreePlans: [[Recommendation]] = []
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                ForEach(firstThreePlans.indices, id: \.self) { index in
//                    Section(header: Text("Plan \(index + 1)")) {
//                        if !firstThreePlans[index].isEmpty {
//                            ForEach(firstThreePlans[index], id: \.self) { recommendation in
//                                VStack(alignment: .leading) {
//                                    Text("Hotel: \(recommendation.hotel)")
//                                    Text("Location: \(recommendation.location)")
//                                    Text("Place: \(recommendation.place)")
//                                    // Add other properties as needed
//                                }
//                                .padding()
//                                .background(Color.gray.opacity(0.1))
//                                .cornerRadius(10)
//                                .padding(.vertical, 5)
//                            }
//                        } else {
//                            Text("No recommendations for Plan \(index + 1)")
//                                .padding()
//                                .foregroundColor(.gray)
//                        }
//                    }
//                }
//            }
//            .navigationTitle("Recommendations")
//            .onAppear {
//                fetchData()
//            }
//        }
//    }
//
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
//                ["city": "Cairo", "days": 1],
//                ["city": "Alexandria", "days": 1],
//                ["city": "Luxor", "days": 1]
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
//               if let error = error {
//                   print("Error: \(error.localizedDescription)")
//                   return
//               }
//
//               guard let httpResponse = response as? HTTPURLResponse else {
//                   print("Invalid response")
//                   return
//               }
//
//               print("HTTP Status Code: \(httpResponse.statusCode)")
//
//               if let data = data {
//                   do {
//                       if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
//                        
//                           if let firstPlan = jsonResponse.last(where: { $0.keys.contains("best_recommendations_plan_1") }) {
//                               if let recommendations = firstPlan["best_recommendations_plan_1"] as? [[String: Any]] {
//                                   for recommendation in recommendations {
//                                       if let hotel = recommendation["Hotel"] as? String,
//                                           let location = recommendation["Location"] as? String,
//                                           let place = recommendation["Place"] as? String,
//                                            let Image = recommendation["Image"] as? String{
//                                           print("Hotel: \(hotel), Location: \(location), Place: \(place), image: \(Image)")
//                                           // Access other properties as needed
//                                       }
//                                   }
//                               }
//                           }
//                       }
//                   } catch {
//                       print("JSON serialization error: \(error.localizedDescription)")
//                   }
//               }
//           }.resume()
//       
//    }
//    
// 
//}
//
//struct Recommendation: Codable, Hashable {
//    let hotel: String
//    let location: String
//    let place: String
//    let Image: String
//    let Restaurant: String
//    let TotalCost: String
//}
//
//
//struct ContentView4_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView4()
//    }
//}
