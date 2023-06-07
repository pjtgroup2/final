import SwiftUI
import CoreData

struct OwnerDashboardView: View {
    // core data 에서 데이터를 가져오고 변경사항 저장
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity: Owner.entity(),
        sortDescriptors: [],
        predicate: NSPredicate(format: "isLoggedIn == %@", NSNumber(value: true))
    ) private var loggedInOwners: FetchedResults<Owner>

    private var loggedOwner: Owner? {
        loggedInOwners.first
    }

    var body: some View {
        NavigationView {
                VStack {
                    // vstack : 수직으로 정렬된 뷰 구성
                    if let owner = loggedOwner {
                        Text("Welcome, \(owner.name ?? "")")
                            .font(.title)
                            .padding()
                        
                        if let ownerProposals = owner.proposals {
                            List {
                                ForEach(Array(arrayLiteral: ownerProposals), id: \.self) { proposal in
                                    Text(proposal.workName ?? "")
                                }
                            }
                        } else {
                            Text("There are no proposals yet.")
                                .foregroundColor(.gray)
                                .padding()
                        }
                        
                        NavigationLink(destination: ConstructionProposalView()) {
                            Text("Submit New Proposal")
                                .foregroundColor(.blue)
                        }
                    } else {
                        Text("Owner not found.")
                            .foregroundColor(.red)
                            .padding()
                    }
                }
                .navigationBarTitle("Owner Dashboard")
                .navigationBarItems(leading: backButton)
            }
    }
    // 뒤로 가기 버튼
    private var backButton: some View {
        Button(action: {
            resetOwnerLoginStatus()
        }) {
            Text("Back")
        }
    }
    // core data의 로그인 상태 재설정
    func resetOwnerLoginStatus() {
        let request: NSFetchRequest<Owner> = Owner.fetchRequest()
        do {
            let owners = try viewContext.fetch(request)
            for owner in owners {
                owner.isLoggedIn = false
            }
            try viewContext.save()
        } catch {
            print("Failed to reset owner login status: \(error)")
        }
    }
}


struct OwnerDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        OwnerDashboardView()
    }
}

