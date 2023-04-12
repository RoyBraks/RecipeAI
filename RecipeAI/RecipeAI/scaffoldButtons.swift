import SwiftUI

struct ContentView1: View {
    @State private var showOptions: Bool = false
    @State private var selectedOption: Int? = nil

    var body: some View {
        VStack {
            Button(action: {
                withAnimation {
                    self.showOptions.toggle()
                }
            }) {
                Text("Main Button")
                    .font(.system(size: 14))
            }

            if showOptions {
                VStack {
                    ForEach(0..<4) { index in
                        OptionButton(index: index, isSelected: selectedOption == index, showSubOptions: selectedOption != nil) {
                            withAnimation {
                                self.selectedOption = (selectedOption == index) ? nil : index
                            }
                        }
                    }
                }
            }
        }
    }
}

struct OptionButton: View {
    let index: Int
    let isSelected: Bool
    let showSubOptions: Bool
    let action: () -> Void

    var body: some View {
        VStack {
            Button(action: action) {
                Text("Option \(index + 1)")
                    .font(.system(size: 12))
            }
            
            if isSelected {
                VStack {
                    ForEach(0..<4) { subIndex in
                        Button(action: {}) {
                            Text("Sub-option \(index + 1).\(subIndex + 1)")
                                .font(.system(size: 12))
                        }
                    }
                }
            } else if showSubOptions {
                VStack {
                    ForEach(0..<4) { _ in
                        Spacer()
                            .frame(height: 20)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews1: PreviewProvider {
    static var previews: some View {
        ContentView1()
    }
}
