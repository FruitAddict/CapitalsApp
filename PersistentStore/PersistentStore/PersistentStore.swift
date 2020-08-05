//
//  PersistentStore.swift
//  PersistentStore
//
//  Created by Mateusz Popiało on 05/08/2020.
//  Copyright © 2020 Mateusz Popiało. All rights reserved.
//

import Foundation
import SQLite3

public protocol PersistentStore {
    func fetchAllPersistedCityData() -> [PersistedCityData]
    
    func updateCityData(name: String, isFavorite: Bool)
}

public class DefaultPersistentStore: PersistentStore {
    
    //MARK: - DB Connection
    lazy var database: OpaquePointer? = {
        return openDatabase()
    }()

    deinit {
      sqlite3_close(database)
    }
    
    //MARK: - Properties
    fileprivate var dbPath: String
    
    //MARK: - Initialization
    public init(path: String) {
        self.dbPath = path
        createTableIfNeeded()
    }
    
}

//MARK: - Opening database
extension DefaultPersistentStore {
    
    fileprivate func openDatabase() -> OpaquePointer? {
        var databasePointer: OpaquePointer?
    
        let result = sqlite3_open(dbPath, &databasePointer)
        
        guard
            result == SQLITE_OK
        else {
            return nil
        }
        
        return databasePointer
    }
}

//MARK: - Manipulating & Fetching database data
extension DefaultPersistentStore {
    
    fileprivate func createTableIfNeeded() {
        guard
            let database = self.database
        else {
            return
        }
        
        guard
            let createTableStatement = prepareStatement(createTableSQLString)
        else {
            return
        }
        
        defer {
            sqlite3_finalize(createTableStatement)
        }

        let creationResult = sqlite3_step(createTableStatement)
        guard
            creationResult == SQLITE_DONE
        else {
            return
        }
    }
    
    public func fetchAllPersistedCityData() -> [PersistedCityData] {
        guard
            let selectStatement = prepareStatement(selectAllCityDataSQLString)
        else {
            return []
        }
                   
        defer {
            sqlite3_finalize(selectStatement)
        }
                   
        var cityData: [PersistedCityData] = []
                   
        while sqlite3_step(selectStatement) == SQLITE_ROW {
            
            let name = String(cString: sqlite3_column_text(selectStatement, 0))
            let isFavorite = sqlite3_column_int(selectStatement, 1)
            
            let isFavoriteBool = Bool(isFavorite == 0 ? false : true)
            
            cityData.append(.init(name: name, isFavorite: isFavoriteBool))
            
        }
                   
        return cityData
    }
     
    public func updateCityData(name: String, isFavorite: Bool) {
        guard
            let insertStatement = prepareStatement(insertOrUpdateDataSQLString)
        else {
            return
        }
    
        defer {
            sqlite3_finalize(insertStatement)
        }
        
        guard
            sqlite3_bind_text(insertStatement, 1, name, -1, nil)
            == SQLITE_OK,
            sqlite3_bind_int(insertStatement, 2, isFavorite ? 1 : 0) == SQLITE_OK
        else {
            return
        }
        
        guard
            sqlite3_step(insertStatement) == SQLITE_DONE
        else {
            return
        }
    }
}

//MARK: - Helpers
extension DefaultPersistentStore {

    func prepareStatement(_ sqlStatement: String) -> OpaquePointer? {
        var preparedStatementPointer: OpaquePointer?
        
        let preparationResult = sqlite3_prepare_v2(database, sqlStatement, -1, &preparedStatementPointer, nil)
        guard
            preparationResult == SQLITE_OK
        else {
            return nil
        }
        
        return preparedStatementPointer
    }
    
}


//MARK: - SQL strings
extension DefaultPersistentStore {
    
    fileprivate var createTableSQLString: String {
        let sql = """
        CREATE TABLE IF NOT EXISTS CityData (
            id VARCHAR(255) PRIMARY KEY NOT NULL,
            isFavorite BOOLEAN
        );
        """
        return sql
    }
    
    fileprivate var selectAllCityDataSQLString: String {
        let sql = """
        SELECT * FROM CityData
        """
        return sql
    }
    
    fileprivate var insertOrUpdateDataSQLString: String {
        let sql = """
        REPLACE INTO CityData (id, isFavorite)
        VALUES((?),(?));
        """
        return sql
    }
}

