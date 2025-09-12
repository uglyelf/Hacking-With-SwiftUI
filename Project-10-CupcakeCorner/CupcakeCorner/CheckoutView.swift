//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Gregory Randolph on 9/10/25.
//

import SwiftUI

struct CheckoutView: View {
    var order: Order
    
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 300)
                
                Text("Your total is \(order.cost, format: .currency(code: "USD"))")
                    .font(.title)
                
                Button("Place Order") {
                    Task {
                        await placeOrder()
                    }
                }
                    .padding()
            }
        }
        .navigationTitle(Text("Checkout"))
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Thank you", isPresented: $showingConfirmation) {
            Button("OK") { }
        } message: {
            Text(confirmationMessage)
        }
    }
    
    func placeOrder() async {
        guard let encodedOrder = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }
        print("ENCODED:\n\(String(decoding: encodedOrder, as: UTF8.self))")  // debugging
        
        /**
         Note: this doesn't work anymore. At the time I went through this tutorial, Sept 2025, reqres no longer provided an echo service.
         */
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/JSON", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encodedOrder)
            print("RESPONSE:\n\(String(decoding: data, as: UTF8.self))") // debugging
            
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupdcakes is on its way!"
            showingConfirmation.toggle()
        }  catch {
            let message = "Checkout failed: \(error.localizedDescription)"
            confirmationMessage = message
            showingConfirmation.toggle()
        }
    }
}

#Preview {
    CheckoutView(order: Order())
}
