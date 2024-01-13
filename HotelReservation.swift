//
//  HotelReservation.swift
//  ATGuide
//
//  Created by Michaelyoussef on 06/01/2024.
//

import SwiftUI

struct HotelDetails: Identifiable {
    let id = UUID()
    let name: String
    let image: String
    let location: String
}

struct HotelReservationCardWithPayment: View {
    var hotelDetail: HotelDetails
//    var recommendation: Recommendation // Assuming Recommendation is your model
    @State private var cardNumber = ""
    @State private var cardName = ""
    @State private var expiryDate = ""
    @State private var cvv = ""
    
  
    //@State private var isCVVValid = true
    @State private var roomCount = 0
    @State private var bedsCount = "Single"
    @State private var singleBedSelected = false
    
    @State private var isValid: Bool?
    @State private var errorMessage: String?
    
    
    var body: some View {
        
      
        
        VStack(alignment: .leading, spacing: 12) {
            //  Image("\(hotelDetail.image)")
            VStack{
                AsyncImage(url: URL(string: convertGoogleDriveLinkToDirectImageURL(googleDriveLink: hotelDetail.image) ?? ""))
                {
                    phase in
                    switch phase {
                    case.empty:
                        Image("a-hero-image")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 150)
                            .clipped()
                            .cornerRadius(12)
                    case.success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 150)
                            .clipped()
                            .cornerRadius(12)
                    case.failure:
                        Image("a-hero-image")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 150)
                            .clipped()
                            .cornerRadius(12)
                        //                                 @unknown default:
                        //                                     EmptyView()
                    @unknown default:
                        fatalError()
                    }
                    
                }
                
            }
           
            .frame(height: 150)
            .clipped()
            .cornerRadius(12)
           // recommendation.
            Text("\(hotelDetail.name)")
                .font(Font.custom("Charter-Black", size: 25))
                      .fontWeight(.bold)
                      .foregroundColor(Color(red: 0.043, green: 0.725, blue: 0.753))
                      
            
            //recommendation.
            Text("\(hotelDetail.location)")
                      .font(.subheadline)
                      .foregroundColor(.gray)
                  
                  HStack {
                      Text("Total Cost: ")
                          .font(.subheadline)
                      
                      // recommendation.
                      Text("30 $")
                          .font(.subheadline)
                          .fontWeight(.bold)
                          .foregroundColor(Color(red: 0, green: 0.243, blue: 0.502))
                  }
                  
            
                  Divider()
                  
            HStack {
                Text("Room")
                Spacer()
                
                Button(action: {
                    incrementRoomCount()
                }) {
                    Image(systemName: "plus.circle")
                        .foregroundColor(Color(red: 0.192, green: 0.259, blue: 0.333))
                }
                .buttonStyle(BorderlessButtonStyle())
                
                Text("\(roomCount)")
                    .padding(.horizontal, 10)
                
                Button(action: {
                    decrementRoomCount()
                }) {
                    Image(systemName: "minus.circle")
                        .foregroundColor(Color(red: 0.192, green: 0.259, blue: 0.333))
                }
                .buttonStyle(BorderlessButtonStyle())
            }
            .listRowBackground(Color.clear)
            .contentShape(RoundedRectangle(cornerRadius: 20))
            
            HStack {
                Text("Beds")
                Spacer()
                
                Button(action: {
                    if !singleBedSelected {
                        selectSingleBed()
                    }
                }) {
                    Text("Single")
                        .padding(.horizontal, 10)
                        .foregroundColor(singleBedSelected ? .gray : Color(red: 0.192, green: 0.259, blue: 0.333))
                }
                .buttonStyle(BorderedButtonStyle())
                .disabled(singleBedSelected)
                
                Button(action: {
                    if singleBedSelected {
                        selectDoubleBed()
                    }
                }) {
                    Text("Double")
                        .padding(.horizontal, 10)
                        .foregroundColor(singleBedSelected ? Color(red: 0.192, green: 0.259, blue: 0.333) : .gray)
                }
                .buttonStyle(BorderedButtonStyle())
                .disabled(!singleBedSelected)
            }
            .listRowBackground(Color.clear)
            .contentShape(RoundedRectangle(cornerRadius: 20))
            
                  VStack(alignment: .leading, spacing: 8) {
                      Text("Payment Information")
                          .font(.headline)
                          .fontWeight(.bold)
                          .foregroundColor(Color(red: 0.722, green: 0.275, blue: 0.114))
                      
                      TextField("Card Number", text: $cardNumber)
                          .textFieldStyle(RoundedBorderTextFieldStyle())
                          .onChange(of: cardNumber) { newValue in
                              // Remove non-numeric characters and format the card number
                              let cleanNumber = newValue.filter { $0.isNumber }
                              cardNumber = formatCardNumber(cleanNumber)
                          }
                      
                      HStack {
                          TextField("Expiry Date", text: $expiryDate)
                              .textFieldStyle(RoundedBorderTextFieldStyle())
                              .onChange(of: expiryDate) { newValue in
                                  let filteredValue = newValue.filter { $0.isNumber }
                                  let formattedValue = formatExpiryDate(filteredValue)
                                  expiryDate = formattedValue
                              }
                              .onReceive(expiryDate.publisher.collect()) { string in
                                  if string.count > 5 {
                                      expiryDate = String(string.prefix(5))
                                  }
                              }

                          Spacer()
                          
                          TextField("CVV", text: $cvv)
                              .textFieldStyle(RoundedBorderTextFieldStyle())
                              .onChange(of: cvv) { newValue in
                                  let filteredValue = newValue.filter { $0.isNumber }
                                  cvv = String(filteredValue.prefix(3)) // Assuming CVV is 3 digits long
                                  
                                  // Validate the CVV length
                                //  isCVVValid = filteredValue.count == 3
                              }
                             
                              
                      }
                      
                      TextField("Card Holder Name", text: $cardName)
                          .textFieldStyle(RoundedBorderTextFieldStyle())
                  }
                  .padding(.vertical)
                  .padding(.bottom,0)
            
            HStack() {
                               Spacer()
                               Button(action: {
                                   fetchData()
                               }) {
                                   Text("Book Now")
                                       .frame(maxWidth: .infinity)
                                       .padding()
                                       .foregroundColor(.white)
                                       .background(Color(red: 0.192, green: 0.259, blue: 0.333) )
                                       .cornerRadius(10)
                               }
                               .padding(.leading, 170)
                           }
                       }
                       .padding()
                       .background(Color.white)
                       .cornerRadius(12)
                       .shadow(color: Color.gray.opacity(0.4), radius: 4, x: 0, y: 2)
                       .sheet(isPresented: Binding<Bool>(get: {
                           if let isValid = isValid {
                               return isValid
                           }
                           return false
                       }, set: { _ in })) {
                           if isValid == true {
                               PaymentSuccessCard()
                           } else {
                               PaymentFailedCard()
                           }
                       }
                   }
               
    
  

    
    func incrementRoomCount() {
        roomCount += 1
    }

    // Function to decrement the room count
    func decrementRoomCount() {
        if roomCount > 0 {
            roomCount -= 1
        }
    }
    
    
 


    // Function to select Single bed
    func selectSingleBed() {
        singleBedSelected = true
    }

    // Function to select Double bed
    func selectDoubleBed() {
        singleBedSelected = false
    }
    
    
    
    func formatCardNumber(_ number: String) -> String {
        let trimmed = String(number.prefix(16)) // Limit the card number to 16 characters
        var formattedNumber = ""
        var index = trimmed.startIndex
        
        while index < trimmed.endIndex {
            let endIndex = trimmed.index(index, offsetBy: 4, limitedBy: trimmed.endIndex) ?? trimmed.endIndex
            formattedNumber += trimmed[index..<endIndex] + " "
            index = endIndex
        }
        
        return String(formattedNumber.dropLast()) // Remove the trailing space
    }

    func formatExpiryDate(_ value: String) -> String {
        var formattedDate = value
        if formattedDate.count > 2 {
            formattedDate.insert("/", at: formattedDate.index(formattedDate.startIndex, offsetBy: 2))
        }
        return String(formattedDate.prefix(5))
    }
    
    
    struct PaymentSuccessCard: View {
           var body: some View {
               Text("Payment Successful!")
                   .font(.title)
                   .foregroundColor(.green)
           }
       }

       struct PaymentFailedCard: View {
           var body: some View {
               Text("Payment Failed. Please try again.")
                   .font(.title)
                   .foregroundColor(.red)
           }
       } 
    
    func fetchData() {
        guard let url = URL(string: "https://a11f-156-210-179-212.ngrok-free.app/pay") else {
            setError("Invalid URL")
            return
        }
     //   "4444333388882222", "12/24", "William Black", "789"
        let requestData = """
        {
            "number": "\(cardNumber)",
            "e_date": "\(expiryDate)",
            "holder_name": "\(cardName)",
            "cvv": "\(cvv)"
        }
        """.data(using: .utf8)

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = requestData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                setError("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            // Debugging: Print raw response data
            print(String(data: data, encoding: .utf8) ?? "")

            do {
                let decodedResponse = try JSONDecoder().decode(APIResponse.self, from: data)
                DispatchQueue.main.async {
                    self.isValid = decodedResponse.isValid
                }
            } catch {
                setError("Decoding error: \(error.localizedDescription)")
            }
        }.resume()
    }

    func setError(_ message: String) {
        DispatchQueue.main.async {
            self.errorMessage = message
        }
    }
    struct APIResponse: Codable {
        let isValid: Bool

        enum CodingKeys: String, CodingKey {
            case isValid = "is_valid"
        }
    }
}











struct HotelReservation: View {
    @State private var showDetailsSheet = false
    let hotelsDetails: [HotelDetails]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(hotelsDetails) { hotelDetail in
                    HotelReservationCardWithPayment(hotelDetail: hotelDetail)
                        .padding(.horizontal)
                        .onLongPressGesture {
                            showDetailsSheet.toggle()
                                        }
                }
//                .sheet(isPresented: $showDetailsSheet) {
//                           // Your floating screen view to show details
//                    FloatingDetailsView(details: hotelsDetails.description)
//                       }
            }
            .padding(.vertical)
        }
        
        
        
    }
}



#Preview {
    HotelReservation(hotelsDetails: [])
}