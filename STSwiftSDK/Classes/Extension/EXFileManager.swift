//
//  EXFileManager.swift
//  KTSZ
//
//  Created by cfans on 2018/10/22.
//  Copyright © 2018年 cfans. All rights reserved.
//

import Foundation
extension FileManager {

    func copyfileToUserDocumentDirectory(forResource name: String,
                                         ofType ext: String) throws
    {
        let fileName = "\(name).\(ext)"
        if let bundlePath = Bundle.main.path(forResource: name, ofType: ext),
            let destPath = getFileFullPath(fileName: fileName) {
            if !self.fileExists(atPath: destPath) {
                print("copy")
                try self.copyItem(atPath: bundlePath, toPath: destPath)
            }else{
                print("copy OK ")
            }
        }
    }

    func getFileFullPath(fileName:String)->String?{
        if let destPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                           .userDomainMask,
                                                           true).first{
            return URL(fileURLWithPath: destPath)
                .appendingPathComponent(fileName).path
        }
        return nil
    }

}

extension FileManager {
    func removeIfExisted(_ url:URL) -> Void {
        if FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.removeItem(atPath: url.path)
            }
            catch {
                print("Failed to delete file")
            }
        }
    }
    
    func tempFileUrl(_ outputName:String) ->URL{
        let path = NSTemporaryDirectory().appending(outputName)
        let exportURL = URL.init(fileURLWithPath: path)
        removeIfExisted(exportURL)
        return exportURL
    }
}
