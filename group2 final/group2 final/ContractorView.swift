//
//  OwnerView.swift
//  group2 final
//
//  Created by snlcom on 2023/05/29.
//
import SwiftUI
import CoreData

struct ContractorView: View {
    //Contractor로서의 정보 기입
    @Environment(\.managedObjectContext) private var viewContext
    @State private var name = ""
    @State private var gender = ""
    @State private var age = ""
    @State private var phoneNumber = ""
    @State private var job = ""
    @State private var isContractorSelected = false
    @State private var isCertified = false
    //issubmitted는 다음 submit후의 다음 화면인 Contractorloginview 로 가기 위한 장치
    @State private var isSubmitted = false
    // 뷰의 본문을 정의
    var body: some View {
        NavigationView {
            Form {
                //personal Information 구성
                Section(header: Text("Personal Information")) {
                    TextField("Name", text: $name)
                    TextField("Gender(M/W)", text: $gender)
                    TextField("Age", text: $age)
                    TextField("Phone Number", text: $phoneNumber)
                    TextField("Job or company", text: $job)
                }
                
                Section(header: Text("Confirmation")) {
                    Toggle(isOn: $isContractorSelected) {
                        Text("Are you really the Contractor?")
                    }
                    Toggle(isOn: $isCertified) {
                        Text("Are you certified from any agency?")
                    }
                }
                Section {
                    //ContractorLoginView로 이동
                    NavigationLink(destination: ContractorLoginView()) {
                        Text("Login")
                            .font(.title)
                            .padding()
                            .foregroundColor(.white)
                            .frame(width: 300.0, height: 40.0)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    // submit 버튼 추가
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
            .navigationBarTitle("Contractor")
            .background(
                //ContractorLoginView로 이동 ; 밑의 느낌표는 무시
                NavigationLink(
                    destination:ContractorLoginView(),
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
        // contractor 정보 구성
        let contractor = Contractor(context: viewContext)
        contractor.name = name
        contractor.gender = gender
        contractor.age = age
        contractor.phoneNumber = phoneNumber
        contractor.job = job
        
        do {
            try viewContext.save()
            isSubmitted = true
            print("Contractor information saved successfully.")
        } catch {
            print("Error saving owner information: \(error)")
        }
    }
    // Bool 함수 : 입력에 대한 검증 (true일 경우 유효한 상태로 간주)
    private func isFormValid() -> Bool {
        return !name.isEmpty && !gender.isEmpty && !age.isEmpty && !phoneNumber.isEmpty && isContractorSelected && isCertified
    }
}
// 미리보기 코드
struct ContractorView_Previews: PreviewProvider {
    static var previews: some View {
        ContractorView()
    }
}


