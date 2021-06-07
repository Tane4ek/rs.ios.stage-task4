import Foundation

final class FillWithColor {
    enum Direction {
        case right
        case left
        case top
        case bottom
    }
    func fillWithColor(_ image: [[Int]], _ row: Int, _ column: Int, _ newColor: Int) -> [[Int]] {
       let rows = image.count
        if rows == 0 {
        return image
        }
        
        let columns = image[0].count
        var dots = [(row: Int, column: Int, stage: Direction)]()
        let oldColor: Int = image[row][column]
        var result = image
        result[row][column] = newColor
        dots.append((row, column, .left))
        
        repeat {
            let dot = dots.last!
            var row = dot.row
            var column = dot.column
            if (dot.stage == .left) {
                row -= 1
                dots[dots.count - 1].stage = .right
            }
            else if (dot.stage == .right) {
                row += 1
                dots[dots.count - 1].stage = .bottom
            }
            else if (dot.stage == .bottom) {
                column -= 1
                dots[dots.count - 1].stage = .top
            }
            else if (dot.stage == .top) {
                column += 1
                dots.removeLast()
            }

            if (row >= 0) && (row < rows) && (column >= 0) && (column < columns) && (result[row][column] == oldColor)
            {
                result[row][column] = newColor
                dots.append((row, column, .left))
            }
        } while dots.count > 0
        
        return result
    }
}
