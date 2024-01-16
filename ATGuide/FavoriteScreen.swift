import SwiftUI
import Firebase

struct FavoriteScreen: View {
    let userID: String
    var body: some View {
        PlansListView(userId: userID) // Pass the user ID here
    }
}

struct PlansListView: View {
    @ObservedObject var planViewModel: PlanViewModel
    @State private var selectedPlan: Plan? = nil
    @State private var favStatus = true
    
    init(userId: String) {
        self.planViewModel = PlanViewModel(userId: userId)
       
    }
    
    var body: some View {
    
        VStack {
            
            HStack {
               
                
              EmptyView()
              
            }
            .frame(height: 5)
            ScrollView {
                VStack(spacing: 10) {
                    ForEach(planViewModel.plans) { plan in
                       
                        NavigationLink(destination: DetailsScreen(TripType: plan.tripType,
                                                                  budget: Double(plan.budget),
                                                                  selectedDaysList: convertStringToArray(plan.selectedDaysList) ?? [],
                                                                  PlanNumber: plan.planNumber,
                                                                  HotelStars: plan.hotelStars,
                                                                  userID: planViewModel.userId, planId: plan.planId, Image2: plan.Image, selectNumberOfPersons: plan.selectNumberOfPersons, favStatus: $favStatus )) {
                            ZStack(alignment: .leading) {
                                
                                
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.gray.opacity(0.01))
                                    .padding(.horizontal, 30)
                                    .background(Color.white) // Add a white background to the entire card
                                    .cornerRadius(10) // Round corners of the card
                                    .shadow(color: Color.gray.opacity(0.7), radius: 5, x: 0, y: 2) // Add a shadow effect
                                
                                ZStack{
//                                    Image("Modern and Minimal Company Profile Presentation") // Replace "your_background_image" with your image name
//                                           .resizable()
//                                           .aspectRatio(contentMode: .fill)
//                                           .frame(maxWidth: .infinity, maxHeight: .infinity)
//                                           .edgesIgnoringSafeArea(.all)
//                                           .opacity(0.8)
//                                           .cornerRadius(20)
                                HStack{
                                    
                                
                                    VStack(alignment: .leading, spacing: 5) {
                                        HStack() {
                                            Text("Plan ID:")
                                                .font(Font.custom("Baskerville-Bold", size: 17))
                                                .foregroundColor(Color(UIColor(hex: 0x313F54)))
                                                .fontWeight(.bold)
                                            Text("\(plan.planId)")
                                                .font(Font.custom("Arial-BoldMT", size: 14))
                                                .foregroundColor(Color(red: 0.043, green: 0.725, blue: 0.753))
                                                .fontWeight(.bold)
                                            //
                                            // Cochin-BoldItalic
                                        }
                                        
                                        HStack {
                                            Text("Total budget:")
                                                .font(Font.custom("Baskerville-Bold", size: 17))
                                                .foregroundColor(Color(UIColor(hex: 0x313F54)))
                                                .fontWeight(.bold)
                                            Text("\(plan.budget)")
                                                .font(Font.custom("Arial-BoldMT", size: 14))                                               .foregroundColor(Color(red: 0.043, green: 0.725, blue: 0.753))
                                                .fontWeight(.bold)
                                            Image(systemName: "dollarsign.circle").foregroundColor(Color(red: 0.722, green: 0.275, blue: 0.114))
                                                .font(.system(size: 19))
                                        }
                                        
                                        HStack {
                                            Text("Trip Type:")
                                                .font(Font.custom("Baskerville-Bold", size: 17))
                                                .foregroundColor(Color(UIColor(hex: 0x313F54)))
                                                .fontWeight(.bold)
                                            Text(extractTextBeforeUnderscore(plan.tripType))
                                                .font(Font.custom("Arial-BoldMT", size: 14))                                              .foregroundColor(Color(red: 0.043, green: 0.725, blue: 0.753))
                                            
                                        }
                                        
                                        HStack {
                                            Text("Hotel Stars:")
                                                .font(Font.custom("Baskerville-Bold", size: 17))
                                                .foregroundColor(Color(UIColor(hex: 0x313F54)))
                                                .fontWeight(.bold)
                                            
                                            Text("\(plan.hotelStars)") 
                                                .font(Font.custom("Arial-BoldMT", size: 14))                                               .foregroundColor(Color(red: 0.043, green: 0.725, blue: 0.753))
                                                .fontWeight(.bold)
                                            Image(systemName: "star.fill").foregroundColor(.yellow)
                                                .font(.system(size: 17))
                                        }
                                        
                                        HStack {
                                            Text("Person:")
                                                .font(Font.custom("Baskerville-Bold", size: 17))
                                                .foregroundColor(Color(UIColor(hex: 0x313F54)))
                                                .fontWeight(.bold)
                                            
                                            if plan.selectNumberOfPersons == 1{
                                                Image(systemName: "person.circle")
                                                                                               .font(.system(size: 24))
                                                                                               .foregroundColor(Color(red: 0.722, green: 0.275, blue: 0.114)) // Customize the color as needed
                                                                                               .opacity(0.85)
                                            } else if plan.selectNumberOfPersons == 2{
                                                
                                                Image(systemName: "person.2.fill")
                                                                                               .font(.system(size: 24))
                                                                                               .foregroundColor(Color(red: 0.722, green: 0.275, blue: 0.114)) // Customize the color as needed
                                                                                               .opacity(0.85)
                                            }
                                            else{
                                                Image(systemName: "  ")
                                                                                               .font(.system(size: 24))
                                                                                               .foregroundColor(Color(red: 0.722, green: 0.275, blue: 0.114)) // Customize the color as needed
                                                                                               .opacity(0.85)
                                            }
                                           
                                        }
                                        
                                       
                                    }
                                    .padding(.leading,10)
                                    
                                    Spacer()
                                    VStack{
                                        AsyncImage(url: URL(string: convertGoogleDriveLinkToDirectImageURL(googleDriveLink: plan.Image) ?? ""))
                                              {
                                            phase in
                                                     switch phase {
                                                     case.empty:
                                                         Image("Screenshot 2024-01-02 at 4.16.52 PM (1)")
                                                             .resizable()
                                                             .aspectRatio(contentMode: .fit)
//                                                             .frame(width: 250, height: 150)
                                                             .cornerRadius(20)
                                                     case.success(let image):
                                                         image
                                                             .resizable()
                                                             .aspectRatio(contentMode: .fill)
//                                                             .frame(width: 250, height: 150)
                                                             .cornerRadius(20)
                                                     case.failure:
                                                         Image("Screenshot 2024-01-02 at 4.16.52 PM (1)")
                                                             .resizable()
                                                             .aspectRatio(contentMode: .fit)
//                                                             .frame(width: 250, height: 150)
                                                             .cornerRadius(20)
                        //                                 @unknown default:
                        //                                     EmptyView()
                                                     @unknown default:
                                                         fatalError()
                                                     }
                                          
                                                 }
                                            .cornerRadius(20)
                                            .frame(width: 100)
                                            .cornerRadius(20)
                                            .padding(.trailing,5)
                                        
                                       
//                                        VStack{
//
//                                            
//                                        }
//                                        .frame(width: 4)
//                                        .padding(.trailing,5)
//                                        .padding(.leading,105)
                                    }
                                }
                                    
                            }
                                .padding(.vertical,10)
                            }
                            .padding(.bottom, 10)
                        }
                                                                  .padding(.horizontal,22)
                    }
                }
                .padding(.top, 10)
                .padding(.bottom, 10)
            }
            .navigationBarTitle("Fav Plans")
            .font(Font.custom("Charter-BlackItalic", size: 32))
        }
        .background(Image("IMG_20240104_181119 (2)").resizable().scaledToFill().clipped().edgesIgnoringSafeArea([.all]).opacity(0.5))
        .onAppear(){
            if (favStatus == false){
                favStatus.toggle()
            }
        }
    }
}

func extractTextBeforeUnderscore(_ text: String) -> String {
    if let underscoreIndex = text.firstIndex(of: "_") {
        return String(text.prefix(upTo: underscoreIndex))
    } else {
        return text // Return original text if there's no underscore
    }
}


    func convertStringToArray(_ jsonString: String) -> [[String: Any]]? {
        
        if let jsonData = jsonString.data(using: .utf8) {
            do {
                let decodedData = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [[String: Any]]
                return decodedData
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
        return nil
    }



#Preview {
    FavoriteScreen(userID: "t17QMgg7C0QoRNr401O9Z93zTMl1")
}

