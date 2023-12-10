import SwiftUI

struct ContentView3: View {
    @State private var recommendations: [BestRecommendationsPlan] = []

    var body: some View {
        List(recommendations, id: \.plan) { recommendation in
            VStack(alignment: .leading) {
                Text("Hotel: \(recommendation.plan["Day 1"]?.hotel ?? "")")
                Text("Place: \(recommendation.plan["Day 1"]?.place ?? "")")
                Text("Restaurant: \(recommendation.plan["Day 1"]?.restaurant ?? "")")
                Text("Total Cost: \(recommendation.plan["Day 1"]?.totalCost ?? 0)")
            }
        }
        .onAppear {
            fetchData()
        }
    }

    func fetchData() {
        if let url = URL(string: "https://c761-156-210-170-81.ngrok-free.app/recommendations/culture_places/5000/5") {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("Error: \(error)")
                } else if let data = data {
                    if let stringResponse = String(data: data, encoding: .utf8) {
                        print("Response: \(stringResponse)")
                    } else {
                        print("Response is not a valid UTF-8 string")
                    }
                    // Attempt JSON decoding here
                    do {
                        let decodedData = try JSONDecoder().decode([RecommendationResponse].self, from: data)
                        DispatchQueue.main.async {
                            self.recommendations = decodedData.flatMap { $0.bestRecommendationsPlans }
                        }
                    } catch {
                        print("Error decoding JSON: \(error)")
                    }
                }
            }.resume()
        }
    }
}

struct RecommendationResponse: Decodable {
    let bestRecommendationsPlans: [BestRecommendationsPlan]

    private enum CodingKeys: String, CodingKey {
        case bestRecommendationsPlans = "best_recommendations_plans"
    }
}

struct BestRecommendationsPlan: Decodable {
    let plan: [String: Day]

    struct Day: Decodable, Identifiable, Hashable {
        let id = UUID()
        let hotel: String
        let place: String
        let restaurant: String
        let totalCost: Int

        private enum CodingKeys: String, CodingKey {
            case hotel = "Hotel"
            case place = "Place"
            case restaurant = "Restaurant"
            case totalCost = "Total Cost"
        }

        // Equatable conformance
        static func ==(lhs: BestRecommendationsPlan.Day, rhs: BestRecommendationsPlan.Day) -> Bool {
            return lhs.id == rhs.id
        }

        // Hashable conformance
        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
    }
}

// Preview


// Preview
#Preview {
    ContentView3()
}
