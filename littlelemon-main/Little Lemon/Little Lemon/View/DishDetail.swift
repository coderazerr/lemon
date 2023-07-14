//
//  DishDetail.swift
//  Little Lemon
//
//  Created by David Roberts on 12/07/2023.
//

import SwiftUI

struct DishDetail: View {
    
    @ObservedObject private var dish: Dish
    
    init(_ dish:Dish) {
        self.dish = dish
    }
    
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        
        ZStack(alignment: .top) {
            
            VStack(alignment: .center) {
                
                Spacer(minLength: 20)
                
                if let imageString = dish.image {
                    
                    AsyncImage(url: URL(string: imageString))  { response in
                        if let image = response.image {
                            image.resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 200, height: 200, alignment: .center)
                                .cornerRadius(20)
                            
                        } else if response.error != nil {
                            Color.gray
                                .frame(width: 200, height: 200, alignment: .center)
                                .cornerRadius (20)
                        } else {
                            Color.gray
                                .frame(width: 200, height: 200, alignment: .center)
                                .cornerRadius (20)
                        }
                    }
                    .padding(.bottom, 40)
                }
                                
                VStack(alignment: .leading, spacing: 5.0) {
                    Text(dish.title ?? "")
                        .fontWeight(.bold)
                        .foregroundColor(Color.black)
                    Text(dish.itemDescription ?? "")
                        .foregroundColor(Color(red: 73/255, green: 94/255, blue: 87/255))
                    Text(dish.formattedPrice())
                        .foregroundColor(Color(red: 73/255, green: 94/255, blue: 87/255))
                    HStack {
                        Text("Category:")
                            .foregroundColor(Color(red: 73/255, green: 94/255, blue: 87/255))
                            .fontWeight(.bold)
                        Text(dish.category ?? "")
                            .foregroundColor(Color(red: 73/255, green: 94/255, blue: 87/255))
                    }
                    .padding(.top, 20)
                }
                
                Spacer()
            }
            .padding()
        }
        .toolbar{
            ToolbarItem(placement: .principal) {
                Image("LittleLemonLogo").resizable () .aspectRatio (contentMode: .fit).frame(width: 150)
            }
        }
    }
}

struct DishDetail_Previews: PreviewProvider {
    static let context = PersistenceController.shared.container.viewContext
    let dish = Dish(context: context)
    static var previews: some View {
        NavigationView {
            DishDetail(oneDish())
        }
    }
    static func oneDish() -> Dish {
        let dish = Dish(context: context)
        dish.title = "Hummus"
        dish.price = 10
        dish.itemDescription = "best description ever"
        dish.image = "https://github.com/Meta-Mobile-Developer-PC/Working-With-Data-API/blob/main/images/greekSalad.jpg?raw=true"
        dish.category = "mains"
        return dish
    }
}
