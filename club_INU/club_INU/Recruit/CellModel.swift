//
//  CellModel.swift
//  club_INU
//
//  Created by 조경진 on 08/08/2019.
//  Copyright © 2019 dong.gyun. All rights reserved.
//

import Foundation

class CellModel {
    
    static let CellTemp = CellModel()
    private init() {}
    private var cellData: Smallregister = Smallregister(category : "", content : "" , name : "", link : "", insertDate: "", count: 0)
    
    func getCellData() -> Smallregister {
        return cellData
    }

    func setData(data: Smallregister){
        cellData = data
    }
}
