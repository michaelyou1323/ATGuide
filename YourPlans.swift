import SwiftUI

struct ReservationListView: View {
    @ObservedObject var reservationModel: ReservationModel
    
    init(userId: String) {
        self.reservationModel = ReservationModel(userId: userId)
    }
    
    var body: some View {
        NavigationView {
            List(reservationModel.reservations) { reservation in
                ReservationRowView(reservation: reservation)
            }
            .navigationBarTitle("Your Reservations")
        }
        .onAppear {
            self.reservationModel.fetchUserPlans()
        }
    }
}

struct ReservationRowView: View {
    var reservation: Reservation
    
    @State private var isExpanded = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack{
                    AsyncImage(url: URL(string: convertGoogleDriveLinkToDirectImageURL(googleDriveLink: reservation.image2) ?? ""))
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
                
                Text("Plan ID: \(reservation.planId)")
                    .font(.headline)
            }
            
           
            
            // Additional details shown when expanded
            DisclosureGroup("More", isExpanded: $isExpanded) {
                Text("Number of Users: \(reservation.numberOfUser)")
                    .font(.subheadline)
                
                 Text("Budget: \(reservation.budget)")
                     .font(.subheadline)
                Text("Budget: \(reservation.hotelsDetails)")
                    .font(.subheadline)
//                ForEach(reservation.hotelsDetails, id: \.id) { hotelDetail in
//                       Text("Hotel Name: \(hotelDetail.name)")
//                           .font(.subheadline)
//                    
//                    Text("Some Property: \(hotelDetail.hotelCost)")
//                           .font(.subheadline)
//                    
//                       // Add more details as needed
//                   }
                Text("Type: \(extractTextBeforeUnderscore(reservation.tripType))")
                    .font(.subheadline)
                // Display more details about the reservation
                // You can access reservation's properties here and format the UI as needed
            }
            .padding(.vertical, 5)
            .onTapGesture {
                withAnimation {
                    self.isExpanded.toggle()
                }
            }
        }
        
        .padding(.vertical, 10)
    }
}

#Preview {
    ReservationListView(userId: "t17QMgg7C0QoRNr401O9Z93zTMl1")
}
