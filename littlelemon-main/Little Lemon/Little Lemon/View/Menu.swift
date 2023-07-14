//
//  Little_LemonApp.swift
//  Little Lemon
//
//  Created by David Roberts on 11/07/2023.
//


import SwiftUI
import CoreData

struct Menu: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var searchText = ""
    @State var categoryText = ""
    
    @State var startersIsEnabled = true
    @State var mainsIsEnabled = true
    @State var dessertsIsEnabled = true
    @State var drinksIsEnabled = true
    
    @State var isLoaded = false
    @State var isProfileSetting = false
    @State var isRootActive = false

    func buildSortDescriptors() -> [NSSortDescriptor] {
        return [
            NSSortDescriptor(key: "title", ascending: true, selector:  #selector(NSString.localizedStandardCompare))
        ]
    }
    
    func buildPredicate() -> NSPredicate {
        if(searchText.isEmpty && categoryText.isEmpty) {
            return NSPredicate(value: true)
        }
        else if(!categoryText.isEmpty && searchText.isEmpty) {
            return NSPredicate(format: "category CONTAINS[cd] %@", categoryText)
        }
        else if(!categoryText.isEmpty && !searchText.isEmpty){
            return NSPredicate(format: "(category CONTAINS[cd] %@) AND (title CONTAINS[cd] %@)", categoryText, searchText)
        }
        else {
            return NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        }
    }
    
    var body: some View {
        
        NavigationStack {
            
            VStack(spacing: 0) {
                
                Hero()
                
                HStack {
                    
                    Spacer(minLength: 20)
                    
                    HStack (alignment: .center) {
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .frame(width: 15, height: 15, alignment: .center)
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: 15)
                            .frame(minHeight: 0, maxHeight: 15)
                        TextField ("Search Menu", text: $searchText)
                    }
                    .padding([.top,.bottom], 8)
                    .padding(.leading, 8)
                    .background(Color.white, alignment: .center)
                    .cornerRadius(10)
                    
                    Spacer(minLength: 5)
                    
                }
                .padding([.top], 0)
                .padding([.bottom])
                .background(Color("#495E57"))
                
                VStack(alignment: .leading){
                    MenuBreakdown(categoryText: $categoryText)
                }
               .padding([.leading, .trailing], 0)
                
                Divider()
                    .padding([.leading, .trailing])
                
                FetchedObjects(
                    predicate: buildPredicate(),
                    sortDescriptors: buildSortDescriptors()
                ) { (dishes: [Dish]) in
                    List {
                        ForEach(dishes, id: \.self) { dish in
                            NavigationLink(value: dish) {
                                DishCell(dish)
                            }
                        }
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets())
                    }
                    .navigationDestination(for: Dish.self) { dish in
                        DishDetail(dish)
                    }
                    .listStyle(.plain)
                }
            }
            .onAppear {
                if !isLoaded {
                    MenuList.getMenuData(viewContext: viewContext)
                    isLoaded = true
                }
            }
            .navigationBarBackButtonHidden(true)
            .toolbar{
                ToolbarItem(placement: .principal) {
                    Image("LittleLemonLogo").resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Image("profile-image-placeholder") .resizable () .aspectRatio (contentMode: .fill) .frame (width: 38, height: 38, alignment: .top) .cornerRadius (19)
                }
            }
            .toolbarBackground(Color.white, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        let localPreview = PersistenceController.shared
        Menu().environment(\.managedObjectContext, localPreview.container.viewContext)
    }
}

struct MenuBreakdown: View {
    
    @Binding var categoryText: String
    
    var body: some View {
        
        VStack(alignment: .leading){
            Text("ORDER FOR DELIVERY!")
                .fontWeight(.bold)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    Button("Starters", action: {
                        setCategoryMenu(name:"starters")
                    }).padding()
                        .fontWeight(.bold)
                        .font(.subheadline)
                        .foregroundColor(Color(red: 73/255, green: 94/255, blue: 87/255))
                        .background((categoryText == "starters") ? Color(red: 244/255, green: 206/255, blue: 20/255) : Color(red: 237/255, green: 239/255, blue: 238/255))
                        .frame(height: 38)
                        .cornerRadius(19)
                    Button("Mains", action: {
                        setCategoryMenu(name:"mains")
                    }).padding()
                        .fontWeight(.bold)
                        .font(.subheadline)
                        .foregroundColor(Color(red: 73/255, green: 94/255, blue: 87/255))
                        .background((categoryText == "mains") ? Color(red: 244/255, green: 206/255, blue: 20/255) : Color(red: 237/255, green: 239/255, blue: 238/255))
                        .frame(height: 38)
                        .cornerRadius(19)
                    Button("Desserts", action: {
                        setCategoryMenu(name: "desserts")
                    }).padding()
                        .fontWeight(.bold)
                        .font(.subheadline)
                        .foregroundColor(Color(red: 73/255, green: 94/255, blue: 87/255))
                        .background((categoryText == "desserts") ? Color(red: 244/255, green: 206/255, blue: 20/255) : Color(red: 237/255, green: 239/255, blue: 238/255))
                        .frame(height: 38)
                        .cornerRadius(19)
                    Button("Drinks", action: {
                        setCategoryMenu(name: "drinks")
                    }).padding()
                        .fontWeight(.bold)
                        .font(.subheadline)
                        .foregroundColor(Color(red: 73/255, green: 94/255, blue: 87/255))
                        .background((categoryText == "drinks") ? Color(red: 244/255, green: 206/255, blue: 20/255) : Color(red: 237/255, green: 239/255, blue: 238/255))
                        .frame(height: 38)
                        .cornerRadius(19)
                }
            }
        }
        .padding([.top, .bottom])
        .padding([.leading], 20)
    }
    
    func setCategoryMenu(name: String) {
        if(categoryText == name){
            categoryText = ""
        } else {
            categoryText = name
        }
    }
}

