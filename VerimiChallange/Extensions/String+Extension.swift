//
//  String+Extension.swift
//  VerimiChallange
//
//  Created by Philipp Tschauner on 06.05.24.
//

import Foundation

extension String {
    var toURL: URL? {
        URL(string: self)
    }
}
