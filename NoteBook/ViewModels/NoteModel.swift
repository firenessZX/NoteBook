//
//  NoteModel.swift
//  NoteBook
//
//  Created by 云联 on 2026/5/20.
//

import UIKit

class NoteModel: NSObject {
    //时间
    var time: String?
    //标题
    var title: String?
    //内容
    var body: String?
    //所在分组
    var group: String?
    //主键
    var noteId: Int?
    //这个方法用于将数据模型属性直接转换成字典
    func toDictionary() -> Dictionary<String,Any> {
        var dic:[String: Any] = ["time":time!,"title": title!,"body":body!,"ownGroup":group!]
        if let id = noteId {
            dic["noteId"] = id
        }
        return dic
    }
    

}
