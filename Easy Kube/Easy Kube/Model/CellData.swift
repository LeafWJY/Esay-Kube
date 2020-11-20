//
//  CellData.swift
//  Easy Kube
//
//  Created by 王镓耀 on 2020/10/21.
//  Copyright © 2020 codewjy. All rights reserved.
//

struct RowData: Identifiable {
    var id: String
    var objectType: ObjectType
    var objectName:String
    var objectNamespace:String?
    var objectAge:String?
    var objectStatus:String
}
