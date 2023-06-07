//
//  ContractorLogin.swift
//  group2 final
//
//  Created by snlcom on 2023/06/03.
//

import SwiftUI
import CoreData
struct ContractorLoginView: View {
    @Environment(\.managedObjectContext) private var viewContext
    //이 fetch~가 Coredata의 정보를 불러오는거다. sort~가 배열로 불러온다는 얘기고,그 불러온 거를 contractors라는 인스턴스에 저장해서 선언한다는 얘기다.
    @FetchRequest(entity: Contractor.entity(), sortDescriptors: []) private var contractors: FetchedResults<Contractor>

    @State private var name = ""
    @State private var phoneNumber = ""
    @State private var isLoggedIn = false

    var body: some View {
        NavigationView {
            VStack {
                Text("Contractor Login")
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
            .navigationBarTitle("Contractor Login")
            .background(
                NavigationLink(
                    destination:ProposalListView(),
                    isActive: $isLoggedIn)
                {
                    EmptyView()
                }
            )
        }
    }

    private func login() {
        //contractors들 중 작성한 name,phoneNumber랑 맞는 conractors를 불러온다.
        let filteredContractors = contractors.filter { $0.name == name && $0.phoneNumber == phoneNumber }
        if let contractor = filteredContractors.first {
            contractor.isLoggedIn = true
            do {
                try viewContext.save()
                //viewContext.save는 변경된 정보를 coredata에 재저장하는 의미.
                isLoggedIn = true
                //이게 true가 되어야 다음 과정으로 넘어가진다.
                print("Logged in as Contractor: \(contractor.name ?? "")")
            } catch {
                // Handle the error
                print("Error saving Contractor: \(error.localizedDescription)")
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

struct ContractorLoginView_Previews: PreviewProvider {
    static var previews: some View {
        ContractorLoginView()
    }
}


