import SwiftUI

struct ContentView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isShowingNewView = false
    @State private var presentSideMenu = false

    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    TextField("Username", text: $username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    SecureField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    Button(action: {
                        // Perform login action
                        isShowingNewView = true
                        login()
                    }) {
                        Text("Login")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding()
                    
                    Button(action: {
                        // Perform signup action
                        signUp()
                    }) {
                        Text("Sign Up")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.green)
                            .cornerRadius(10)
                    }
                    .padding()
                }
                .navigationBarTitleDisplayMode(.automatic)
                .navigationBarItems(leading: Button(action: {
                    // Toggle side menu visibility
                    withAnimation(.easeInOut) {
                        presentSideMenu.toggle()
                    }
                }) {
                    Image(systemName: "line.horizontal.3")
                        .imageScale(.large)
                })
            }
            if presentSideMenu {
                SideMenu(presentSideMenu: $presentSideMenu)
            }
        }
        .background(Color.black.opacity(0.05))
    }
    
    func login() {
        // Perform login functionality
    }
    
    func signUp() {
        print("Sign Up tapped with username: \(username) and password: \(password)")
    }
}

struct SideMenu: View {
    @Binding var presentSideMenu: Bool
    
    var body: some View {
        ZStack(alignment: .leading ) {
            Color.gray.opacity(0.4).edgesIgnoringSafeArea(.all).onTapGesture { withAnimation { presentSideMenu = false } }
            
            VStack(alignment: .leading) {
                HStack{
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                    VStack(alignment:.leading){
                        Text("User Name").font(.headline)
                        Text("language").font(.subheadline)
                    }.padding(.leading, 1)
                }.padding(.top, 1).padding(.leading, 10).padding(.bottom, 120)
                 
                Text("Setting").font(.headline).padding().background(Color.white).cornerRadius(10).shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                    .padding(.leading, 8)

                Text("New Broadcast").font(.headline).padding().background(Color.white).cornerRadius(10).shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                    .padding(.leading, 8)
                
                Text("WhatsApp Web").font(.headline).padding().background(Color.white).cornerRadius(10).shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                    .padding(.leading, 8)
                
                Text("Starred Messages").font(.headline).padding().background(Color.white).cornerRadius(10).shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                    .padding(.leading, 8)
                
                Text("Settings").font(.headline).padding().background(Color.white).cornerRadius(10).shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                    .padding(.leading, 8)
                
            }.frame(maxWidth:200, maxHeight:.infinity ,alignment:.topLeading).background(Color.white.ignoresSafeArea(.all)).offset(x:self.presentSideMenu ? 0 : -UIScreen.main.bounds.width/4)
                
                
        }
    }
}

struct ContentView_Previews1 : PreviewProvider {
    static var previews : some View{
        ContentView()
    }
}
