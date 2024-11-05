//
//  DashBoardViewController.swift
//  GenericsSample
//
//  Created by COLLABERA on 9/12/23.
//

import UIKit
import RxSwift
import RxDataSources






class DashBoardViewController: UIViewController {
    
    var viewModel: DashBoardViewModel!
    @IBOutlet private weak var tableView: UITableView!
    private let disposeBag = DisposeBag()
  // profilelimit
    // Create a data source for RxDataSources
    private var dataSource: RxTableViewSectionedReloadDataSource<DashboardSectionModel>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCell()
        setupData()
        setupView()
        setupDataSource()
      //tableview.heightfor
    }
    
  
    private func setupData() {
        viewModel.fetchData()
        
    }
    
    private func setupView() {
    }
    
    private func registerCell() {
    }
    
    private  func setupDataSource() {
        dataSource = RxTableViewSectionedReloadDataSource<DashboardSectionModel>(
            configureCell: { _, tableView, indexPath, item in
                
                let cell = tableView.dequeueReusableCell(withIdentifier: item.identifier, for: indexPath)
                if let cell = cell as? DashboardBindableType {
                    cell.bindItemModel(to: item)
                }
                cell.selectionStyle = .none
                return cell
            }
        )
        
      
        tableView
            .rx
            .setDelegate(self)
            .disposed(by: disposeBag)
        
        tableView
            .rx
            .modelSelected(DashboardSectionItemModel.self)
            .bind(to: viewModel.input.didSelectItem)
            .disposed(by: disposeBag)
        
//      tableView.rx.rowHeight
//        .onNext(UITableView.automaticDimension) // Set to automatic dimension
//      tableView.rx.estimatedRowHeight
//        .onNext(44.0) 
      
      // bindviewmodel
        viewModel?
            .output
            .sectionModels
            .asObservable()
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
      
//      viewModel?.output.rowHeight.asDriver().drive( onNext: { [weak self] height in
//        
//        guard let self = self else { return }
//        self.tableView.rowHeight = height
//      }).disposed(by: disposeBag)
        
    }
}

extension DashBoardViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return viewModel?.heightForRow(row: indexPath.row) ?? UITableView.automaticDimension
      //tableView.delegate?.tableView(table, heightForRowAt: <#T##IndexPath#>)

    }
}

extension DashBoardViewController : UIScrollViewDelegate {
    
}
