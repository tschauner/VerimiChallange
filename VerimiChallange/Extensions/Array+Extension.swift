//
//  Array+Extension.swift
//  VerimiChallange
//
//  Created by Philipp Tschauner on 06.05.24.
//

import Foundation

extension Array {
    public subscript(safeIndex index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }

        return self[index]
    }
}
