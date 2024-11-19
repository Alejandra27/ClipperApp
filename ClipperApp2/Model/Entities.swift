//
//  Entities.swift
//  EvaStore
//
//  Created by Sergio Daniel on 11/18/24.
////
//
//import Foundation
//
///// Representa una de las opciones de genero literario disponible
///// para libros en la base de datos.
//enum Genre: String {
//    case fiction
//    case romance
//    case selfHelp
//    case history
//    case fantasy
//    case thriller
//}
//
///// Representa los datos mas basicos del autor de uno o mas libros.
//struct Author {
//    let name: String
//    let nationality: String?
//    let birthDate: Date?
//    let genres: [Genre]
//}
//
///// Representa un libro de la base de datos con su informacion
///// mas esencial.
//struct Book {
//    let title: String
//    let coverPicture: URL?
//    let author: Author
//    let publicationDate: Date
//    let genre: Genre
//}
//


import Foundation

// Enumeracion para los estados del pedido
enum EstadoDelPedido: String {
    case pendiente = "Pendiente"
    case enProceso = "En proceso"
    case entregado = "Entregado"
    case cancelado = "Cancelado"
}

// Estructura para el Producto
struct Producto {
    let id: String
    let nombre: String
    let precio: Double
    let categoria: String
}

// Estructura para el Usuario (cliente o repartidor)
struct Usuario {
    let id: String
    let nombre: String
    let correo: String
    let telefono: String
    let tipo: TipoDeUsuario
}

// Enumeracion para el tipo de usuario
enum TipoDeUsuario {
    case cliente
    case repartidor
}

// Estructura para el Pedido
struct Pedido {
    let id: String
    let cliente: Usuario
    let productos: [Producto]
    let precioTotal: Double
    var estado: EstadoDelPedido
    var repartidor: Usuario?
    var direccionDeEntrega: String
    var fechaEntrega: Date?
}
