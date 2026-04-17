import SwiftUI

struct SavedVendorsView: View {
    @AppStorage("savedVendorNames") private var savedVendorNames = ""
    
    private var savedMovers: [HomeMover] {
        let vendors = savedVendorNames.components(separatedBy: ",").filter { !$0.isEmpty }
        return HomeMover.mockMovers.filter { vendors.contains($0.name) }
    }
    
    var body: some View {
        Group {
            if savedMovers.isEmpty {
                VStack(spacing: 12) {
                    Image(systemName: "heart.slash")
                        .font(.system(size: 64))
                        .foregroundColor(.gray.opacity(0.5))
                    Text("No Saved Vendors")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Text("Vendors you favorite will appear here.")
                        .foregroundColor(.secondary)
                }
            } else {
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(savedMovers) { mover in
                            NavigationLink(destination: VendorDetailView(mover: mover)) {
                                HomeMoverCard(mover: mover)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationTitle("Saved Vendors")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    SavedVendorsView()
}
