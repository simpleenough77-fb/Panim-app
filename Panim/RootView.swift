import SwiftUI

/// Placeholder root for the M2 foundation. No product features exist yet.
struct RootView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text(verbatim: "Panim")
                .font(.custom(BrandFonts.semibold, size: 40, relativeTo: .largeTitle))
                .accessibilityAddTraits(.isHeader)
            Text("root.status")
                .font(.custom(BrandFonts.regular, size: 18, relativeTo: .body))
        }
        .multilineTextAlignment(.center)
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    RootView()
}
