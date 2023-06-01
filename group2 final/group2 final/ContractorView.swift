//
//  OwnerView.swift
//  group2 final
//
//  Created by snlcom on 2023/05/29.
//
import SwiftUI

struct ContractorView: View {
    @State private var name = ""
    @State private var gender = ""
    @State private var age = ""
    @State private var phoneNumber = ""
    @State private var job = ""
    @State private var isContractorSelected = false
    @State private var isCertified = false
    
    var body: some View {
        Form {
            Section(header: Text("Personal Information")) {
                TextField("Name", text: $name)
                TextField("Gender(M/W)", text: $gender)
                TextField("Age", text: $age)
                TextField("Phone Number", text: $phoneNumber)
                TextField("Job", text: $job)
            }
            
            Section(header: Text("Confirmation")) {
                Toggle(isOn: $isContractorSelected) {
                    Text("Are you really the Contractor?")
                }
                Toggle(isOn: $isCertified) {
                    Text("Are you certified from any agency?")
                }
            }
            
            Button(action: {
                // Perform action when submit button is tapped
                submitInformation()
            }) {
                Text("Submit and Save.")
                    .foregroundColor(Color.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .disabled(!isFormValid())
        }
        .navigationBarTitle("Contractor")
    }
    
    private func submitInformation() {
        let contractorInfo = ContractorInformation(name:name, gender:gender, age:age, phonenumber:phoneNumber, job:job)
        
        UserDefaultManager.shared.contractorInformation = contractorInfo
        
        print("Submitted Owner Information:")
        print("Name: \(name)")
        print("Gender: \(gender)")
        print("Age: \(age)")
        print("Phone Number: \(phoneNumber)")
        print("Is Owner Selected: \(isContractorSelected)")
        print("Is Certified Selected:\(isCertified)")
    }
    
    private func isFormValid() -> Bool {
        // Add your validation logic here
        return !name.isEmpty && !gender.isEmpty && !age.isEmpty && !phoneNumber.isEmpty && isContractorSelected && isCertified
    }
}

struct ContractorView_Previews: PreviewProvider {
    static var previews: some View {
        ContractorView()
    }
}


