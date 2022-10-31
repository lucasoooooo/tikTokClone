//
//  UploadView.swift
//  tikTokClone
//
//  Created by Lucas Balangero on 5/13/22.
//

import Foundation
import SwiftUI
import Firebase


struct UploadView: View {
    @State var radius:CGFloat = 10.0
    @State var urlX: String = ""
    @State var nameX: String = ""
    @State var fieldsEntered = false
    @State var submitted = false
//    @EnvironmentObject var directory: Directory
    
    func upload() {
        if FirebaseApp.app() == nil{
            FirebaseApp.configure()
        }
        let root = Database.database().reference()
        root.child("urls").childByAutoId().setValue(["name": nameX, "url": urlX])

    }
    
    var body: some View {
        VStack{
            Text("OpenTok Video Uploader").font(.headline).padding()
            Spacer()
            Text("To upload a new video to the Google Firebase data base, please insert a name and URL")
            
            Text("Name: ")
                
            TextField("name", text: $nameX)
                .padding()
                .background(Color.cyan)
                .cornerRadius(radius)
                .foregroundColor(Color.black)
            Text("URL: ")
            TextField("URL", text: $urlX)
                .padding()
                .background(Color.cyan)
                .cornerRadius(radius)
                .foregroundColor(Color.black)
            Text((!fieldsEntered ? "" : "Please fill out both video name and video URL"))
            Button("Upload"){
                if !urlX.isEmpty && !nameX.isEmpty{
                    upload()
                    fieldsEntered = false
                    submitted = true
                }
                else{
                    fieldsEntered = true
                }
            }
                .frame(width: 100, height: 40)
                .foregroundColor(.black)
                .background(Color.pink )
                .cornerRadius(radius)
                .alert(isPresented: $submitted) {
                    Alert(
                        title: Text("Video Uploaded Successfully"),
                        message: Text("Video was successfully uploaded to the Firebase database")
                    )
                }
            
            Spacer()
        }
        .padding()
        .foregroundColor(Color.white)
        .background(Color.black)
        
    }

}
