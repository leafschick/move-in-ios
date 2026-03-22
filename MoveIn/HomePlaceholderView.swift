import SwiftUI

struct HomePlaceholderView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Home Page")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("HomePage is under development.")
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
                .padding(.horizontal)

            Text("User logged in successfully.")
                .foregroundColor(.blue)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGray6))
    }
}

#Preview {
    HomePlaceholderView()
}
