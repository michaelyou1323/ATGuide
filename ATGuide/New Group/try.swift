import SwiftUI

struct Plan2: Codable, Identifiable{
    let id = UUID()
    var title: String
    var body: String
 
}

class Api {
    func getPlans(){
        let url = URL(string: "https://8422-197-54-130-239.ngrok-free.app/recommendations/culture_places/5000/9")
        URLSession.shared.dataTask(with: url!) { (data, _, _) in
            let plans = try! JSONDecoder().decode([Plan2].self, from: data!)
        }
        .resume()
    }
}

struct ContentView2: View {
  //  @State private var recommendations: [BestRecommendationsPlan] = []

    var body: some View {
        
        Text("mmm")
            .onAppear{
                Api().getPlans()
            }

    }
}

struct ContentView2_Previews: PreviewProvider {
    static var previews: some View {
        ContentView2()
    }
}

