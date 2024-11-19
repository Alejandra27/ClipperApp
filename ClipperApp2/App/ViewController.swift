
//
//  ViewController.swift
//  EvaStore
//
//  Created by Sergio Daniel on 11/18/24.
//

//import Cocoa
//
//class ViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
//    @IBOutlet weak var booksTableView: NSTableView!
//    let books: [Book] = [
//        .init(title: "The Alchemist",
//              coverPicture: nil,
//              author: .init(name: "Paulo Coelho",
//                            nationality: "Brazilian",
//                            birthDate: nil,
//                            genres: [.fiction, .fantasy]),
//              publicationDate: Date(),
//              genre: .fiction),
//        
//        Book(title: "The Great Gatsby",
//             coverPicture: nil,
//             author: .init(name: "F. Scott Fitzgerald",
//                           nationality: "American",
//                           birthDate: nil,
//                           genres: [.fiction, .fantasy]),
//             publicationDate: Date(),
//             genre: .fiction),
//        
//        .init(title: "The Da Vinci Code",
//              coverPicture: nil,
//              author: .init(name: "Dan Brown",
//                            nationality: "American",
//                            birthDate: nil,
//                            genres: [.fiction, .thriller]),
//              publicationDate: Date(),
//              genre: .fiction),
//    ]
//    
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//        booksTableView.dataSource = self
//        booksTableView.delegate = self
//    }
//
//    override var representedObject: Any? {
//        didSet {
//        // Update the view, if already loaded.
//        }
//    }
//
//    // Implementacion de DataSource
//    
//    func numberOfRows(in tableView: NSTableView) -> Int {
//        return books.count
//    }
//    
//    enum BookColumn {
//        static let title: NSUserInterfaceItemIdentifier = .init("title")
//        static let author = NSUserInterfaceItemIdentifier("author")
////        case publicationDate
////        case genre
//    }
//    
//    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
//        let book = books[row]
//        
//        if tableColumn == tableView.tableColumns[0] {
//            let titleCell = tableView.makeView(
//                withIdentifier: BookColumn.title,
//                owner: nil
//            ) as! NSTableCellView
//            titleCell.textField?.stringValue = book.title
//            return titleCell
//        } else if tableColumn == tableView.tableColumns[1] {
//            let authorCell = tableView.makeView(
//                withIdentifier: BookColumn.author,
//                owner: nil
//            ) as! NSTableCellView
//            authorCell.textField?.stringValue = book.author.name
//            return authorCell
//        } else {
//            return nil
//        }
//    }
//
//}




import Cocoa

class ViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    
    // productos de ejemplo
    let productos: [Producto] = [
        Producto(id: "1", nombre: "Pizza", precio: 20000, categoria: "Comida"),
        Producto(id: "2", nombre: "Pepsi", precio: 3000, categoria: "Bebidas"),
        Producto(id: "3", nombre: "Malteada", precio: 7500, categoria: "Bebida")
    ]
    
    //  usuarios de ejemplo
    var cliente = Usuario(id: "c1", nombre: "Juan Pérez", correo: "juan@io.com", telefono: "3117789021", tipo: .cliente)
    var repartidor = Usuario(id: "r1", nombre: "Carlos Gomez", correo: "carlos@io.com", telefono: "315679009", tipo: .repartidor)

    

    
    
    @IBOutlet weak var pedidosTableView: NSTableView!
    
    var pedidos: [Pedido] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // pedidos de ejemplo
        pedidos = [
            Pedido(id: "pedido 1", cliente: cliente, productos: [productos[0], productos[1]], precioTotal: 45700, estado: .pendiente, repartidor: nil, direccionDeEntrega: "Calle falsa 123", fechaEntrega: nil),
            Pedido(id: "pedido 2", cliente: cliente, productos: [productos[2]], precioTotal: 120000, estado: .enProceso, repartidor: repartidor, direccionDeEntrega: "Calle falsa 123", fechaEntrega: Date())
        ]
        
    
        pedidosTableView.dataSource = self
        pedidosTableView.delegate = self
    }

    func numberOfRows(in tableView: NSTableView) -> Int {
        return pedidos.count
    }
    
    // Identificadores de las columnas de la tabla
    enum PedidoColumn {
        static let id: NSUserInterfaceItemIdentifier = .init("id")
        static let cliente = NSUserInterfaceItemIdentifier("cliente")
        static let estado = NSUserInterfaceItemIdentifier("estado")
        static let precioTotal = NSUserInterfaceItemIdentifier("precioTotal")
    }
    

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let pedido = pedidos[row]
        
        if tableColumn == tableView.tableColumns[0] {
            let idCell = tableView.makeView(
                withIdentifier: PedidoColumn.id, owner: nil
            ) as! NSTableCellView
            idCell.textField?.stringValue = pedido.id
            return idCell
        } else if tableColumn == tableView.tableColumns[1] {
            let clienteCell = tableView.makeView(
                withIdentifier: PedidoColumn.cliente, owner: nil
            ) as! NSTableCellView
            clienteCell.textField?.stringValue = pedido.cliente.nombre
            return clienteCell
        } else if tableColumn == tableView.tableColumns[2] {
            let estadoCell = tableView.makeView(
                withIdentifier: PedidoColumn.estado, owner: nil
            ) as! NSTableCellView
            estadoCell.textField?.stringValue = pedido.estado.rawValue
            return estadoCell
        } else if tableColumn == tableView.tableColumns[3] {
            let precioCell = tableView.makeView(
                withIdentifier: PedidoColumn.precioTotal, owner: nil
            ) as! NSTableCellView
            precioCell.textField?.stringValue = "$\(pedido.precioTotal)"
            return precioCell
        } else {
            return nil
        }
    }
}
