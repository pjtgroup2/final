//
//  OwnerView.swift
//  group2 final
//
//  Created by snlcom on 2023/05/29.
//
import SwiftUI
import CoreData

struct OwnerView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var name = ""
    @State private var gender = ""
    @State private var age = ""
    @State private var phoneNumber = ""
    @State private var isOwnerSelected = false
    @State private var isSubmitted = false
    // 뷰의 본문을 정의
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Personal Information")) {
                    TextField("Name", text: $name)
                    TextField("Gender(M/W)", text: $gender)
                    TextField("Age", text: $age)
                    TextField("Phone Number", text: $phoneNumber)
                }
                
                Section(header: Text("Confirmation")) {
                    Toggle(isOn: $isOwnerSelected) {
                        Text("Are you really the owner?")
                    }
                }
                Section {
                    NavigationLink(destination: OwnerLoginView()) {
                        Text("Login")
                            .font(.title)
                            .padding()
                            .foregroundColor(.white)
                            .frame(width: 300.0, height: 40.0)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    Button(action: {submitInformation()
                        isSubmitted = true
                    }) {
                            Text("Submit")
                                .font(.title)
                                .padding()
                                .foregroundColor(.white)
                                .frame(width: 300.0, height: 40.0)
                                .background(Color.green)
                                .cornerRadius(10)
                        }
                    .disabled(!isFormValid())
                    .opacity(isFormValid() ? 1.0:0.5)
                }
            }
            .navigationTitle("Owner Information")
            .background(
                NavigationLink(
                    destination:ConstructionProposalView(),
                    isActive: $isSubmitted)
                {
                    EmptyView()
                }
            )
        }
    }
    
    private func submitInformation() {
        guard isFormValid() else {
            return
        }
        
        let owner = Owner(context: viewContext)
        owner.name = name
        owner.gender = gender
        owner.age = age
        owner.phoneNumber = phoneNumber
        owner.isLoggedIn = true
        
        do {
            try viewContext.save()
            isSubmitted = true
            print("Owner information saved successfully.")
        } catch {
            print("Error saving owner information: \(error)")
        }
    }
    
    
    private func isFormValid() -> Bool {
        // Add your validation logic here
        return !name.isEmpty && !gender.isEmpty && !age.isEmpty && !phoneNumber.isEmpty && isOwnerSelected
    }
}

struct OwnerView_Previews: PreviewProvider {
    static var previews: some View {
        OwnerView()
    }
}
