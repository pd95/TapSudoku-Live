//
//  Board.swift
//  TapSudoku
//
//  Created by Philipp on 10.12.22.
//

import Foundation

struct Board: Equatable {
    enum Difficulty: Int, CaseIterable {
        #if DEBUG
        case testing = 2
        #endif
        case trivial = 10
        case easy = 20
        case medium = 24
        case hard = 27
        case extreme = 29
    }

    let size = 9
    let difficulty: Difficulty
    var fullBoard = [[Int]]()
    var playerBoard = [[Int]]()

    init(difficulty: Difficulty) {
        self.difficulty = difficulty
        create()
        prepareForPlay()
    }

    mutating private func create() {
        let numbers = Array(1...size).shuffled()
        let positions = [0, 3, 6, 1, 4, 7, 2, 5, 8]

        let rows = Array([[0, 1, 2].shuffled(), [3, 4, 5].shuffled(), [6, 7, 8].shuffled()].shuffled()).joined()
        let columns = Array([[0, 1, 2].shuffled(), [3, 4, 5].shuffled(), [6, 7, 8].shuffled()].shuffled()).joined()

        for row in rows {
            var newRow = [Int]()

            for column in columns {
                let position = (positions[row] + column) % size
                newRow.append(numbers[position])
            }

            print(newRow)
            fullBoard.append(newRow)
        }

        playerBoard = fullBoard
    }

    mutating private func prepareForPlay() {
        let empties = difficulty.rawValue
        let allCells = 0..<Int(ceil(Double(size * size) / 2))

        for cell in allCells.shuffled().prefix(upTo: empties) {
            let row = cell / size
            let column = cell % size

            playerBoard[row][column] = 0
            playerBoard[8 - row][8 - column] = 0
        }
    }
}
