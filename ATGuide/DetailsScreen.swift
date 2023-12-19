//
//  DetailsScreen.swift
//  ATGuide
//
//  Created by Michaelyoussef on 05/12/2023.
//

import SwiftUI

struct DetailsScreen: View {
    
    let TripType: String
    let budget: Double
    var selectedDaysList: [[String: Any]]
    var PlanNumber: Int
   
    
//    var tripPlan: TripPlan
      @State private var isFavorite = false
   
    @State private var recommendationsPlan1: [Recommendation] = []
    @State private var recommendationsPlan2: [Recommendation] = []
    @State private var recommendationsPlan3: [Recommendation] = []
   
    var body: some View {
        VStack() {
            HStack {
                Spacer()
                Text("Plan Details")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 0, green: 0.243, blue: 0.502))
                    .padding(.leading, 60)
                
                
                Spacer()
                Button(action: {
                    isFavorite.toggle()
                }) {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .foregroundColor(isFavorite ? .red : .gray)
                        .font(.title)
                }
                .padding()
            }
//            .onAppear(){
//                fetchData()
//            }
            .frame(height:25)
         
            
            
            ScrollView{
                
               
                
                VStack(spacing: 20) {
                    
              
                    ForEach(selectedRecommendationPlan(), id: \.self) { recommendation in
                        RecommendationView(recommendation: recommendation)
                            .id(UUID()) // Force view update
                    }
                    
       
                    
                }
            }
            .navigationTitle("")
            .onAppear(){
                print(TripType,budget, selectedDaysList)
            }
         
            
        }
        .onAppear {
            fetchData()
        }
        
    }
    func selectedRecommendationPlan() -> [Recommendation] {
        if PlanNumber == 0 {
            return recommendationsPlan1
        } else if PlanNumber == 1  {
            return recommendationsPlan2
        } else {
            return recommendationsPlan3
        }
    }
    func fetchData() {
        guard let url = URL(string: "https://f769-197-54-160-20.ngrok-free.app/recommendations") else {
            return
        }

        let body: [String: Any] = [
            "place_type": TripType,
            "budget": budget,
            "city_day":selectedDaysList
        ]

        let jsonData = try? JSONSerialization.data(withJSONObject: body)

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response")
                return
            }

            print("HTTP Status Code: \(httpResponse.statusCode)")

            if let data = data {
                do {
                    if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                        for plan in jsonResponse {
                            if let recommendations = plan["best_recommendations_plan_1"] as? [[String: Any]] {
                                for recommendationData in recommendations {
                                    if let recommendation = createRecommendation(from: recommendationData) {
                                        DispatchQueue.main.async {
                                            self.recommendationsPlan1.append(recommendation)
                                            print(recommendationsPlan1)
                                        }
                                    }
                                }
                            } else if let recommendations = plan["best_recommendations_plan_2"] as? [[String: Any]] {
                                for recommendationData in recommendations {
                                    if let recommendation = createRecommendation(from: recommendationData) {
                                        DispatchQueue.main.async {
                                            self.recommendationsPlan2.append(recommendation)
                                        }
                                    }
                                }
                            } else if let recommendations = plan["best_recommendations_plan_3"] as? [[String: Any]] {
                                for recommendationData in recommendations {
                                    if let recommendation = createRecommendation(from: recommendationData) {
                                        DispatchQueue.main.async {
                                            self.recommendationsPlan3.append(recommendation)
                                        }
                                    }
                                }
                            }
                        }
                    }
                } catch {
                    print("JSON serialization error: \(error.localizedDescription)")
                }
            }
        }.resume()
    }
    
    
    func createRecommendation(from data: [String: Any]) -> Recommendation? {
        
        guard let hotel = data["Hotel"] as? String,
              let image = data["Image"] as? String,
              let location = data["Location"] as? String,
              let place = data["Place"] as? String,
              let restaurant = data["Restaurant"] as? String,
              let totalCost = data["Total Cost"] as? Int else {
            
            return nil
        }
        

       
           return Recommendation(hotel: hotel, Image: image, location: location, place: place, Restaurant: restaurant, TotalCost: "\(totalCost)")
    }
    
   
    
  
    
}


func convertGoogleDriveLinkToDirectImageURL(googleDriveLink: String) -> String? {
    // Extract the file ID from the Google Drive link
    guard let fileID = extractFileID(from: googleDriveLink) else {
        return nil
        
        
    }

    // Construct the direct link to the image file (assuming it's a JPEG image)
    let directImageURL = "https://drive.google.com/uc?id=\(fileID)"

    return directImageURL
}

