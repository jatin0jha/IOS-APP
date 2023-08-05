import SwiftUI
struct ContentView: View {
    @State private var isDealer: Bool = false
    @State private var isDriver: Bool = false
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var loggedIn: Bool = false
    @State private var rememberMe: Bool = false
    @State private var showAlert: Bool = false
    var body: some View {
        NavigationView {
            VStack {
                if !loggedIn {
                    Text("Welcome to Transport App")
                        .font(.headline)
                        .padding()

                    TextField("Username", text: $username)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)

                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)

                    Toggle("Keep me logged in", isOn: $rememberMe)
                        .padding(.top, 10)

                    HStack {
                        Button("Login as Dealer") {
                            if username == "Kawaki" && password == "1234" {
                                isDealer = true
                                loggedIn = true
                            } else {
                                showAlert = true
                            }
                        }
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)

                        Button("Login as Driver") {
                            if username == "Kawaki" && password == "1234" {
                                isDriver = true
                                loggedIn = true
                            } else {
                                showAlert = true
                            }
                        }
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                } else if isDealer {
                    DealerDashboardView(loggedIn: $loggedIn)
                } else if isDriver {
                    DriverDashboardView(loggedIn: $loggedIn)
                }
            }
            .navigationBarTitle("Transport App")
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Login Failed"),
                    message: Text("Incorrect username or password. Please try again."),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}
var submittedRequests: [TransportRequest] = []
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
struct TransportRequest: Identifiable {
    var id = UUID() // Add a unique identifier
    var name: String
    var mobileNumber: String
    var natureOfMaterial: String
    var weightOfMaterial: String
    var quantity: String
    var city: String
    var state: String
}
struct DealerDashboardView: View {
    @Binding var loggedIn: Bool
    @State private var transportRequest: TransportRequest = TransportRequest(name: "", mobileNumber: "", natureOfMaterial: "", weightOfMaterial: "", quantity: "", city: "", state: "")
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Transport Request Form")) {
                        TextField("Name", text: $transportRequest.name)
                        TextField("Mobile Number", text: $transportRequest.mobileNumber)
                        TextField("Nature of Material", text: $transportRequest.natureOfMaterial)
                        TextField("Weight of Material", text: $transportRequest.weightOfMaterial)
                        TextField("Quantity", text: $transportRequest.quantity)
                        TextField("City", text: $transportRequest.city)
                        TextField("State", text: $transportRequest.state)
                    }
                }
                
                Button("Submit Request") {
                            submittedRequests.append(transportRequest) // Append to the submittedRequests array
                            transportRequest = TransportRequest(name: "", mobileNumber: "", natureOfMaterial: "", weightOfMaterial: "", quantity: "", city: "", state: "") // Reset the form
                        }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .navigationBarTitle("Dealer Dashboard")
            .navigationBarItems(leading: Button("Logout") {
                loggedIn = false
            })
        }
    }
}
struct DriverDashboardView: View {
    @Binding var loggedIn: Bool
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(submittedRequests) { request in // No need for id: \.self
                        CardView(request: request)
                    }
                }
                .padding()
            }
            .navigationBarTitle("Driver Dashboard")
            .navigationBarItems(leading: Button("Logout") {
                loggedIn = false
            })
        }
    }
}
struct CardView: View {
    var request: TransportRequest
    var body: some View {
        VStack(alignment: .leading) {
            Text("Name: \(request.name)")
            Text("Mobile Number: \(request.mobileNumber)")
            Text("Nature of Material: \(request.natureOfMaterial)")
            Text("Weight of Material: \(request.weightOfMaterial)")
            Text("Quantity: \(request.quantity)")
            Text("City: \(request.city)")
            Text("State: \(request.state)")
            Button("Get") {
                // Implement action for "Get" button if needed
            }
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }
}
