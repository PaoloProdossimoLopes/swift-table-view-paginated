import UIKit

protocol CustomTableViewDelegateToView: AnyObject {
//    func fetchNextAPIPage(updateNextPage: (() -> Void), completed: (() -> Void))
    func fetchNextAPIPage()
}

final class CustomTableView: UITableView {
    
    //MARK: - Propeties
    
    weak var customDelegate: CustomTableViewDelegateToView?
    
    private weak var cDelegate: CustomTableViewDelegateProtocol?
    private weak var cDataSource: CustomTableViewDataSourceProtocol?
    
    //MARK: - Constructor
    
    init(
        delegate cDelegate: CustomTableViewDelegateProtocol,
        dataSource cDataSource: CustomTableViewDataSourceProtocol
    ) {
        self.cDelegate = cDelegate
        self.cDataSource = cDataSource
        
        super.init(frame: .zero, style: .plain)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    func updateDataSource(_ model: [String]) {
        cDataSource?.update(model)
    }
    
    //MARK: - Helpers
    
    private func commonInit() {
        setupTableViewStyle()
        setupResponsability()
        registerTableViewCells()
        registerTableViewHeaders()
    }
    
    private func setupResponsability() {
        cDelegate?.delegate = self
        cDataSource?.delegate = self
        
        delegate = cDelegate
        dataSource = cDataSource
    }
    
    private func setupTableViewStyle() {
        separatorStyle = .none
        separatorColor = .clear
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func registerTableViewCells() {
        register(CustomFooterTableViewCell.self)
    }
    
    private func registerTableViewHeaders() {
        //Register here your Headers
    }
    
    private func registerTableViewFooters() {
        //Register here your footers
    }
    
    private func updateTableView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            guard let self = self else { return }
            self.reloadData()
        }
    }
    
    func completed() {
        cDataSource?.hideLoading()
    }
}

//MARK: - CustomTableViewDelegateToTableView
extension CustomTableView: CustomTableViewDelegateToTableView {
    func lastCellWasDetected() {
        //TODO: -> Fetch API
        customDelegate?.fetchNextAPIPage()
    }
}

//MARK: - CustomTableViewDataSourceDelegate
extension CustomTableView: CustomTableViewDataSourceDelegate {
    func reloadTableViewData() {
        updateTableView()
    }
}
