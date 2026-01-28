import SwiftUI

@main
struct SpikingsApp: App {
    var body: some Scene {
        WindowGroup {
            MainViewSK()
                .environmentObject(MainViewModelSK())
        }
    }
}
