//
//  ContentView.swift
//  group2 final
//
//  Created by snlcom on 2023/05/29.
//

import SwiftUI
//NavigationLink View로 Body를 만들면 이후 화면에서 다시 본 화면으로 돌아 갈 수 있는 탭을 좌측 상단에 생성해준다.

struct ContentView: View {
    //거의 모든 파일에 @Environment로 시작하는 이 구문이 존재하는데 쉽게 이해하면 어디서든지 Core data의 data를 저장하고자 함이다.
    @Environment(\.managedObjectContext) var managedObjectContext
    var body: some View {
        NavigationView {
            HStack {
                //NavigationLink는 destination인 OwnerView로 해당 버튼을 누르면 그 뷰로 화면을 이어준다는 뜻
                NavigationLink(destination: OwnerView()) {
                    Text("Owner")
                        .font(.title)
                        .padding()
                        .foregroundColor(.white)
                        .frame(width: 150.0, height: 80.0)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                // Ownerview로 가는것과 같은 원리
                NavigationLink(destination: ContractorView()) {
                    Text("Contractor")
                        .font(.title)
                        .padding()
                        .foregroundColor(.white)
                        .frame(width: 200.0, height: 80.0)
                        .background(Color.green)
                        .cornerRadius(10)
                }
            }
            .navigationBarTitle("Role Selection")
        }
    }
    
    //이거 아마 필요는 없는거로 압니다 근데 빼면 오류나서 ...
    func saveContext() {
      do {
        try managedObjectContext.save()
      } catch {
        print("Error saving managed object context: \(error)")
      }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
