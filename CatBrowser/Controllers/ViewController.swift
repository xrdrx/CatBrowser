//
//  ViewController.swift
//  CatBrowser
//
//  Created by Aleksandr Svetilov on 10.02.2021.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var catTableView: UITableView!
    
    var container: NSPersistentContainer!
    
    private var storage: CatStorage?
    private let viewModel: CatViewModel
    private let dataSource: CatTableDataSource
    private let tableDelegate: CatTableDelegate
    
    required init?(coder: NSCoder) {
        self.viewModel = CatViewModel()
        self.dataSource = CatTableDataSource(viewModel: viewModel)
        self.tableDelegate = CatTableDelegate(viewModel: viewModel)
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupStorage()
        setupViewModel()
        setupTableView()
    }
    
    private func setupStorage() {
        self.storage = CatStorage(container: container)
    }
    
    private func setupTableView() {
        catTableView.dataSource = dataSource
        catTableView.delegate = tableDelegate
    }
    
    private func setupViewModel() {
        viewModel.setDelegate(self)
        guard let storage = storage else { return }
        viewModel.setStorage(storage)
        checkConnection()
    }
    
    private func checkConnection() {
        if !InternetConnectionManager.isConnectedToNetwork() {
            proposeOfflineMode()
        } else {
            viewModel.getMoreCats()
        }
    }
    
    private func proposeOfflineMode() {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: "No network connection",
                message: "Seems like there is no internet connection. Would you like to continue in Offline Mode?",
                preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: self.retryConnection(_:)))
            alert.addAction(UIAlertAction(title: "Offline Mode", style: .cancel, handler: self.offlineMode(_:)))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func retryConnection(_ action: UIAlertAction) {
        checkConnection()
    }
    
    private func offlineMode(_ action: UIAlertAction) {
        guard let storage = storage else { return }
        let provider = OfflineCatsProvider(storage: storage)
        viewModel.setCatsProvider(provider)
        viewModel.getMoreCats()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "details",
              let destination = segue.destination as? DetailsViewController,
              let row = catTableView.indexPathForSelectedRow?.row
        else {
            return
        }
        let url = viewModel.getData(forRow: row).url
        destination.url = url
        destination.storage = storage
    }
    
}

//MARK: - CatViewModelDelegate

extension ViewController: CatViewModelDelegate {
    
    func didReceiveUpdates() {
        DispatchQueue.main.async {
            self.catTableView.reloadData()
        }
    }
    
}
