import UIKit

protocol CustomTableViewDelegateToTableView: AnyObject {
    func lastCellWasDetected()
}

protocol CustomTableViewDelegateProtocol: UITableViewDelegate {
    var delegate: CustomTableViewDelegateToTableView? { get set }
}

final class CustomTableViewDelegate: NSObject {
    
    //MARK: - Properties
    weak var delegate: CustomTableViewDelegateToTableView?
    
}

//MARK: - UITableViewDelegate
extension CustomTableViewDelegate: CustomTableViewDelegateProtocol {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard tableView.isLastCell(at: indexPath) else { return }
        
        delegate?.lastCellWasDetected()
    }
}
