//
//  App.swift
//  App
//
//  Created by Takayuki Sei on 2019/12/09.
//  Copyright © 2019 takayuki sei. All rights reserved.
//

import Foundation

public class App {
    public enum AppError: Error {
        case unkown
    }
    
    public struct Log {
        public init() {}
        
        public func hello() {
            print("hello")
        }
    }
}
