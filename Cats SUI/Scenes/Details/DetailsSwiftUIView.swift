//
//  DetailsSwiftUIView.swift
//  Cats SUI
//
//  Created by Evens Taian on 06/02/25.
//

import SwiftUI

struct DetailsSwiftUIView<VM>: View where VM: DetailsViewmodeling {
    
    @ObservedObject private var viewModel: VM
    
    init(viewModel: VM){
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                GeometryReader { geometry in
                    AsyncImage(url: URL(string: viewModel.detailsData?.url ?? "")) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geometry.size.width, height: 400)
                            .clipped()
                    } placeholder: {
                        ProgressView()
                            .frame(width: geometry.size.width, height: 400)
                    }
                }
                .frame(height: 400)
                
                ZStack {
                    Color(.systemBackground)
                        .cornerRadius(20, corners: [.topLeft, .topRight])
                        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: -5)
                    
                    VStack(spacing: 24) {
                        if let breed = viewModel.detailsData?.breeds?.first {
                            VStack(spacing: 8) {
                                Text(breed.name)
                                    .font(.system(size: 32, weight: .bold))
                                    .foregroundColor(.primary)
                                
                                Text("Origin: \(breed.origin)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.top, 24)
                            
                            VStack(spacing: 20) {
                                SectionCardComponent {
                                    VStack(alignment: .leading, spacing: 16) {
                                        Label("Weight Information", systemImage: "scalemass")
                                            .font(.headline)
                                        
                                        HStack(spacing: 20) {
                                            WeightCardComponent(title: "Imperial", value: breed.weight.imperial)
                                            WeightCardComponent(title: "Metric", value: breed.weight.metric)
                                        }
                                    }
                                }
                                
                                SectionCardComponent {
                                    VStack(alignment: .leading, spacing: 16) {
                                        Label("Characteristics", systemImage: "pawprint")
                                            .font(.headline)
                                        
                                        InfoRowComponent(title: "Temperament", value: breed.temperament)
                                        InfoRowComponent(title: "Life Span", value: "\(breed.lifeSpan) years")
                                        InfoRowComponent(title: "Country", value: "\(breed.origin) (\(breed.countryCode))")
                                    }
                                }
                                
                                if let wikipediaUrl = URL(string: breed.wikipediaUrl) {
                                    Link(destination: wikipediaUrl) {
                                        HStack {
                                            Image(systemName: "book.fill")
                                            Text("Read More on Wikipedia")
                                            Spacer()
                                            Image(systemName: "arrow.right")
                                        }
                                        .padding()
                                        .background(Color.blue.opacity(0.1))
                                        .foregroundColor(.blue)
                                        .cornerRadius(12)
                                    }
                                }
                            }
                            
                            if let width = viewModel.detailsData?.width,
                               let height = viewModel.detailsData?.height {
                                SectionCardComponent {
                                    VStack(alignment: .leading, spacing: 12) {
                                        Label("Technical Details", systemImage: "photo")
                                            .font(.headline)
                                        
                                        Text("Image Dimensions: \(width) × \(height)")
                                            .foregroundColor(.secondary)
                                    }
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 24)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.systemBackground))
        .edgesIgnoringSafeArea(.top)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                              byRoundingCorners: corners,
                              cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

#Preview {
    DetailsFactory.makeModule(id: "1")
}
