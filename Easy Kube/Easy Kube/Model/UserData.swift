import Combine
import SwiftUI

final class UserData: ObservableObject {
    @Published var filterKey = ""
    @Published var selectedTab: String = "Pods"
    @Published var server: String = ""
    
}
