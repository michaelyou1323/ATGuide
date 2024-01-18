import SwiftUI
import SDWebImageSwiftUI

struct DetailsView: View {
    
    @State private var hotelData: HotelData?
    @State private var placeData: PlaceData?
    @State private var restaurantData: RestaurantData?
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                if let hotelData = hotelData {
//                    HotelDetailsView(data: hotelData)
                    Text(hotelData.name)
                }
                // Display hotel data
                if let hotelData = hotelData {
                    DetailsCardView(title: "Hotel", data: hotelData)
                }
                
                // Display place data
                if let placeData = placeData {
                    DetailsCardView(title: "Place", data: placeData)
                }
                
                // Display restaurant data
                if let restaurantData = restaurantData {
                    DetailsCardView(title: "Restaurant", data: restaurantData)
                }
                
                // Fetch data from the API
                
            }
            .padding()
        }
        .onAppear(perform: {
            fetchData()
        })
    }
    
    func fetchData() {
           guard let url = URL(string: "https://ee69-105-36-31-83.ngrok-free.app/get_details") else {
               return
           }
           
           let body: [String: Any] = [
               "place_name": "Egyptian Museum, Cairo",
               "hotel_name": "Nile Hilton Hotel",
               "restaurant_name": "Nile View Restaurant - Cairo",
               "place_type": "culture_places"
           ]
           
           do {
               let jsonData = try JSONSerialization.data(withJSONObject: body)
               
               var request = URLRequest(url: url)
               request.httpMethod = "POST"
               request.httpBody = jsonData
               request.setValue("application/json", forHTTPHeaderField: "Content-Type")
               
               URLSession.shared.dataTask(with: request) { data, response, error in
                   guard let data = data, error == nil else {
                       return
                   }
                   
                   do {
                       let decodedData = try JSONDecoder().decode(APIResponse.self, from: data)
                       
                       DispatchQueue.main.async {
                           self.hotelData = decodedData.hotel
                           self.placeData = decodedData.place
                           self.restaurantData = decodedData.restaurant
                       }
                   } catch {
                       print(error.localizedDescription)
                   }
               }.resume()
           } catch {
               print(error.localizedDescription)
           }
       }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
      DetailsView()
    }
}

struct DetailsCardView: View {
    let title: String
    let data: Any
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
            
            if let hotelData = data as? HotelData {
                HotelDetailsView(data: hotelData)
            } else if let placeData = data as? PlaceData {
                PlaceDetailsView(data: placeData)
            } else if let restaurantData = data as? RestaurantData {
                RestaurantDetailsView(data: restaurantData)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

struct HotelDetailsView: View {
    let data: HotelData
    
    var body: some View {
        // Implement your HotelDetailsView UI here using data
        Text(data.name)
    }
}

struct PlaceDetailsView: View {
    let data: PlaceData
    
    var body: some View {
        // Implement your PlaceDetailsView UI here using data
        Text(data.name)
    }
}

struct RestaurantDetailsView: View {
    let data: RestaurantData
    
    var body: some View {
        // Implement your RestaurantDetailsView UI here using data
        Text(data.name)
    }
}
