import UIKit

protocol CustomTableViewDataSourceDelegate: AnyObject {
    func reloadTableViewData()
}

protocol CustomTableViewDataSourceProtocol: UITableViewDataSource {
    var delegate: CustomTableViewDataSourceDelegate? { get set }
    func update(_ model: [String])
    func hideLoading()
}

final class CustomTableViewDataSource: NSObject {
    
    //MARK: - Propriedade
    weak var delegate: CustomTableViewDataSourceDelegate?
    
    private var footerCell: CustomFooterTableViewCell?
    private var viewData: [String] = [] { didSet { delegate?.reloadTableViewData() } }
    
    //MARK: - Methods
    
    func update(_ model: [String]) {
        viewData = model
    }
    
    func hideLoading() {
        footerCell?.hideLoading()
    }
}

//MARK: - UITableViewDataSource
extension CustomTableViewDataSource: CustomTableViewDataSourceProtocol {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        onNumberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        onCellForRow(tableView, at: indexPath)
    }
}

//MARK: - Helpers
private extension CustomTableViewDataSource {
    func onCellForRow(_ tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        
        guard tableView.isLastCell(at: indexPath) else {
            let cell = UITableViewCell()
            cell.textLabel?.text = viewData[indexPath.row]
            return cell
        }
        
        let cell = tableView.instanciate(CustomFooterTableViewCell.self, at: indexPath)
        cell.showLoading()
        footerCell = cell
        return cell
    }
    
    func onNumberOfRows(in section: Int) -> Int {
        return viewData.count
    }
}
