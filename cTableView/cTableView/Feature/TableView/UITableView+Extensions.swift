import UIKit

extension UITableView {
    func isLastCell(at indexPath: IndexPath) -> Bool {
        let lastSectionIndex = numberOfSections - 1
        let lastRowIndex = numberOfRows(inSection: lastSectionIndex) - 1
        let isLastSection = indexPath.section ==  lastSectionIndex
        let isLastRow = indexPath.row == lastRowIndex
        return (isLastSection && isLastRow)
    }
    
    func instanciate<C: ReusableCell>(_ cell: C.Type, at indexPath: IndexPath) -> C {
        let cell = dequeueReusableCell(withIdentifier: cell.identifier, for: indexPath)
        guard let cellCasted = cell as? C else { return C.init() }
        return cellCasted
    }
    
    func instanciate<HF: ReusableHeaderFooter>(_ headerFooter: HF.Type) -> HF {
        let hFooter = dequeueReusableHeaderFooterView(withIdentifier: headerFooter.identifier)
        guard let cellCasted = hFooter as? HF else { return HF.init() }
        return cellCasted
    }
    
    func register<C: ReusableCell>(_ cell: C.Type) {
        register(cell, forCellReuseIdentifier: cell.identifier)
    }
    
    func register<HF: ReusableHeaderFooter>(_ headerFooter: HF.Type) {
        register(headerFooter, forHeaderFooterViewReuseIdentifier: headerFooter.identifier)
    }
}
