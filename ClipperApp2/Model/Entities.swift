import Foundation

/// Representa una categoría de plato en el menú.
enum DishCategory: String {
    case appetizer
    case mainCourse
    case dessert
    case beverage
}

/// Representa los datos más básicos de un repartidor que entrega los platos.
struct DeliveryPerson {
    let name: String
    let id: Double?
    
}

/// Representa un plato del menú con su información más esencial.
struct Dish {
    static let dishTableId = "dishTable"
    
    let name: String
    let imageURL: URL?
    let deliveryPerson: DeliveryPerson
    let price: Double
    let category: DishCategory
}

extension Dish {
    
    static let HotDog: Dish = Dish(
        name: "Pizza",
        imageURL: URL(string: "https://www.hola.com/horizon/landscape/e9e1e82cb873-pepperoni-pizza-abob-t.jpg"),
        deliveryPerson: .init(
            name: "Juan Pérez",
            id: 557789
           
        ),
        price: 19800,
        category: .mainCourse
    )
    

}

