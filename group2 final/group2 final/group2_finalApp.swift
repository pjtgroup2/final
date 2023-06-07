//
//  group2_finalApp.swift
//  group2 final
//
//  Created by snlcom on 2023/05/29.
//

import SwiftUI
import CoreData


@main // main start code.
struct group2_finalApp: App {
    let persistanceController = PersistenceController.shared // 'PersistenceController' Core data를 저장하고 불러내는데 필요한 클래스
    var body: some Scene { //About first view => Contentview
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistanceController.container.viewContext) // enviornment 구문이 있어야 Core data를 시각적으로 불러올 수 가 있다.
        }
    }
}
