//
//import SwiftUI
//
//
//public struct ButtonsPage: View{
//    @Binding var text: String
//    let sendAction: () -> Void
//    
//    var body: some View {
//        Menu {
//            Button("Remove Chicken", action: {
//                text = "Remove Chicken"
//                sendAction ()
//            })
//            Button("Remove Asparagus", action: {
//                text = "Remove Asparagus"
//                sendAction()
//            })
//            Button("Remove Parmesan Cheese", action: {
//                text = "Remove Parmesan Cheese"
//                sendAction()
//            })
//            Button("Remove Creme Fraiche", action: {
//                text = "Remove Creme Fraiche"
//                sendAction()
//            })
//        } label: {
//            Text("Remove an ingredient")
//        }
//        
//        Menu {
//            Button("Make vegetarian", action: {
//                text = "Make it vegetarian"
//                sendAction ()
//            })
//            Button("Make vegan", action: {
//                text = "Make it vegan"
//                sendAction()
//            })
//            Button("Low-Calorie", action: {
//                text = "Change necessary ingredients to make meal lower in calories."
//                sendAction()
//            })
//        } label: {
//            Text("Change dish type")
//        }
//    }
//}
