import SwiftUI

struct ConstructionProposalView: View {
    @State private var workName = ""
    @State private var location = ""
    @State private var additionalDetails = ""
    
    var body: some View {
        Form {
            Section(header: Text("Construction Proposal")) {
                TextField("Construction Work Name", text: $workName)
                TextField("Location", text: $location)
                
                TextEditor(text: $additionalDetails)
                    .frame(height: 150)
                    .cornerRadius(5)
            }
            
            Button(action: {
                // Perform action when submit button is tapped
                submitConstructionProposal()
            }) {
                Text("Submit")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .disabled(!isFormValid())
        }
        .navigationBarTitle("Construction Proposal")
    }
    
    private func submitConstructionProposal() {
        // Perform the necessary actions when the submit button is tapped
        // You can access the entered information using the `workName`, `location`, and `additionalDetails` properties
        print("Submitted Construction Proposal:")
        print("Construction Work Name: \(workName)")
        print("Location: \(location)")
        print("Additional Details: \(additionalDetails)")
    }
    
    private func isFormValid() -> Bool {
        // Add your validation logic here
        return !workName.isEmpty && !location.isEmpty
    }
}

struct ConstructionProposalView_Previews: PreviewProvider {
    static var previews: some View {
        ConstructionProposalView()
    }
}

