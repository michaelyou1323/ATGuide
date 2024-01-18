//
//  HotelReservation.swift
//  ATGuide
//
//  Created by Michaelyoussef on 06/01/2024.
//

import SwiftUI
import FirebaseDatabaseInternal

struct HotelDetails: Identifiable {
    let id = UUID()
    let name: String
    let image: String
    let location: String
    let hotelCost: Double

}

struct HotelReservationCardWithPayment: View {
    
    var hotelDetail: HotelDetails
    let numberOfUser: Int
    
    let TripType: String
    let budget: Double
    var selectedDaysList: [[String: Any]]
    var PlanNumber: Int
    var HotelStars: Int
    let userID: String
    let planId: String
    let Image2: String
    let selectNumberOfPersons: Int
//    var recommendation: Recommendation // Assuming Recommendation is your model
    @State private var cardNumber = ""
    @State private var cardName = ""
    @State private var expiryDate = ""
    @State private var cvv = ""
    
  
    //@State private var isCVVValid = true
    @State private var roomCount = 0.0
    @State private var totalCost = 0.0
    @State private var bedCount = 1.0
    @State private var bedsCount = "Single"
    @State private var singleBedSelected = true
    
    @State private var isValid: Bool?
    @State private var errorMessage: String?
    @State private var isLoading = false
    
