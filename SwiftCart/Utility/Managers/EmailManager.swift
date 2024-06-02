//
//  EmailManager.swift
//  SwiftCart
//
//  Created by Ramez Hamdi Saeed on 01/06/2024.
//

import Foundation

class EmailManager {
    
    func sendEmail() {
        // Your SendGrid API key
        let apiKey = "YOUR_SENDGRID_API_KEY"

        // SendGrid API endpoint
        let url = URL(string: "https://api.sendgrid.com/v3/mail/send")!

        // Email data
        let emailData: [String: Any] = [
            "personalizations": [
                [
                    "to": [
                        ["email": "recipient@example.com"]
                    ],
                    "subject": "Test Email"
                ]
            ],
            "from": ["email": "your-email@example.com"],
            "content": [
                [
                    "type": "text/plain",
                    "value": "This is a test email from SendGrid."
                ]
            ]
        ]

        // Convert email data to JSON
        guard let jsonData = try? JSONSerialization.data(withJSONObject: emailData) else {
            print("Error converting email data to JSON")
            return
        }

        // Create HTTP request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.httpBody = jsonData

        // Send the request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
            } else if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Response Status Code: \(httpResponse.statusCode)")
            }
        }

        task.resume()
    }

//    // Call the function to send the email
//    sendEmail()
}

