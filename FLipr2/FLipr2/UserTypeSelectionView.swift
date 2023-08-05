import SwiftUI

struct UserTypeSelectionView: View {
    @Binding var isDealer: Bool
    @Binding var isDriver: Bool

    var body: some View {
        VStack {
            Button("Login as Dealer") {
                isDealer = true
            }
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)
            
            Button("Login as Driver") {
                isDriver = true
            }
            .padding()
            .background(Color.orange)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .navigationBarTitle("Select User Type")
    }
}

struct UserTypeSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        UserTypeSelectionView(isDealer: .constant(false), isDriver: .constant(false))
    }
}
