import SwiftUI
import UIKit

struct VendorDetailView: View {
    let mover: HomeMover
    @Environment(\.dismiss) private var dismiss
    @State private var showBooking = false

    var body: some View {
        ZStack(alignment: .bottom) {
            Color(.systemGray6).ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    ZStack(alignment: .topLeading) {
                        moverHeaderImage
                            .frame(height: 330)
                            .frame(maxWidth: .infinity)
                            .clipped()

                        if mover.isFeatured {
                            Text("Featured Vendor")
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundColor(.white)
                                .padding(.horizontal, 14)
                                .padding(.vertical, 7)
                                .background(Color.blue)
                                .clipShape(Capsule())
                                .padding(.top, 20)
                                .padding(.leading, 20)
                        }

                        Button { dismiss() } label: {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.black)
                                .frame(width: 44, height: 44)
                                .background(Color.white)
                                .clipShape(Circle())
                                .shadow(color: .black.opacity(0.08), radius: 8, x: 0, y: 4)
                        }
                        .padding(.top, 20)
                        .padding(.leading, 20)
                        .offset(y: mover.isFeatured ? 42 : 0)
                    }

                    VStack(alignment: .leading, spacing: 18) {
                        Text(mover.name)
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.black)

                        HStack(spacing: 8) {
                            Image(systemName: "star.fill").foregroundColor(.yellow)
                            Text(String(format: "%.1f", mover.rating))
                                .font(.system(size: 16, weight: .semibold)).foregroundColor(.black)
                            Text("(\(mover.reviewCount) reviews)")
                                .font(.system(size: 16)).foregroundColor(.gray)
                            Text("•").foregroundColor(.gray)
                            Text(mover.priceRange)
                                .font(.system(size: 16, weight: .semibold)).foregroundColor(.blue)
                        }

                        HStack(spacing: 8) {
                            Image(systemName: "mappin.and.ellipse").foregroundColor(.gray)
                            Text(mover.city).font(.system(size: 15)).foregroundColor(.gray)
                        }

                        VStack(alignment: .leading, spacing: 8) {
                            Text("About").font(.system(size: 18, weight: .bold)).foregroundColor(.black)
                            Text(mover.description)
                                .font(.system(size: 16)).foregroundColor(.gray)
                                .fixedSize(horizontal: false, vertical: true)
                        }

                        VStack(alignment: .leading, spacing: 10) {
                            Text("Services").font(.system(size: 18, weight: .bold)).foregroundColor(.black)
                            ForEach(mover.services, id: \.self) { service in
                                Text("• \(service)").font(.system(size: 16)).foregroundColor(.gray)
                            }
                        }

                        Spacer(minLength: 110)
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 28)
                    .padding(.bottom, 24)
                    .background(Color.white)
                    .clipShape(RoundedCorner(radius: 30, corners: [.topLeft, .topRight]))
                    .offset(y: -22)
                    .padding(.bottom, -22)
                }
            }

            Button { showBooking = true } label: {
                Text("Book Now")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 58)
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 18))
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 24)
        }
        .navigationBarBackButtonHidden(true)
        .sheet(isPresented: $showBooking) {
            BookingView(mover: mover)
        }
    }

    @ViewBuilder
    private var moverHeaderImage: some View {
        if let imageName = mover.imageName, let uiImage = UIImage(named: imageName) {
            Image(uiImage: uiImage).resizable().scaledToFill()
        } else {
            LinearGradient(
                colors: [Color.blue.opacity(0.95), Color.blue.opacity(0.65)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .overlay(
                VStack(spacing: 16) {
                    Image(systemName: "truck.box.fill").font(.system(size: 64)).foregroundColor(.white)
                    Text(mover.name).font(.system(size: 24, weight: .bold)).foregroundColor(.white)
                }
            )
        }
    }
}