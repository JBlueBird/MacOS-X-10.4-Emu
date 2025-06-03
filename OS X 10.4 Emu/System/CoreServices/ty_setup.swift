//
//  ty_setup.swift
//  OS X 10.4 Emu
//
//  Created by Josiah on 6/2/25.
//

import SwiftUI

struct ty_setup: View {
    
    //VARS FOR POPUPS
    @State var showPopup1 = false
    @State var showPopup2 = false
    @State var showPopup3 = false
    @State var showPopup4 = false
    
    //VARS FOR INPUTS
    @State public var password = ""
    @State public var username = ""
    
    //VARS FOR BUTTONS
    @State var hiddenpassword = true
    @State var user_details_submitted = true
    
    //EXTRA BUT IMPORTANT
    @State var progress_state = CGFloat(0)
    
    var body: some View {
        if !user_details_submitted {
            login(password: password, username: username) //Show the login view
        }
        if user_details_submitted {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 0.0, green: 0.22, blue: 0.45),
                        Color(red: 0.0, green: 0.38, blue: 0.68),
                        Color(red: 0.0, green: 0.53, blue: 0.88),
                        Color(red: 0.05, green: 0.64, blue: 0.98),
                        Color(red: 0.18, green: 0.79, blue: 1.0)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                HStack {
                    Spacer()
                    ZStack {
                        if user_details_submitted {
                            Rectangle().frame(width: 900).foregroundStyle(Color.white)
                        }
                        VStack {
                            Text("\n")
                            if user_details_submitted {
                                HStack {
                                    Text("Thank you.").font(.system(size: 32, weight: .bold, design: .default))
                                    Spacer()
                                }.frame(width: 850)
                                HStack{Text("Learn more about why OS X EMU is a better choice for you.").font(.system(size: 20, weight: .bold, design: .default));Spacer()}.frame(width: 850)
                                Divider().frame(width: 850)
                                //Safari Item
                                HStack {Image("Safari").resizable().frame(width: 80, height: 80).clipShape(RoundedRectangle(cornerRadius: 22));VStack{HStack {Text("The web at your fingertips").bold(true).font(.system(size: 20, weight: .bold, design: .default));Spacer()};HStack {Text("Easily search the web with MacOS X EMU with Safari.");Spacer()};HStack {Button {showPopup1.toggle()} label: {Text("Learn More!")}.buttonStyle(AquaButtonStyle()).sheet(isPresented: $showPopup1) {
                                    //Content in the popup view
                                    HStack {Text("Browse the web with Safari").bold().padding().font(.system(size: 20, weight: .bold, design: .default));Spacer()}.frame(width: 700)
                                    Text("Safari is a super fast and fun web browser made by Apple, perfect for exploring your favorite websites, watching videos, and playing games—all without draining your battery or spying on you like some other browsers (we're looking at you, Chrome 😜). While Google Chrome eats up your computer’s memory like it’s at an all-you-can-eat buffet, Safari keeps things smooth, safe, and simple so you can just enjoy the internet without the drama.").padding()
                                    HStack{Spacer();Link("Learn More at Apple.com", destination: URL(string: "https://www.apple.com/safari/")!).buttonStyle(ClearWhiteAquaButtonStyle());Button {showPopup1.toggle()} label: {Text("Close").foregroundColor(Color.white)}.buttonStyle(AquaButtonStyle()); Spacer()}
                                };Spacer()};Spacer()}.frame(height: 90);Spacer()}.frame(width: 850)
                                
                                //Xterm Item
                                HStack {Image("iterm").resizable().frame(width: 80, height: 80).clipShape(RoundedRectangle(cornerRadius: 22));VStack{HStack {Text("Xterm: The better termnal").bold(true).font(.system(size: 20, weight: .bold, design: .default));Spacer()};HStack {Text("Watch out Microsoft!");Spacer()};HStack {Button {showPopup2.toggle()} label: {Text("Learn More!")}.buttonStyle(AquaButtonStyle()).sheet(isPresented: $showPopup2) {
                                    //Content in the popup view
                                    HStack {Text("Execute advanced commands faster with Xterm").bold().padding().font(.system(size: 20, weight: .bold, design: .default));Spacer()}.frame(width: 700)
                                    Text("Xterm is a termnal that aims to bring a better user GUI to the terminal. With Xterm you can execute advanced commands faster and more securely than ever before.").padding()
                                    HStack{Spacer();Button {showPopup2.toggle()} label: {Text("Close").foregroundColor(Color.white)}.buttonStyle(AquaButtonStyle()); Spacer()}
                                };Spacer()};Spacer()}.frame(height: 90);Spacer()}.frame(width: 850)
                                Divider().frame(width: 850)
                            }
                            if user_details_submitted {
                                HStack{Text("Setup your account").font(.system(size: 20, weight: .bold, design: .default));Spacer()}.frame(width: 850)
                                TextField("Please enter your username here", text: $username).textFieldStyle(AquaTextFieldStyle()).frame(width: 850);if username.trimmingCharacters(in: .whitespaces).isEmpty {HStack {Text("Please enter your username.").foregroundColor(.red);Spacer()}.frame(width: 850)}
                                
                                //Password Field
                                
                                HStack {if hiddenpassword {SecureField("Please enter your password here", text: $password).textFieldStyle(AquaTextFieldStyle())} else {TextField("Please enter your password here", text: $password).textFieldStyle(AquaTextFieldStyle())};Button {hiddenpassword.toggle()} label: {if hiddenpassword {Image(systemName: "eye.slash.circle")} else {Image(systemName: "eye.circle")}}.buttonStyle(AquaIconButtonStyle())}.frame(width: 850);if password.trimmingCharacters(in: .whitespaces).isEmpty {HStack {Text("Please enter your password.").foregroundColor(.red);Spacer()}.frame(width: 850)}
                                
                                HStack{
                                    Button{
                                        password = ""
                                        username = ""
                                    } label: {
                                        Text("Clear")
                                    }.buttonStyle(ClearWhiteAquaButtonStyle())
                                    Button{
                                        if !username.trimmingCharacters(in: .whitespaces).isEmpty && !password.trimmingCharacters(in: .whitespaces).isEmpty {
                                            user_details_submitted.toggle()
                                        }
                                    } label: {
                                        Text("Submit")
                                    }.buttonStyle(AquaButtonStyle())
                                    Spacer()
                                }.frame(width: 850)
                            }
                            Spacer()
                        }
                    }
                }
            }
        }
    }
}
