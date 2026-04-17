import SwiftUI
import UIKit

struct HomeView: View {
    @Binding var selectedTab: TabItem
    @Binding var globalSearchText: String
    
    @State private var localSearchText: String = ""

    private let features: [HomeFeature] = [
        HomeFeature(title: "Verified", systemImage: "checkmark.shield", color: .blue),
        HomeFeature(title: "Top Rated", systemImage: "arrow.up.right", color: .green),
        HomeFeature(title: "Fast Book", systemImage: "clock", color: .orange)
    ]
    
    private var filteredMovers: [HomeMover] {
        if localSearchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return HomeMover.mockMovers
        }
        
        return HomeMover.mockMovers.filter { mover in
            mover.name.localizedCaseInsensitiveContains(localSearchText) ||
            mover.city.localizedCaseInsensitiveContains(localSearchText) ||
            mover.description.localizedCaseInsensitiveContains(localSearchText)
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGray6)
                    .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        headerSection
                        
                        VStack(spacing: 20) {
                            featureCardsSection
                            featuredMoversSection
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 20)
                        .padding(.bottom, 24)
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }

    private var headerSection: some View {
        ZStack(alignment: .top) {
            LinearGradient(
                colors: [Color.blue, Color.blue.opacity(0.9)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .frame(height: 235)
            .clipShape(
                RoundedCorner(radius: 28, corners: [.bottomLeft, .bottomRight])
            )

            VStack(spacing: 22) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Move-In")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.white)

                        Text("Your moving partner")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.white.opacity(0.85))
                    }

                    Spacer()

                    Button(action: logout) {
                        HStack(spacing: 6) {
                            Image(systemName: "rectangle.portrait.and.arrow.right")
                            Text("Logout")
                        }
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(Color.white.opacity(0.18))
                        .clipShape(Capsule())
                    }
                }

                Button {
                    globalSearchText = localSearchText
                    selectedTab = .search
                } label: {
                    HStack(spacing: 12) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .font(.system(size: 18, weight: .medium))

                        TextField("Search for movers...", text: $localSearchText)
                            .font(.system(size: 17))
                            .foregroundColor(.black)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled(true)
                            .onSubmit {
                                globalSearchText = localSearchText
                                selectedTab = .search
                            }

                        if !localSearchText.isEmpty {
                            Button {
                                localSearchText = ""
                                globalSearchText = ""
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .padding(.horizontal, 18)
                    .frame(height: 60)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 18))
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal, 18)
            .padding(.top, 58)
        }
    }

    private func logout() {
        NotificationCenter.default.post(name: Notification.Name("logout"), object: nil)
    }

    private var featureCardsSection: some View {
        HStack(spacing: 14) {
            ForEach(features) { feature in
                HomeFeatureCard(feature: feature)
            }
        }
    }

    private var featuredMoversSection: some View {
        VStack(spacing: 16) {
            HStack {
                Text("Featured Movers")
                    .font(.system(size: 28, weight: .bold))

                Spacer()

                Button {
                    globalSearchText = localSearchText
                    selectedTab = .search
                } label: {
                    Text("View All")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.blue)
                }
                .buttonStyle(.plain)
            }

            ForEach(filteredMovers) { mover in
                NavigationLink {
                    VendorDetailView(mover: mover)
                } label: {
                    HomeMoverCard(mover: mover)
                }
                .buttonStyle(.plain)
            }
        }
    }
}

struct HomeFeature: Identifiable {
    let id = UUID()
    let title: String
    let systemImage: String
    let color: Color
}

struct HomeMover: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String?
    let rating: Double
    let reviewCount: Int
    let priceRange: String
    let description: String
    let city: String
    let services: [String]
    let isFeatured: Bool

    static let mockMovers: [HomeMover] = [
        HomeMover(
            name: "Swift Movers",
            imageName: nil,
            rating: 4.8,
            reviewCount: 234,
            priceRange: "$150-$300",
            description: "Professional moving services with 10+ years of experience.",
            city: "New York, NY",
            services: ["Local Moving", "Long Distance Moving", "Packing Assistance", "Furniture Handling"],
            isFeatured: true
        ),
        HomeMover(
            name: "Urban Move Co.",
            imageName: nil,
            rating: 4.7,
            reviewCount: 189,
            priceRange: "$180-$350",
            description: "Reliable local and long-distance moving with secure handling.",
            city: "Brooklyn, NY",
            services: ["Apartment Moving", "Office Relocation", "Packing", "Storage Help"],
            isFeatured: true
        )
    ]
}

struct HomeFeatureCard: View {
    let feature: HomeFeature

    var body: some View {
        VStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(feature.color.opacity(0.14))
                    .frame(width: 48, height: 48)

                Image(systemName: feature.systemImage)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(feature.color)
            }

            Text(feature.title)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 110)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .shadow(color: .black.opacity(0.06), radius: 8, x: 0, y: 4)
    }
}

struct HomeMoverCard: View {
    let mover: HomeMover

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack(alignment: .topLeading) {
                moverImage
                    .frame(height: 185)
                    .frame(maxWidth: .infinity)
                    .clipped()

                if mover.isFeatured {
                    Text("Featured")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.blue)
                        .clipShape(Capsule())
                        .padding(12)
                }
            }

            VStack(alignment: .leading, spacing: 12) {
                Text(mover.name)
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.primary)

                HStack(spacing: 8) {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)

                    Text(String(format: "%.1f", mover.rating))
                        .font(.system(size: 16, weight: .semibold))

                    Text("(\(mover.reviewCount))")
                        .foregroundColor(.gray)

                    Text("•")
                        .foregroundColor(.gray)

                    Text(mover.priceRange)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.blue)
                }

                Text(mover.description)
                    .font(.system(size: 16))
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)

                HStack(spacing: 6) {
                    Image(systemName: "location")
                        .foregroundColor(.gray)

                    Text(mover.city)
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(.gray)
                }
            }
            .padding(16)
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .black.opacity(0.08), radius: 10, x: 0, y: 5)
    }

    @ViewBuilder
    private var moverImage: some View {
        if let imageName = mover.imageName,
           let uiImage = UIImage(named: imageName) {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFill()
        } else {
            LinearGradient(
                colors: [Color.blue.opacity(0.9), Color.blue.opacity(0.55)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .overlay(
                VStack(spacing: 10) {
                    Image(systemName: "truck.box.fill")
                        .font(.system(size: 42))
                        .foregroundColor(.white)

                    Text(mover.name)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                }
            )
        }
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = 20
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

#Preview {
    HomeView(
        selectedTab: .constant(.home),
        globalSearchText: .constant("")
    )
}