func extractFileID(from googleDriveLink: String) -> String? {
    // Example Google Drive link format: https://drive.google.com/file/d/1cnuiVDyu5-ZqoVB2ReOXfVuJF1X6Cp05/view?usp=drive_link
    // Extract the file ID between "/d/" and "/view"
    if let startIndex = googleDriveLink.range(of: "/d/")?.upperBound,
       let endIndex = googleDriveLink.range(of: "/view")?.lowerBound {
        let fileID = String(googleDriveLink[startIndex..<endIndex])
        return fileID
    }

    return nil
}


struct Recommendation: Codable, Hashable {
    let hotel: String
    let Image: String
    let location: String
    let place: String
    let Restaurant: String
    let TotalCost: String
}

struct RecommendationView: View {
    let recommendation: Recommendation
    
    var body: some View {
       
        ZStack(alignment: .center) {
            let shape = RoundedRectangle(cornerRadius: 20)
            shape.fill().foregroundColor(Color.gray.opacity(0.01))
            
            
            VStack{
                HStack{
                    
                    
                    
                    
                    VStack{
                        Text("Day" )
                            .font(.headline)
                            .foregroundColor(.black)
                            .padding(.top, 10)
                            .padding(.leading, 10) // Align to the left
                        
                        Spacer()
                        Text(recommendation.location)
                            .font(.headline)
                            .foregroundColor(Color(red: 0.043, green: 0.725, blue: 0.753))
                            .padding(.top, 10)
                            .padding(.leading, 10) // Align to the left
                        Spacer()
                    }
                    .frame(minWidth: 100)
                    Spacer()
//                    HStack{
                        AsyncImage(url: URL(string: convertGoogleDriveLinkToDirectImageURL(googleDriveLink: "recommendation.Image") ?? ""))
                          {
                        phase in
                                 switch phase {
                                 case.empty:
                                     ProgressView()
                                 case.success(let image):
                                     image
                                         .resizable()
                                         .aspectRatio(contentMode: .fit)
                                 case.failure:
                                     Image("1024 1")
                                         .resizable()
                                         .aspectRatio(contentMode: .fit)
                                 @unknown default:
                                     EmptyView()
                                 }
                      
                             }
                        .cornerRadius(20)
                        .frame(minWidth: 150,maxHeight: 150)
                       
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                       
                    
                  
                    
//                    }
//
               
                    
                }
                
                HStack(alignment: .top){
                    
                    HStack(alignment: .center){
                        
                        
                        VStack(alignment: .leading) {
                            
                            Text("Hotel: \(recommendation.hotel)") // Replace with your card number Replace with your card number
                                .font(.system(size: 13))
                               
                             
                            Text("Restorant: \(recommendation.Restaurant) ")// Replace with your card number
                                .font(.system(size: 13))
                                .multilineTextAlignment(.center)
                              
                            
                        }.frame(minWidth: 280, minHeight:80)
                            .padding(.top, 1)
                          
                            .foregroundColor(Color(red: 0, green: 0.243, blue: 0.502))
                            
                        Spacer()
                        ZStack{
                            
                            let shape = RoundedRectangle(cornerRadius: 8)
                            shape.fill().foregroundColor(Color.gray.opacity(0.01))
                            shape.stroke(Color.gray, lineWidth: 1)
                            
                            
                            Text(" \(recommendation.TotalCost) $")
                                .font(.headline)
                                .foregroundColor(Color(red: 0.043, green: 0.725, blue: 0.753))
                               // Align to the left
                        }
                        .frame(width: 50, height:30)
                       
                    }
                    .padding(.horizontal,5)
                }
              
            }.cornerRadius(20)
             
            
        }
        .frame(height: 240) // Adjust the height as needed
        
        .background(Color.white) // Add a white background to the entire card
        .cornerRadius(20) // Round corners of the card
        .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 0) // Add a shadow effect
        .padding(.horizontal, 20)
        .padding(.vertical, 5)
       
    }
}

struct DetailsScreen_Previews: PreviewProvider {
    static var previews: some View {
        DetailsScreen(TripType: "culture_places", budget: 89898, selectedDaysList:[
            [
            "city":"Cairo", 
            "days":4
            ],
            [
            "city":"Alexandria",
            "days":15
            ],
             [
            "city":"Luxor",
            "days":1
            ]

        ] , PlanNumber: 0)
    }
}
 
