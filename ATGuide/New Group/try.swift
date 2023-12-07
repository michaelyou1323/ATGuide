import SwiftUI
import Combine



struct Currency: Codable {
    let name: String
    let code: String
    // Add other properties as needed
}



struct CurrenciesResponse: Codable {
    let status: Int
    let msg: String?
    let results: [Currency]
}

struct ContentView2: View {
    @State private var currencies: [Currency] = []

    

    func fetchData() {
        let headers = [
            "X-RapidAPI-Key": "fd2ecd8edfmsh2d4087af4cccd54p1cb248jsnd0edafdaa13b",
            "X-RapidAPI-Host": "tourist-attraction.p.rapidapi.com"
        ]

        guard let url = URL(string: "https://tourist-attraction.p.rapidapi.com/currencies") else {
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
            } else if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode(CurrenciesResponse.self, from: data)
                    
                    DispatchQueue.main.async {
                        self.currencies = decodedData.results
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }
        dataTask.resume()
    }
    
    var body: some View {
          NavigationView {
              List(currencies.prefix(3), id: \.code) { currency in
                  Text("\(currency.code): \(currency.name)")
              }
              .navigationTitle("Currencies")
          }
          .onAppear {
              fetchData()
          }
      }
  }


struct ContentView2_Previews: PreviewProvider {
    static var previews: some View {
        ContentView2()
    }
}
 
