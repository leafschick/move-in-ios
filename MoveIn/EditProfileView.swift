import SwiftUI

struct EditProfileView: View {
    @Environment(\.dismiss) private var dismiss
    
    @AppStorage("currentUserEmail") private var currentUserEmail = "guest@movein.com"
    @AppStorage("currentUserPhone") private var currentUserPhone = "+1 (555) 123-4567"
    @AppStorage("currentUserLocation") private var currentUserLocation = "Los Angeles, CA"
    
    @State private var email: String = ""
    @State private var phone: String = ""
    @State private var location: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Personal Details")) {
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                    
                    TextField("Phone Number", text: $phone)
                        .keyboardType(.phonePad)
                    
                    TextField("Location", text: $location)
                }
            }
            .navigationTitle("Edit Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        currentUserEmail = email
                        currentUserPhone = phone
                        currentUserLocation = location
                        dismiss()
                    }
                    .fontWeight(.bold)
                }
            }
            .onAppear {
                email = currentUserEmail
                phone = currentUserPhone
                location = currentUserLocation
            }
        }
    }
}

#Preview {
    EditProfileView()
}
