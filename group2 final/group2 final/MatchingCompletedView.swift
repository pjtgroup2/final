import SwiftUI
import CoreData
struct MatchingCompletedView: View {
    @StateObject private var messengerData = MessengerData()
    @State private var selectedRole: Role?
    var body: some View {
        VStack {
            Text("Matching Completed")
                .font(.title)
                .padding()
            Text("Talk with each other")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Spacer()
            if selectedRole == nil {
                HStack(spacing: 20) {
                    Button(action: {
                        selectedRole = .owner
                    }) {
                        Text("Owner")
                            .font(.title)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    
                    Button(action: {
                        selectedRole = .contractor
                    }) {
                        Text("Contractor")
                            .font(.title)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.green)
                            .cornerRadius(10)
                    }
                }
                .padding()
            } else {
                MessengerView(role: selectedRole!, messengerData: messengerData)
                    .navigationBarTitle(Text("Messenger"), displayMode: .inline)
                    .navigationBarBackButtonHidden(true)
            }
            
            Spacer()
        }
    }
}

struct MessengerView: View {
    var role: Role
    @ObservedObject var messengerData: MessengerData
    
    @State private var newMessage = ""
    var body: some View {
        VStack {
            ScrollView { //스크롤하여 컨텐츠를 볼 수 있음
                VStack(alignment: role == .owner ? .trailing : .leading, spacing: 8) {
                    ForEach(messengerData.messages) { message in
                        MessageView(message: message, role: role)
                    }
                }
            }
            .padding()
            
            HStack { // HStack : 가로 뷰
                TextField("Enter message", text: $newMessage)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(action: sendMessage) {
                    Image(systemName: "paperplane.fill") // 메세지입력 버튼 비행기 이미지
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25)
                        .padding()
                }
                .disabled(newMessage.isEmpty)
            }
            .padding(.horizontal)
        }
    }
    
    private func sendMessage() {
        guard !newMessage.isEmpty else { return }
        
        let message = Message(content: newMessage, role: role)
        messengerData.addMessage(message)
        
        newMessage = ""
    }
}

struct MessageView: View {
    var message: Message
    var role: Role
    
    var body: some View {
        HStack {
            if role == .owner {
                Spacer()
                Text(message.content)
                    .padding(8)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            } else {
                Text(message.content)
                    .padding(8)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                Spacer()
            }
        }
    }
}

struct Message: Identifiable {
    let id = UUID()
    let content: String
    let role: Role
}

enum Role {
    case owner
    case contractor
}

class MessengerData: ObservableObject {
    @Published var messages: [Message] = []
    
    func addMessage(_ message: Message) {
        messages.append(message)
    }
}
