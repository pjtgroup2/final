import SwiftUI
import CoreData

struct ConstructionProposalView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Proposal.entity(), sortDescriptors: []) private var proposals: FetchedResults<Proposal>
    @State private var workName = ""
    @State private var location = ""
    @State private var additionalDetails = ""
    @State private var isAction = false
    @State private var showProposalList = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Construction Proposal")) {
                    TextField("Construction Work Name", text: $workName)
                    TextField("Location", text: $location)
                        .frame(height: 30)
                        .cornerRadius(5)
                }
                Section(header: Text("Other additional infos")) {
                    TextField("Please write down specific details.", text: $additionalDetails)
                        .frame(height: 30)
                        .cornerRadius(5)
                }
                
                Button(action: {
                    
                    submitConstructionProposal()
                    isAction = true
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
            .background(
                NavigationLink(destination: ProposalListView(), isActive: $showProposalList) {
                    EmptyView()
                }
            )
        }
    }
    
    private func submitConstructionProposal() {
        guard let owner = try? viewContext.fetch(Owner.fetchRequest()).first else {
            print("Owner not found.")
            return
        }
        
        let proposal = Proposal(context: viewContext)
        proposal.workName = workName
        proposal.location = location
        proposal.additionalDetails = additionalDetails
        proposal.timestamp = Date()
        
        proposal.owner = owner
        
        do {
            try viewContext.save()
            print("Construction proposal submitted successfully.")
            showProposalList = true
        } catch {
            print("Failed to save construction proposal: \(error)")
        }
    }
    
    private func isFormValid() -> Bool {
        return !workName.isEmpty && !location.isEmpty && !additionalDetails.isEmpty
    }
}
