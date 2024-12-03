//
//  MainState.swift
//  ClipperApp2
//
//  Created by Mary on 30/11/24.
//

import Foundation


struct MainModel {
    
    
    weak var collectionUpdater: CollectionUpdater?
    weak var windowOpener: WindowOpener?
    
    
    var dishes: [Dish] = [
        .init(name: "Pizza",
              imageURL: URL(string: "https://www.hola.com/horizon/landscape/e9e1e82cb873-pepperoni-pizza-abob-t.jpg"),
              deliveryPerson: .init(name: "Juan Pérez", id: 557789),
              price: 25000,
              category: .mainCourse),
        
        Dish(name: "Hamburguesa",
             imageURL: URL(string: "https://www.portafolio.co/files/article_new_multimedia/uploads/2022/04/12/6255e2e41db6c.jpeg"),
             deliveryPerson: .init(name: "Carlos García", id: 923456),
             price: 37800,
             category: .mainCourse),
        
        .init(name: "Sushi",
              imageURL: URL(string: "https://cloudfront-us-east-1.images.arcpublishing.com/elespectador/JLYGWDUSXFDI7ITQECOXNAG674.jpg"),
              deliveryPerson: .init(name: "Ana López", id: 112233),
              price: 42000,
              category: .dessert),
    ]
    
}

