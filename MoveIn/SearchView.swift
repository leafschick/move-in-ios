import SwiftUI
import UIKit

struct SearchView: View {
    @Binding var initialSearchText: String
    @State private var searchText: String = ""
    @State private var selectedFilter: SearchFilter = .topRated

    private var filteredMovers: [HomeMover] {
        let filtered = movers.filter { mover in
            searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
            mover.name.localizedCaseInsensitiveContains(searchText) ||
            mover.city.localizedCaseInsensitiveContains(searchText) ||
            mover.description.localizedCaseInsensitiveContains(searchText)
        }

        switch selectedFilter {
        case .topRated:
            return filtered.sorted { $0.rating > $1.rating }
        case .bestPrice:
            return filtered.sorted {
                extractMinPrice(from: $0.priceRange) < extractMinPrice(from: $1.priceRange)
            }
        }
    }

    private let movers: [HomeMover] = [
        HomeMover(
            name: "EasyMove Pro",
            imageName: nil,
            rating: 4.9,
            reviewCount: 456,
            priceRange: "$180-$350",
            description: "Premium moving service with insurance coverage included.",
            city: "Los Angeles, CA",
            services: ["Local Moving", "Insurance Coverage", "Packing Service", "Furniture Protection"],
            isFeatured: true
        ),
        HomeMover(
            name: "Family Movers Co",
            imageName: nil,
            rating: 4.7,
            reviewCount: 289,
            priceRange: "$140-$260",
            description: "Friendly and affordable movers for homes and apartments.",
            city: "San Diego, CA",
            services: ["Family Moves", "Apartment Relocation", "Packing", "Loading Help"],
            isFeatured: false
        ),
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
            rating: 4.6,
            reviewCount: 198,
            priceRange: "$160-$290",
            description: "Reliable local and long-distance moving with secure handling.",
            city: "Brooklyn, NY",
            services: ["Office Moves", "Apartment Moves", "Packing", "Storage Support"],
            isFeatured: false
        ),
        HomeMover(
            name: "Golden Route Movers",
            imageName: nil,
            rating: 4.5,
            reviewCount: 165,
            priceRange: "$120-$220",
            description: "Budget-friendly moving team with quick booking options.",
            city: "Sacramento, CA",
            services: ["Budget Moves", "Quick Booking", "Local Relocation", "Basic Packing"],
            isFeatured: false
        ),
        HomeMover(
            name: "Prime Relocation",
            imageName: nil,
            rating: 4.8,
            reviewCount: 321,
            priceRange: "$200-$380",
            description: "Trusted relocation specialists for large and complex moves.",
            city: "Chicago, IL",
            services: ["Large Moves", "Commercial Moving", "Packing", "Special Item Handling"],
            isFeatured: true
        )
    ]

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                topBar
                searchAndFilterSection

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("\(filteredMovers.count) movers found")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.gray)
                            .padding(.top, 18)

                        ForEach(filteredMovers) { mover in
                            NavigationLink {
                                VendorDetailView(mover: mover)
                            } label: {
                                SearchMoverCard(mover: mover)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 24)
                }
                .background(Color(.systemGray6))
            }
            .background(Color(.systemGray6).ignoresSafeArea())
            .navigationBarHidden(true)
            .onAppear {
                searchText = initialSearchText
            }
            .onChange(of: initialSearchText) { newValue in
                searchText = newValue
            }
            .onChange(of: searchText) { newValue in
                initialSearchText = newValue
            }
        }
    }

    private var topBar: some View {
        VStack(spacing: 0) {
            HStack(spacing: 16) {
                Image(systemName: "arrow.left")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.black)

                Text("Find Movers")
                    .font(.system(size: 26, weight: .bold))
                    .foregroundColor(.black)

                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.top, 18)
            .padding(.bottom, 18)

            Divider()
        }
        .background(Color.white)
    }

    private var searchAndFilterSection: some View {
        VStack(spacing: 14) {
            HStack(spacing: 12) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                    .font(.system(size: 18, weight: .medium))

                TextField("Search by location or name...", text: $searchText)
                    .font(.system(size: 16))
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)

                if !searchText.isEmpty {
                    Button {
                        searchText = ""
                        initialSearchText = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(.horizontal, 16)
            .frame(height: 48)
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 14))

            HStack(spacing: 10) {
                filterButton(title: "Top Rated", filter: .topRated)
                filterButton(title: "Best Price", filter: .bestPrice)

                Button {
                } label: {
                    Image(systemName: "slider.horizontal.3")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.gray)
                        .frame(width: 48, height: 44)
                        .background(Color(.systemGray6))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 16)
        .background(Color.white)
    }

    private func filterButton(title: String, filter: SearchFilter) -> some View {
        Button {
            selectedFilter = filter
        } label: {
            Text(title)
                .font(.system(size: 15, weight: .semibold))
                .foregroundColor(selectedFilter == filter ? .white : .gray)
                .frame(maxWidth: .infinity)
                .frame(height: 44)
                .background(selectedFilter == filter ? Color.blue : Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }

    private func extractMinPrice(from priceRange: String) -> Int {
        let numbers = priceRange
            .replacingOccurrences(of: "$", with: "")
            .components(separatedBy: "-")
            .compactMap { Int($0.trimmingCharacters(in: .whitespaces)) }

        return numbers.first ?? 0
    }
}

enum SearchFilter {
    case topRated
    case bestPrice
}

struct SearchMoverCard: View {
    let mover: HomeMover

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack(alignment: .topLeading) {
                moverImage
                    .frame(height: 170)
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

            VStack(alignment: .leading, spacing: 10) {
                Text(mover.name)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.primary)

                HStack(spacing: 8) {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)

                    Text(String(format: "%.1f", mover.rating))
                        .font(.system(size: 15, weight: .semibold))

                    Text("(\(mover.reviewCount))")
                        .foregroundColor(.gray)

                    Text("•")
                        .foregroundColor(.gray)

                    Text(mover.priceRange)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.blue)
                }

                Text(mover.description)
                    .font(.system(size: 15))
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)

                HStack(spacing: 6) {
                    Image(systemName: "location")
                        .foregroundColor(.gray)

                    Text(mover.city)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.gray)
                }
            }
            .padding(14)
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .shadow(color: .black.opacity(0.06), radius: 8, x: 0, y: 4)
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
                colors: [Color.orange.opacity(0.85), Color.blue.opacity(0.75)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .overlay(
                VStack(spacing: 10) {
                    Image(systemName: "truck.box.fill")
                        .font(.system(size: 36))
                        .foregroundColor(.white)

                    Text(mover.name)
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 10)
                }
            )
        }
    }
}

#Preview {
    SearchView(initialSearchText: .constant(""))
}
