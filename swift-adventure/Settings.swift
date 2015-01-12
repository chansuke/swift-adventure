//
//  Settings.swift
//  swift-adventure
//
//  Created by 安部裕介 on 1/11/15.
//  Copyright (c) 2015 MyAwesomeCompany. All rights reserved.
//

import Foundation

private let _settingInstance = Settings()

class Settings {
    var virtualPad = true

    class var sharedInstance: Settings {
        return _settingInstance
    }
}