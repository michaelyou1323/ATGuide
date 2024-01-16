import SwiftUI



struct ContentView7: View {
    @State private var searchText = ""
    @State private var filterValue = ""

//    let tripTypes = ["Select trip type", "Culture", "Sports", "Desert", "Medical", "Festival", "Conference","Pleasure","Religious"]
//    var filteredData: [String] {
//        // Replace 'YourDataType' with the actual type of data you have in your VStack
//        // Replace 'yourDataArray' with the actual array you want to filter
//        return tripTypes.filter { data in
//            if searchText.isEmpty && filterValue.isEmpty {
//                return true
//            }
//            
//            let searchMatch = data.name.localizedCaseInsensitiveContains(searchText)
//            let filterMatch = data.category.localizedCaseInsensitiveContains(filterValue)
//            
//            return searchMatch && filterMatch
//        }
//    }

    var body: some View {
        NavigationStack{
            VStack {
                TextField("Search", text: $searchText)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Picker("Filter", selection: $filterValue) {
                    Text("All").tag("")
                    Text("Category 1").tag("Category 1") // Replace with your actual category values
                    Text("Category 2").tag("Category 2")
                    // Add more categories as needed
                }
                .pickerStyle(WheelPickerStyle())
                .padding()
                
                //            List(filteredData, id: \.id) { data in
                //                // Display your data here
                //                Text(data.name)
                //            }
            }
            .padding()
        }
    }
}





struct ContentView_Previews7: PreviewProvider {
    static var previews: some View {
        ContentView7()
    }
}
