//
//  PostUploadTmp.swift
//  TakeOff
//
//  Created by Jun on 2022/01/19.
//

import Foundation
import RxDataSources
import RxCocoa
import RxSwift

struct PostUploadSection {
    var header: String
    var items:[Item]
}

extension PostUploadSection: SectionModelType {
    typealias Item = UIImage
    
    init(original: PostUploadSection, items: [UIImage]) {
        self = original
        self.items = items
    }
    
    var identity: String {
        return header
    }
    
}

struct Post: Codable {
    
    var user:String = ""
    var image:String = ""
    var contents:String = ""
    var date:TimeInterval = Date().timeIntervalSince1970
    var hashTag:[String] = []
    var heart:[String] = []
    
    init() {
    }
    
    
}