//
//  SearchChattingDB.swift
//  AroundStudy
//
//  Created by Junyoung on 2022/10/27.
//

import RealmSwift

class SearchChattingDB: Object {
    @Persisted var title: String = ""
    @Persisted var date: Date = Date()
}
