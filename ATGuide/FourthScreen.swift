import SwiftUI

struct User: Codable {
    let id: String // Assuming you're using 'id' instead of 'uid'
    var name: String
    var email: String
    var password: String
    var phonenumber: String
    var country: String
    var language: String
  
        // Add other necessary properties
    
}

struct FourthScreen: View {
    @State private var users: [User] = []
    
    var body: some View {
        VStack {
            List(users, id: \.email) { user in
                Text(user.name)
                Text(user.email)
                Text(user.password)
            }

            Button("Read Data") {
                readDataFromFile()
            }

            Button("Write Data") {
                writeDataToFile()
            }
        }
    }

    func readDataFromFile() {
        guard let fileURL = getDocumentDirectory()?.appendingPathComponent("AT Guide Database.bak") else {
            return
        }

        do {
            let data = try Data(contentsOf: fileURL)
            let decodedUsers = try JSONDecoder().decode([User].self, from: data)
            self.users = decodedUsers
        } catch {
            print("Error reading file: \(error)")
        }
    }

    func writeDataToFile() {
        guard let fileURL = getDocumentDirectory()?.appendingPathComponent("example.bak") else {
            return
        }

        let newUser = User(id: "String", name: "John Doe", email: "john@example.com", password: "securepassword", phonenumber: "",country: "",language: "")

        do {
            if var existingUsers = try? JSONDecoder().decode([User].self, from: Data(contentsOf: fileURL)) {
                existingUsers.append(newUser)
                let newData = try JSONEncoder().encode(existingUsers)
                try newData.write(to: fileURL, options: .atomic)
            } else {
                let newData = try JSONEncoder().encode([newUser])
                try newData.write(to: fileURL, options: .atomic)
            }
        } catch {
            print("Error writing to file: \(error)")
        }
    }

    func getDocumentDirectory() -> URL? {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    }
}

struct FourthScreen_Previews: PreviewProvider {
    static var previews: some View {
        FourthScreen()
    }
}
