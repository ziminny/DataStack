//
//  Persistence.swift
//  PasseiOAB
//
//  Created by Vagner Oliveira on 02/06/23.
//

import CoreData

#if DEBUG
@preconcurrency import SwiftFake
#endif

/// Controlador de persistência para interação com o Core Data.
open class CDPersistenceController: @unchecked Sendable {
    
    /// A configuração do Core Data associada ao controlador.
    public let configuration: CDConfigurationProtocol
    
    /// O contêiner persistente do Core Data.
    public let container: NSPersistentContainer
#if DEBUG
    /// Conjunto de registros falsos usado para visualização de prévia.
    public let fakeRecords = FakeRecords()
#endif
    /// Cria uma instância do controlador para visualização de prévia.
    ///
    /// - Parameter configuration: A configuração do Core Data a ser utilizada.
    /// - Returns: Uma instância do controlador configurada para visualização de prévia.
    public static func preview(withConfiguration configuration: CDConfigurationProtocol)
    -> CDPersistenceController
    {
        let result = CDPersistenceController(withConfiguration: configuration, inMemory: true)
        let viewContext = result.container.viewContext
        
#if DEBUG
        do {
            try result.configuration.generateFakeModelInMemory(
                fake: result.fakeRecords, context: viewContext)
            try viewContext.save()
            print("Classse do core data")
            
        } catch {
            let error = error as NSError
            print("Core data preview error: \(error)")
        }
#endif
        
        return result
    }
    
    /// Inicializa o controlador de persistência do Core Data.
    ///
    /// - Parameters:
    ///   - configuration: A configuração do Core Data a ser utilizada.
    ///   - inMemory: Indica se deve ser utilizado armazenamento em memória.
    public init(
        withConfiguration configuration: CDConfigurationProtocol,
        inMemory: Bool = false
    ) {
        self.configuration = configuration
        
        self.container = NSPersistentContainer(name: configuration.dbName)
        
        if inMemory {
            //   self.container.persistentStoreDescriptions.first!.url = URL(
            //     fileURLWithPath: "/dev/null")
            let description = NSPersistentStoreDescription()
            description.type = NSInMemoryStoreType
            self.container.persistentStoreDescriptions = [description]
        }
        
        self.container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            
            if let error = error as NSError? {
                print("Core data error: \(error)")
                return
            }
            print("Core data loaded")
        })
    }
}
