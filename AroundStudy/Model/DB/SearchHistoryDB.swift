//
//  SearchHistoryDB.swift
//  AroundStudy
//
//  Created by Junyoung on 2022/10/11.
//

import RealmSwift

class SearchHistoryDB: Object {
    @Persisted var title: String = ""
    @Persisted var date: Date = Date()
    
}
