//
//  CloudModel.swift
//  
//
//  Created by Douglas Taquary on 16/08/20.
//

import Foundation
import CloudKit

public protocol CloudModel {
    static var RecordType: String { get }
    var record: CKRecord? { get }
    init(withRecord record: CKRecord)
    func toRecord(owner: CKRecord?) -> CKRecord
}