    @State private var isShowingResult = false
    @State private var isShowingPopup = false
    @State private var isPaymentDone = false
    var body: some View {
        
        ZStack{
            
            VStack(alignment: .leading, spacing: 12) {
                //  Image("\(hotelDetail.image)")
                HStack(alignment: .center){
                    Spacer()
                    AsyncImage(url: URL(string: convertGoogleDriveLinkToDirectImageURL(googleDriveLink: hotelDetail.image) ?? ""))
                    {
                        phase in
                        switch phase {
                        case.empty:
                            ProgressView {
                                Image("hotel-3d-icon-illustrations")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 90, height: 100)
                            }
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
                    Spacer()
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
                    
                    Text(NumberFormatter.localizedString(from: NSNumber(value: roomCount), number: .decimal))
                                   .font(.subheadline)
                                   .fontWeight(.bold)
                                   .foregroundColor(Color(red: 0, green: 0.243, blue: 0.502))
                    
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
                    
                    Spacer()
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
                        .keyboardType(.numberPad)
                        .onChange(of: cardNumber) {
                            // Remove non-numeric characters and format the card number
                            let cleanNumber = cardNumber.filter { $0.isNumber }
                            cardNumber = formatCardNumber(cleanNumber)
                        }
                    
                    HStack {
                        TextField("Expiry Date", text: $expiryDate)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.decimalPad)
                            .onChange(of: expiryDate) {
                                let filteredValue = expiryDate.filter { $0.isNumber }
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
                            .keyboardType(.decimalPad)
                            .onChange(of: cvv) {
                                let filteredValue = cvv.filter { $0.isNumber }
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
                
                HStack {
                    Text("Total Cost: ")
                        .font(.subheadline)
                    
                    // recommendation.
                    Text(String(format: "$%.2f", totalCost))
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 0, green: 0.243, blue: 0.502))
                }
                HStack() {
                    Spacer()
                    Button(action: {
                        fetchDataWithLoading()
//                        isShowingPopup = true
                    }) {
                        Text("Book Now")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color(red: 0.192, green: 0.259, blue: 0.333))
                            .cornerRadius(10)
                    }
                    .padding(.leading, 170)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .shadow(color: Color.gray.opacity(0.4), radius: 4, x: 0, y: 2)
                
            }
           
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            .shadow(color: Color.gray.opacity(0.4), radius: 4, x: 0, y: 2)
            .opacity(isPaymentDone ? 0.4 : 1)
            .disabled(isPaymentDone ? true : false)
//            .overlay(
//                
//                CustomPopup(isShowingPopup: $isShowingPopup, isValid: isValid ?? false)
//                    .opacity(isShowingPopup ? 1 : 0)
//                
//            )
            
            if isLoading {
                         ProgressView()
                             .progressViewStyle(CircularProgressViewStyle(tint: Color.blue))
                             .scaleEffect(2) // Adjust the scale as needed
                             .opacity(isLoading ? 1 : 0)
                     }

                     if isShowingPopup {
                         CustomPopup(isShowingPopup: $isShowingPopup, isPaymentDone: $isPaymentDone, isValid: isValid ?? false)
                     }
//            if isPaymentDone {
//                
//             
//                    
//                    VStack{
//                        Spacer()
//                        
//                        //                    Text("😊")
//                        //                        .font(.system(size: 45))
//                        
//                        Image(systemName: "checkmark.circle.fill")
//                            .font(.system(size: 60))
//                            .foregroundColor(.green)
//                        // .foregroundColor(.white)
//                        
//                        Text( "Great news! Your reservation is confirmed. We look forward to welcoming you!")
//                            .font(.system(size: 18))
//                            .foregroundColor(.green)
//                            .padding()
//                            .multilineTextAlignment(.center)
//                        
//                        Spacer()
//                        HStack{
//                            
//                            //                        Button("Done") {
//                            //                            // Close the popup
//                            //                            isPaymentDone = true
//                            //                        }
//                            //                        .padding()
//                            //                        .foregroundColor( Color.white)
//                            //                        .background( Color.green)
//                            //                        .cornerRadius(10)
//                            //                        .shadow(color: Color.gray.opacity(0.8), radius: 4, x: 0, y: 2)
//                            //                        .padding(.horizontal,120)
//                            //                        .padding(.vertical,10)
//                        }
//                        // .frame(width: .infinity)
//                        .background(.green)
//                    }
//                    //                                .padding(.horizontal, 0)
//                    
//                    .background(.white)
//                    .cornerRadius(15)
//                    .shadow(color: Color.gray.opacity(0.8), radius: 4, x: 0, y: 2)
//                    .frame(height: 220)
//                    .padding(.horizontal,30)
//                }
                
            
            
            
        }
//                       .sheet(isPresented: Binding<Bool>(get: {
//                           if let isValid = isValid {
//                               return isValid
//                           }
//                           return false
//                       }, set: { _ in })) {
//                           if isValid == true {
//                               PaymentSuccessCard()
//                           } else {
//                               PaymentFailedCard()
//                           }
//                       }
                   }
               
    
    func fetchDataWithLoading() {
         // Show loading animation
        fetchData()
         isLoading = true
       
         // Simulate loading with a delay
         DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            
             // Hide loading animation
             isLoading = false
             // Show the result card
             isShowingPopup = true
         }
     }

    
    func incrementRoomCount() {
        roomCount += 1
        totalCost = roomCount*bedCount*hotelDetail.hotelCost
    }

    // Function to decrement the room count
    func decrementRoomCount() {
        if roomCount > 0 {
            roomCount -= 1
            totalCost = roomCount*bedCount*hotelDetail.hotelCost
        }
    }
    
    
 


    // Function to select Single bed
    func selectSingleBed() {
        singleBedSelected = true
        bedCount = 1
        totalCost = roomCount*bedCount*hotelDetail.hotelCost
    }

    // Function to select Double bed
    func selectDoubleBed() {
        singleBedSelected = false
        bedCount = 1.8
        totalCost = roomCount*bedCount*hotelDetail.hotelCost
    }
    
    
    
    func formatCardNumber(_ number: String) -> String {
        let trimmed = String(number.prefix(16)) // Limit the card number to 16 characters
        var formattedNumber = ""
        var index = trimmed.startIndex
        
        while index < trimmed.endIndex {
            let endIndex = trimmed.index(index, offsetBy: 4, limitedBy: trimmed.endIndex) ?? trimmed.endIndex
            formattedNumber += trimmed[index..<endIndex] + "-"
            index = endIndex
        }
        
        return String(formattedNumber.dropLast()) // Remove the trailing space
    }

    
    func removeDash(fromCardNumber cardNumber: String) -> String {
        return cardNumber.replacingOccurrences(of: "-", with: "")
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
        guard let url = URL(string: "https://ee69-105-36-31-83.ngrok-free.app/pay") else {
            setError("Invalid URL")
            return
        }
     //   "4444333388882222", "12/24", "William Black", "789"
        let requestData = """
        {
            "number": "\(removeDash(fromCardNumber: cardNumber))",
            "e_date": "\(expiryDate)",
            "holder_name": "\(cardName)",
            "cvv": "\(cvv)"
        }
        """.data(using: .utf8)

        print(removeDash(fromCardNumber: cardNumber))
        print(expiryDate)
        print(cardName)
        print(cvv)
        
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


struct CustomPopup: View {
    @Binding var isShowingPopup: Bool
    @Binding var isPaymentDone: Bool
    let isValid: Bool
  
    var body: some View {
//
        if isValid {
            
           
            VStack{
                Spacer()
                
                //                    Text("😊")
                //                        .font(.system(size: 45))
                
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.green)
                // .foregroundColor(.white)
                
                Text( "Great news! Your reservation is confirmed. We look forward to welcoming you!")
                    .font(.system(size: 18))
                    .foregroundColor(.green)
                    .padding()
                    .multilineTextAlignment(.center)
                
                Spacer()
                HStack{
                    
                    //                        Button("Done") {
                    //                            // Close the popup
                    //                            isPaymentDone = true
                    //                        }
                    //                        .padding()
                    //                        .foregroundColor( Color.white)
                    //                        .background( Color.green)
                    //                        .cornerRadius(10)
                    //                        .shadow(color: Color.gray.opacity(0.8), radius: 4, x: 0, y: 2)
                    //                        .padding(.horizontal,120)
                    //                        .padding(.vertical,10)
                }
                // .frame(width: .infinity)
                .background(.green)
            }
            //                                .padding(.horizontal, 0)
            .onAppear(perform: {
                isPaymentDone = true
            })
            .background(.white)
            .cornerRadius(15)
            .shadow(color: Color.gray.opacity(0.8), radius: 4, x: 0, y: 2)
            .frame(height: 220)
            .padding(.horizontal,30)
        }
        else{
            
            
            
            
            
            VStack{
                Spacer()
              
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .foregroundColor(Color.red)
                        .padding()
                    
              
                Text( "Payment Failed. Please try again." )
                    .font(.title)
                    .foregroundColor(.red)
                    .padding()
                
                Spacer()
                HStack{
                    
                    Button("Close") {
                        // Close the popup
                        isShowingPopup = false
                    }
                    .padding()
                    .foregroundColor(Color.white)
                    .background(.red)
                    .cornerRadius(10)
                    .shadow(color: Color.gray.opacity(0.8), radius: 4, x: 0, y: 2)
                    .padding(.horizontal,120)
                    .padding(.vertical,10)
                }
                // .frame(width: .infinity)
                .background(.white)
            }
            //                                .padding(.horizontal, 0)
            
            .background(.white)
            .cornerRadius(15)
            .shadow(color: Color.gray.opacity(0.8), radius: 4, x: 0, y: 2)
            .frame(height: 420)
            
        }
                                          
//
    }
}








struct HotelReservation: View {
    @State private var showDetailsSheet = false
    @State private var isPaymentDone = false
    
    let hotelsDetails: [HotelDetails]
    let numberOfUser: Int
    
    let TripType: String
    let budget: Double
    var selectedDaysList: [[String: Any]]
    var PlanNumber: Int
    var HotelStars: Int
    let userID: String
    let planId: String
    let Image2: String
    let selectNumberOfPersons: Int
    @State private var allHotelsReseerved = false
    
    var body: some View {
        NavigationStack{
            HStack {
                //Spacer()
                Text("Hotel Reservation")
                    .font(Font.custom("Charter-Black", size: 32))
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 0, green: 0.243, blue: 0.502))
                    .padding(.leading, 10)
                    .padding(.bottom,5)
                
                //
                
                
                Spacer()
                
                
                
                
                
            }
            
            .frame(height:25)
            
            VStack{
                
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(hotelsDetails) { hotelDetail in
                            
                            
                            HotelReservationCardWithPayment(hotelDetail: hotelDetail,
                                                            numberOfUser: 3,
                                                            TripType:TripType,
                                                            budget:budget,
                                                            selectedDaysList: selectedDaysList,
                                                            PlanNumber:PlanNumber,
                                                            HotelStars:HotelStars,
                                                            userID:userID,
                                                            planId:planId,
                                                            Image2:Image2,
                                                            selectNumberOfPersons:selectNumberOfPersons
                            )
                            .padding(.horizontal)
                            //                        .onLongPressGesture {
                            //                            showDetailsSheet.toggle()
                            //                                        }
                        }
                        //                .sheet(isPresented: $showDetailsSheet) {
                        //                           // Your floating screen view to show details
                        //                    FloatingDetailsView(details: hotelsDetails.description)
                        //                       }
                    }
                    .padding(.vertical)
                }
                .padding(.top,10)
                //                NavigationLink(destination: YourPlans().navigationBarBackButtonHidden(true), isActive: $allHotelsReseerved ) {
                //                    EmptyView()
                //                }
                
                Button(action: {
                    saveDataToFirebase()
                    allHotelsReseerved = true
                    //let details = tripHotelsDetails()
                    //  hotelsDetails = details // Store hotel details in the state
                    
                }) {
                    Text("Confirm")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .padding(.bottom,10)
                        .foregroundColor(Color(red: 0.192, green: 0.259, blue: 0.333) )
                        .background(Color(red: 0.043, green: 0.725, blue: 0.753))
                    //   #c65b25
                    //  .cornerRadius(10)
                    
                }
                .fullScreenCover(isPresented: $allHotelsReseerved) {
                    if let userData = getUserDataFromUserDefaults() {
                    
                        MainScreen(email: userData["email"] as? String ?? "",
                                   username: userData["name"] as? String ?? "",
                                   language: userData["language"] as? String ?? "",
                                   country: userData["country"] as? String ?? "", phone: userData["phonenumber"] as? String ?? "", userID:  userData["id"] as? String ?? "")
                    } else {
                        MainScreen(email: "", username: "", language: "", country: "", phone: "", userID: "")
                    }
                }
//                .navigationDestination(
//                    isPresented:$allHotelsReseerved) {
//                        // YourPlans(userID: "t17QMgg7C0QoRNr401O9Z93zTMl1").navigationBarBackButtonHidden(true)
//                        //                        MainScreen(email: " ", username: " ", language: " ", country: " ", phone: " ", userID: " ")
//                    }
//                    .padding(.top,7)
            }
            .ignoresSafeArea()
        }
        // .navigationBarBackButtonHidden(true)
        
    }
    
    func getUserDataFromUserDefaults() -> [String: Any]? {
            return UserDefaults.standard.dictionary(forKey: "userData")
        }
    
    private func saveDataToFirebase() {
        let database = Database.database()
        let plansRef = database.reference(withPath: "plans/\(userID)")
        
        let planData: [String: Any] = [
            "hotelsDetails": hotelsDetails.map { $0.dictionaryRepresentation },
            "numberOfUser": numberOfUser,
            "TripType": TripType,
            "budget": budget,
            "selectedDaysList": selectedDaysList,
            "PlanNumber": PlanNumber,
            "HotelStars": HotelStars,
            "userID": userID,
            "planId": planId,
            "Image2": Image2,
            "selectNumberOfPersons": selectNumberOfPersons
        ]
        
        plansRef.childByAutoId().setValue(planData) { error, _ in
            if let error = error {
                print("Error writing to Firebase: \(error.localizedDescription)")
            } else {
                print("Data written successfully to Firebase")
            }
        }
    }
}



extension HotelDetails {
    var dictionaryRepresentation: [String: Any] {
        return [
            "name": name,
            "image": image,
            "location": location,
            "hotelCost": hotelCost
        ]
    }
}


#Preview {
    HotelReservation(hotelsDetails: [ATGuide.HotelDetails( name: "Alexandria Coastal Lodge", image: "alexandria_coastal_lodge_image.jpg", location: "Alexandria", hotelCost: 200), ATGuide.HotelDetails( name: "Marsa Alam Beach Resort", image: "marsa_alam_beach_resort_image.jpg", location: "Marsa Alam",hotelCost: 350)], numberOfUser: 3,
                     TripType:"TripType",
                     budget:5666,
                     selectedDaysList: [
                        [
                        "city":"Marsa Alam",
                        "days":2
                        ],
                        [
                        "city":"Alexandria",
                        "days":2
                        ],
                         [
                        "city":"Luxor",
                        "days":2
                        ]

                    ] ,
                     PlanNumber:0,
                     HotelStars:4,
                     userID:"userID",
                     planId:"planId",
                     Image2:"Image2",
                     selectNumberOfPersons:4)
}
