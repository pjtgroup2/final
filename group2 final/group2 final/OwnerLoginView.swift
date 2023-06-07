import SwiftUI
import CoreData

struct OwnerLoginView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Owner.entity(), sortDescriptors: []) private var owners: FetchedResults<Owner>

    @State private var name = ""
    @State private var phoneNumber = ""
    @State private var isLoggedIn = false

    var body: some View {
        NavigationView {
            VStack {
                Text("Owner Login")
                    .font(.title)
                    .padding()

                TextField("Name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                TextField("Phone Number", text: $phoneNumber)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button(action: {
                    isLoggedIn=true
                    login()
                   
                }) {
                    Text("Login")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding()
                .disabled(!isFormValid())
            }
            .navigationBarTitle("Owner Login")
            .background(
                NavigationLink(
                    destination:OwnerDashboardView(),
                    isActive: $isLoggedIn)
                {
                    EmptyView()
                }
            )
        }
    }

    private func login() {
        
        let filteredOwners = owners.filter { $0.name == name && $0.phoneNumber == phoneNumber }
        if let owner = filteredOwners.first {
            owner.isLoggedIn = true
            do {
                try viewContext.save()
                isLoggedIn = true
                print("Logged in as owner: \(owner.name ?? "")")
            } catch {
                // Handle the error
                print("Error saving owner: \(error.localizedDescription)")
            }
        } else {
            isLoggedIn = false
            print("Invalid login credentials")
        }
    }

    private func isFormValid() -> Bool {
        return !name.isEmpty && !phoneNumber.isEmpty
    }
}

struct OwnerLoginView_Previews: PreviewProvider {
    static var previews: some View {
        OwnerLoginView()
    }
}
