import SwiftUI

struct User: Codable {
    var name: String
    var email: String
    var password: String
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

        let newUser = User(name: "John Doe", email: "john@example.com", password: "securepassword")

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
