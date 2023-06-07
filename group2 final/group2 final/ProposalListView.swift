import SwiftUI
import CoreData

struct ProposalListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Proposal.entity(), sortDescriptors: []) private var proposals: FetchedResults<Proposal>
    @State private var selectedProposal: Proposal?
    @State private var showAlert = false
    @State private var showMatchingCompleted = false
    var body: some View {
        NavigationView {
            List {
                ForEach(proposals) { proposal in
                    Button(action: {
                        selectedProposal = proposal
                        showAlert = true
                    }) { // VStack : 수직 구성 뷰
                        VStack(alignment: .leading) {
                            Text(proposal.workName ?? "")
                                .font(.headline)
                            Text(proposal.location ?? "")
                                .font(.subheadline)
                            Text(proposal.additionalDetails ?? "")
                                .font(.body)
                        }
                    }
                }
            }
            .navigationBarTitle("Proposals")
            .navigationBarItems(trailing: EmptyView())
            .alert(isPresented: $showAlert) {
                Alert( // proposal을 눌렀을 때 나오는 알림
                    title: Text("Confirmation"),
                    message: Text("Really select this proposal?"),
                    primaryButton: .default(Text("Select"), action: { // select 버튼
                        if let proposal = selectedProposal { // 이상하게 이게 안뜸(?)
                            print("Selected Proposal: \(proposal.workName ?? "")")
                            showMatchingCompleted = true
                        }
                    }),
                    secondaryButton: .cancel(Text("Cancel"), action: { // cancel 버튼
                        selectedProposal = nil
                    })
                )
            }
            .background( // matchingcompletedview()로 이동
                NavigationLink(destination: MatchingCompletedView(), isActive: $showMatchingCompleted) {
                    EmptyView()
                }
            )
        }
    }
}

