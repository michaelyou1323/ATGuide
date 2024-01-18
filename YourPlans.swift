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
        HStack(spacing: 10) {
            // Image View
            AsyncImage(url: URL(string: convertGoogleDriveLinkToDirectImageURL(googleDriveLink: reservation.image2) ?? "")) { phase in
                switch phase {
                case .empty, .failure:
                    Image("PlaceholderImage")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .cornerRadius(20)
                        .padding(.trailing, 10)
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .cornerRadius(20)
                        .padding(.trailing, 10)
                @unknown default:
                    fatalError()
                }
            }
         

            // Text and Details Stack
            VStack(alignment: .leading, spacing: 5) {
                Text("Plan ID: \(reservation.planId)")
                    .font(.headline)

                // Additional details shown when expanded
                DisclosureGroup("More", isExpanded: $isExpanded) {
                    Text("Number of Users: \(reservation.numberOfUser)")
                        .font(.subheadline)

                    Text("Budget: \(reservation.budget)")
                        .font(.subheadline)

                    Text("Type: \(extractTextBeforeUnderscore(reservation.tripType))")
                        .font(.subheadline)
                }
                .padding(.vertical, 5)
                .onTapGesture {
                    withAnimation {
                        self.isExpanded.toggle()
                    }
                }
            }
        }
        .padding(.vertical, 10)
    }
}

#Preview {
    ReservationListView(userId: "t17QMgg7C0QoRNr401O9Z93zTMl1")
}
