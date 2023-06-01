//
//  OwnerView.swift
//  group2 final
//
//  Created by snlcom on 2023/05/29.
//
import SwiftUI

struct OwnerView: View {
    @State private var name = ""
    @State private var gender = ""
    @State private var age = ""
    @State private var phoneNumber = ""
    @State private var isOwnerSelected = false
    @State private var isSubmitted = false
    @State private var islogin = false
    
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
                Button(action:{loginstart()}) {
                    Text("Login")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                        .accessibilityLabel("Label")
                }
                Button(action: {
                    submitInformation()
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
            .navigationBarTitle("Owner")
            .background(
                NavigationLink(destination: ConstructionProposalView(),
                               isActive: $isSubmitted) {
                                   EmptyView()
                               }
            )
            .background(
                NavigationLink(destination:OwnerLogin(),isActive:$islogin) {
                    EmptyView()
                }
            )
        
        }
    }
    
    private func submitInformation() {
        let ownerInfo = OwnerInformation(name: name, gender: gender, age: age, phonenumber: phoneNumber)
        
        UserDefaultManager.shared.ownerinformation = ownerInfo
        
        print("Submitted Owner Information:")
        print("Name: \(name)")
        print("Gender: \(gender)")
        print("Age: \(age)")
        print("Phone Number: \(phoneNumber)")
        print("Is Owner Selected: \(isOwnerSelected)")
        
        // Update the flag to navigate to the ConstructionProposalView
        isSubmitted = true
    }
    private func loginstart() {
        islogin = true
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
