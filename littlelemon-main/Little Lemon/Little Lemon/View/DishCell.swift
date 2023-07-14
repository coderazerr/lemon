//
// DisplayDish.swift



import SwiftUI


struct DishCell: View {
    
    @ObservedObject private var dish: Dish
    
    init(_ dish:Dish) {
        self.dish = dish
    }
    
    var body: some View {        
        VStack{
            HStack{
                
                VStack(alignment: .leading, spacing: 3.0) {
                    Text(dish.title ?? "")
                        .fontWeight(.bold)
                        .foregroundColor(Color.black)
                    Text(dish.itemDescription ?? "")
                        .foregroundColor(Color(red: 73/255, green: 94/255, blue: 87/255))
                        .lineLimit(2)
                    Text(dish.formattedPrice())
                }
                
                Spacer()
                
                if let imageString = dish.image {
                    
                    AsyncImage(url: URL(string: imageString))  { response in
                        if let image = response.image {
                            image.resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 75, height: 75, alignment: .center)
                                .cornerRadius(5)

                        } else if response.error != nil {
                            Color.gray
                                .frame(width: 75, height: 75, alignment: .center)
                                .cornerRadius (5)
                        } else {
                            Color.gray
                                .frame(width: 75, height: 75, alignment: .center)
                                .cornerRadius (5)
                        }
                    }
                }
                                
            }
            
            Divider()
                .padding([.leading, .trailing])
        }
        .padding([.top, .leading, .trailing], 20)
        .padding(.bottom, 0)
    }
}

struct DishCell_Previews: PreviewProvider {
    static let context = PersistenceController.shared.container.viewContext
    let dish = Dish(context: context)
    static var previews: some View {
        DishCell(oneDish())
    }
    static func oneDish() -> Dish {
        let dish = Dish(context: context)
        dish.title = "Hummus"
        dish.price = 10
        dish.itemDescription = "best description ever"
        dish.image = "https://github.com/Meta-Mobile-Developer-PC/Working-With-Data-API/blob/main/images/greekSalad.jpg?raw=true"
        return dish
    }
}

