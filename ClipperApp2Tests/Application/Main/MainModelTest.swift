//
//  MainModelTest.swift
//  ClipperApp2Tests
//
//  Created by Mary on 4/12/24.
//

import Testing


@testable import ClipperApp2
import XCTest


class FakeWindowOpener: WindowOpener {
    var windowOpenedSpy = false
    
    func openNewDishWindow() {
        windowOpenedSpy = true
    }
}

class FakeCollectionUpdater: CollectionUpdater {
    
    var collectionUpdatedSpy = false
    
    func reloadCollection() {
        collectionUpdatedSpy = true
    }
    
}


final class MainModelTests: XCTestCase {
    

    func testUserWantsToDeleteDish() {
        // Dado
        var model = MainModel()
        model.dishes = [
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
        let positionToDelete = 1
        let initialCount = model.dishes.count
        let dishToDelete = model.dishes[positionToDelete]
        
        // Cuando
        model.userWantsToDeleteDish(position: positionToDelete)
        
        // Entonces
        // 1. Esperamos que haya un elemento menos
        
        XCTAssertEqual(initialCount - 1, model.dishes.count)
       // XCTAssertEqual(initialCount - 1, model.dishes.count)
        
        
        let containsDish = model.dishes.contains(where: {
            $0.name == dishToDelete.name
        })
        XCTAssertFalse(containsDish)
    }
    
    func testUserWantsToAddPlaceholder() {
        // Dado
        var model = MainModel()
        model.dishes = [
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
        
        
        let initialCount = model.dishes.count
        let expectedNewDish = Dish.HotDog
        
        // Cuando
        model.userWantsToAddPlaceholderDish()
        
      
        
        let containsPlaceholderDish = model.dishes.contains(where: {
            
            $0.name == expectedNewDish.name
            
        })
        
        XCTAssertTrue(containsPlaceholderDish)
        
     
        XCTAssertEqual(model.dishes.count, initialCount + 1)
        
        
    }
    
    // Aprendimos acerca de los espias
    func testUserWantsToCreateNewDish() {
        // Dado
        var sujetoDePrueba = MainModel()
        
       let windowOpenerDelegate = FakeWindowOpener()
        
        //sujetoDePrueba.windowOpenerDelegate = windowOpenerDelegate
        
        sujetoDePrueba.windowOpener = windowOpenerDelegate
        XCTAssertFalse(windowOpenerDelegate.windowOpenedSpy)
        
        // Cuando
        sujetoDePrueba.userWantsToCreateNewDish()
        
        // Entonces
        XCTAssertTrue(windowOpenerDelegate.windowOpenedSpy)
    }
    
    
    func testNewDishWasCreated() {
        // Dado
        var sujetoDePrueba = MainModel()
        
        let collectionUpdaterDelegate = FakeCollectionUpdater()
        sujetoDePrueba.collectionUpdater = collectionUpdaterDelegate
        //XCTAssertFalse(collectionUpdater.collectionUpdatedSpy)
        
        XCTAssertFalse(collectionUpdaterDelegate.collectionUpdatedSpy)
        
        
        let fakeDish = Dish(
            name: "Fake Title",
            imageURL: nil,
            deliveryPerson: .init(
                name: "Fake Delivery",
                id: 1233
            
            ),
            
            price: 30700,
            category: .appetizer
        )
        
        // Cuando
        sujetoDePrueba.newDishWasCreated(dish: fakeDish)
        
        // Entonces
        
        XCTAssertTrue(
            sujetoDePrueba.dishes
                .contains(where: { $0.name == fakeDish.name })
        )
        
        
    }
    
//    class FakeWindowOpener2: NewDishWindowOpener {
//        var windowOpenedSpy = false
//        
//        func openNewDishWindow() {
//            windowOpenedSpy = true
//        }
//    }
//
//    class FakeCollectionUpdater: CollectionUpdater {
//        
//        var collectionUpdatedSpy = false
//        
//        func reloadCollection() {
//            collectionUpdatedSpy = true
//        }
//        
//    }

    
    
    

}

