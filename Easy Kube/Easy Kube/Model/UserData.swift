import Combine
import SwiftUI

final class UserData: ObservableObject {
    @Published var filterKey = ""
    @Published var selectedTab: String = "Pod"
     @Published var server: String = ""
    
}
