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
                // Image Section
                AsyncImage(url: URL(string: viewModel.detailsData?.url ?? "")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    ProgressView()
                }
                .frame(maxWidth: .infinity)
                .frame(height: 400)
                .clipped()
                
                // Content Section
                VStack(spacing: 24) {
                    if let breed = viewModel.detailsData?.breeds?.first {
                        // Breed Header
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
                        
                        // Breed Details
                        VStack(spacing: 20) {
                            // Weight Section
                            SectionCard {
                                VStack(alignment: .leading, spacing: 16) {
                                    Label("Weight Information", systemImage: "scalemass")
                                        .font(.headline)
                                    
                                    HStack(spacing: 20) {
                                        WeightCard(title: "Imperial", value: breed.weight.imperial)
                                        WeightCard(title: "Metric", value: breed.weight.metric)
                                    }
                                }
                            }
                            
                            // Characteristics Section
                            SectionCard {
                                VStack(alignment: .leading, spacing: 16) {
                                    Label("Characteristics", systemImage: "pawprint")
                                        .font(.headline)
                                    
                                    InfoRow(title: "Temperament", value: breed.temperament)
                                    InfoRow(title: "Life Span", value: "\(breed.lifeSpan) years")
                                    InfoRow(title: "Country", value: "\(breed.origin) (\(breed.countryCode))")
                                }
                            }
                            
                            // Wikipedia Link
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
                        
                        // Technical Details
                        if let width = viewModel.detailsData?.width,
                           let height = viewModel.detailsData?.height {
                            SectionCard {
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
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.systemBackground))
        .edgesIgnoringSafeArea(.top)
    }
}

struct SectionCard<Content: View>: View {
    let content: () -> Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    var body: some View {
        content()
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(16)
    }
}

struct InfoRow: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.secondary)
            Text(value)
                .font(.body)
        }
    }
}

struct WeightCard: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(spacing: 8) {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.secondary)
            Text(value)
                .font(.headline)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.blue.opacity(0.1))
        .cornerRadius(12)
    }
}

#Preview {
    DetailsFactory.makeModule(id: "1")
}
