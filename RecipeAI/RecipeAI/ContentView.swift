import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            ExplorePage()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Explore")
                }
            
            Text("Chats")
                .tabItem {
                    Image(systemName: "message")
                    Text("Chat")
                }
            
            Text("Groups")
                .tabItem {
                    Image(systemName: "person.3")
                    Text("Groups")
                }
            
            Text("Profile")
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
