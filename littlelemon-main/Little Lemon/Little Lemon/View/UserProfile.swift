//
//  Little_LemonApp.swift
//  Little Lemon
//
//  Created by David Roberts on 11/07/2023.
//


import SwiftUI

struct UserProfile: View {
    
    @Environment(\.presentationMode) var presentation

    @State var changedFirstName = ""
    @State var changedLastName = ""
    @State var changedEmail = ""
    
    var body: some View {
        NavigationView {
            
            ScrollView {
                VStack{
                    VStack(alignment: .center){
                        
                        Text("Personal Information").padding(.top).font(.title3).fontWeight(.bold)
                        
                        HStack{
                            VStack(alignment: .leading){
                                Image("profile-image-placeholder")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame (width: 150, height: 150, alignment: .top)
                                    .cornerRadius (100)
                            }
                            Button(action: {
                                // What to perform
                            }) {
                                Text("Change")
                                    .padding()
                                    .background(Color(red: 237/255, green: 239/255, blue: 238/255))
                                    .foregroundColor(.gray)
                                    .font(.subheadline)
                                    .cornerRadius(20)
                            }
                            Button(action: {
                                // What to perform
                            }) {
                                Text("Remove")
                                    .padding()
                                    .background(Color(red: 237/255, green: 239/255, blue: 238/255))
                                    .foregroundColor(.gray)
                                    .font(.subheadline)
                                    .cornerRadius(20)
                            }
                            Spacer()
                        }
                        VStack(alignment: .leading){
                            Text("First Name").foregroundColor(.gray)
                            TextField("First Name", text: $changedFirstName)
                                .textFieldStyle(.roundedBorder)
                        }.padding(.top)
                        VStack(alignment: .leading){
                            Text("Last Name").foregroundColor(.gray)
                            TextField("Last Name", text: $changedLastName)
                                .textFieldStyle(.roundedBorder)
                        }.padding(.top)
                        VStack(alignment: .leading){
                            Text("Email").foregroundColor(.gray)
                            TextField("Last Name", text: $changedEmail)
                                .textFieldStyle(.roundedBorder)
                        }.padding(.top)
                        HStack{
                            Spacer()
                            Button(action: {
                                UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                                self.presentation.wrappedValue.dismiss()
                            }) {
                                Text("Logout")
                                    .padding()
                                    .fontWeight(.bold)
                                    .background(Color(red: 244/255, green: 206/255, blue: 20/255))
                                    .foregroundColor(.black)
                                    .font(.subheadline)
                                    .cornerRadius(20)
                                
                            }
                            Spacer()
                        }.padding(.top)
                        
                        HStack{
                            Spacer()
                            Button(action: {
                                changedFirstName = UserDefaults.standard.string(forKey: kFirstName) ?? ""
                                changedLastName = UserDefaults.standard.string(forKey: kLastName) ?? ""
                                changedEmail = UserDefaults.standard.string(forKey: kEmail) ?? ""
                            }) {
                                Text("Discard Changes")
                                    .padding()
                                    .background(.white)
                                    .foregroundColor(.gray)
                                    .fontWeight(.bold)
                                    .font(.subheadline)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(Color(red: 237/255, green: 239/255, blue: 238/255), lineWidth: 3))
                            }
                            Button(action: {
                                UserDefaults.standard.set(changedFirstName, forKey: kFirstName)
                                UserDefaults.standard.set(changedLastName, forKey: kLastName)
                                UserDefaults.standard.set(changedEmail, forKey: kEmail)
                                UserDefaults.standard.synchronize()
                            }) {
                                Text("Save Changes")
                                    .padding()
                                    .background(Color(red: 73/255, green: 94/255, blue: 87/255))
                                    .foregroundColor(.white)
                                    .fontWeight(.bold)
                                    .font(.subheadline)
                                    .cornerRadius(20)
                            }
                            Spacer()
                        }.padding()
                        Spacer()
                    }
                    .padding([.leading,.trailing])
                    
                }
                .padding(.top)
                .onAppear(){
                    changedFirstName = UserDefaults.standard.string(forKey: kFirstName) ?? ""
                    changedLastName = UserDefaults.standard.string(forKey: kLastName) ?? ""
                    changedEmail = UserDefaults.standard.string(forKey: kEmail) ?? ""
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            UserProfile()
        }
    }
}
