//
//  App.swift
//  Recepie
//
//  Created by Muhammed salih T A on 01/02/22.
//

import Foundation
/// High level features related to app. Like target name or environment.
enum App {
    static var processEnvironment: [String: String] {
        return ProcessInfo.processInfo.environment
    }
}
extension App {
    enum Testing {
        static let isUITesting = {
            App.processEnvironment["IS_UI_TESTING"] == "1"
        }()
        static let shouldUseLocalTestData = {
            App.processEnvironment["USE_LOCAL_TEST_DATA"] == "1"
        }()
        static func responsePath(item:String) ->String? {
            return App.processEnvironment["Response."+item]
        }
    }
}
