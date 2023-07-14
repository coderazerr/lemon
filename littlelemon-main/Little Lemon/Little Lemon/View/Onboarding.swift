//
//  Little_LemonApp.swift
//  Little Lemon
//
//  Created by David Roberts on 11/07/2023.
//

import SwiftUI

let kIsLoggedIn = "kIsLoggedIn"
let kFirstName = "first name key"
let kLastName = "last name key"
let kEmail = "email key"

struct Onboarding: View {
    
    @State private var isLoggedIn = false
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    
    var body: some View {
        NavigationView {
            
            VStack{
                
                NavigationLink(destination: Home(), isActive: $isLoggedIn){
                    EmptyView()
                }
                
                VStack {
                    
                    Logo()
                    
                    Hero()

                    Text("Sign Up")
                        .font(.custom("Karla", size: 32))
                    Group {
                        TextField("Name", text: $firstName)
                            .padding()
                            .frame(width: 300, height: 50)
                            .background(Color.black.opacity(0.05))
                            .cornerRadius(10)
                        TextField("Last Name", text: $lastName)
                            .padding()
                            .frame(width: 300, height: 50)
                            .background(Color.black.opacity(0.05))
                            .cornerRadius(10)
                        TextField("Email", text: $email)
                            .padding()
                            .frame(width: 300, height: 50)
                            .background(Color.black.opacity(0.05))
                            .cornerRadius(10)
                        
                        VStack {
                            
                            Button("Register"){
                                
                                if !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty {
                                    UserDefaults.standard.set(true, forKey: kIsLoggedIn)
                                    UserDefaults.standard.set(firstName, forKey: kFirstName)
                                    UserDefaults.standard.set(lastName, forKey: kLastName)
                                    UserDefaults.standard.set(email, forKey: kEmail)
                                    isLoggedIn.toggle()
                                }
                            }
                            .buttonStyle(ButtonColor())
                        }
                        .font(.custom("Karla", size: 18))
                        .padding(.top, 15)
                    }
                }
                .offset(y: -50)
            }
        }
        .onAppear {
            if(UserDefaults.standard.bool(forKey: kIsLoggedIn)){
                isLoggedIn = true
            }
        }
    }
}

struct Hero: View {
    
    var body: some View {
        VStack {
            HStack{
                VStack(alignment: .leading, spacing: 5.0){
                    Text("Little Lemon")
                        .font(Font.custom("American Typewriter", size: 32.0))
                        .foregroundColor(Color(red: 244/255, green: 206/255, blue: 20/255))
                        .fontWeight(.semibold)
                    Text("Chicago")
                        .font(Font.custom("American Typewriter", size: 24.0))
                        .foregroundColor(Color(red: 237/255, green: 239/255, blue: 238/255))
                    Text("We are a family owned Mediterranean restuaurant, focused on traditional recipes served with a modern twist.")
                        .foregroundColor(Color(red: 237/255, green: 239/255, blue: 238/255))
                        .font(.footnote)
                }.padding()
                Spacer()
                Image("Hero image").resizable () .aspectRatio (contentMode: .fit) .frame (width: 120, alignment: .top) .cornerRadius (20)
                    .padding()
            }.background(Color(red: 73/255, green: 94/255, blue: 87/255))
        }
        .background(Color("#495E57"))
    }
}

struct ButtonColor: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.custom("Karla", size: 24))
            .frame(width: 280, height: 30)
            .foregroundColor(configuration.isPressed ? .black : .white)
            .padding(10)
            .background(configuration.isPressed ? Color("#F4CE14") : Color("#495E57"))
            .cornerRadius(10)
            .padding(.horizontal)
    }
}

struct Logo: View{
    var body: some View{
        Image("LittleLemonLogo")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 150, height: 38)
            .padding([.bottom], 10)
    }
}



struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}
