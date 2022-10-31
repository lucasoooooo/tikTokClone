//
//  PlayerView.swift
//  tikTokClone
//
//  Created by Lucas Balangero on 5/13/22.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseDatabase
import AVKit

struct PlayerView: View {
    enum SwipeDirection: String{
            case up, down, none
        }
    @State var i: Int = 0
    @State var swipeDirection: SwipeDirection = .none { didSet {}}
    @State var likesX: Int = 0
    @State var idX: String = ""
    @State var nameX: String = "Dog Confused"
    @State var radius:CGFloat = 10.0
    @State var listOfVideos: [String] = []
    @State var currentLink: String = "https://v.redd.it/m3ujhmpum5901/DASH_600_K"
//    var video: DirEntry
    
    func prevX() {
        if i>0{
            i = i - 1
        }
        updateX()
        print("Prev Video")
    }
    func nextX() {
        i = i+1
        updateX()
        print("Next video")
    }
//
//    func convertToDictionary(text: String) -> [String: Any]? {
//        if let data = text.data(using: .utf8) {
//            do {
//                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
//            } catch {
//                print(error.localizedDescription)
//            }
//        }
//        return nil
//    }

    func updateX() {
        print("i = \(i)")
        listOfVideos = []
        if FirebaseApp.app() == nil{
            FirebaseApp.configure()
        }
        let ref = Database.database().reference()
//        var valueX: Dictionary<String, Any>
        ref.child("urls").observeSingleEvent(of: .value, with: { (snapshot) in
                // Get user value
//                let value = snapshot.value as? Dictionary<String, Any>
           let values = snapshot.value as? NSDictionary
//            print(values?.allKeys)
            
            for (keyX, valX) in values!{
//                print(keyX)
                let temp = (valX as? Dictionary<String, Any>)
                if (temp?["likes"] == nil){
                    listOfVideos.append(keyX as! String)
                }
            }
            if i >= listOfVideos.count{
                i = 0
            }
            let tempName = (values?[listOfVideos[i]])
            let temp = (tempName as? Dictionary<String, Any>)

            if (temp!["likes"] == nil){
                currentLink = temp!["url"] as! String
                nameX = temp!["name"] as! String
            }
            
            likesX = 0
            
            for (_, valX) in values!{
//                print(keyX)
                let temp = (valX as? Dictionary<String, Any>)
                if (temp?["likes"] != nil){
                    if (temp?["url"] as! String == currentLink){
                        likesX = likesX + 1
                    }
                }
            }
            ref.child("seens").child("user").setValue([nameX:"1"])
            }) { (error) in
                    print(error.localizedDescription)
        }
        
        
    }
    func likeVideoX(){
        
        if FirebaseApp.app() == nil{
            FirebaseApp.configure()
        }
        let ref = Database.database().reference()
        ref.child("urls").childByAutoId().setValue(["likes": ["user":"1"],"name": nameX, "url": currentLink])
        updateX()
        print("Liked video")

    }
    
    
    var body: some View {
//        VStack{
            ZStack{
                Text("Video here")
                VideoPlayer(player: AVPlayer(url: URL(string: currentLink)!))
                VStack{
                    Text("OpenTok Media Player: For You")
                     .font(.headline)
                     .padding()
                 
                 //Media Player here
                     VStack(alignment: .trailing){
                         Spacer()
                         Button("🤍",action: likeVideoX)
                             .frame(width: 50, height: 40)
                             .foregroundColor(.black)
                             .background(Color.white )
                             .cornerRadius(radius)
                             
                         Text("\(likesX)")
                         Button("Prev", action: prevX)
                             .frame(width: 70, height: 40)
                             .foregroundColor(.black)
                             .background(Color.white )
                             .cornerRadius(radius)
                         Button("Next", action: nextX)
                             .frame(width: 70, height: 40)
                             .foregroundColor(.black)
                             .background(Color.white )
                             .cornerRadius(radius)
                         
                         Button("Update Media", action: updateX)
                             .frame(width: 150, height: 40)
                             .foregroundColor(.black)
                             .background(Color.white )
                             .cornerRadius(radius)
                         Spacer()
                     }
                     .frame(maxWidth: .infinity, maxHeight: .infinity)
                     .offset(x:100, y:120)
                    VStack(alignment: .leading){
                        Text("Video Name Here: \(nameX)")
                        Text("Video URL Here: \(currentLink.truncate(length: 25))")
                        Text("                                                                                                                ")
                    }
                    .padding()
                    .offset(x:0, y:-10)
                 }
              
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.gray)
            .foregroundColor(Color.white)
            .gesture(DragGesture(minimumDistance: 50.0, coordinateSpace: .local).onEnded{
                            if $0.startLocation.y > $0.location.y {
                                self.swipeDirection = .up
                                nextX()
                            }else if $0.startLocation.y < $0.location.y {
                                self.swipeDirection = .down
                                prevX()

                            }else {
                                self.swipeDirection = .none
                               
                            }
                            })
    }
}
extension String{
    func truncate(length: Int, trailing: String = "…") -> String {
        return (self.count > length) ? self.prefix(length) + trailing : self
      }
}
