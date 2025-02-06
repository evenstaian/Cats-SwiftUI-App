import SwiftUI

struct LoaderView: View {
    var body: some View {
        VStack {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .scaleEffect(1.5)
            Text("Fetching cute kitties...")
                .foregroundColor(.gray)
                .padding(.top, 8)
        }
    }
}

#Preview {
    LoaderView()
} 