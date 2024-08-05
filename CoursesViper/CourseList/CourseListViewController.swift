//
//  CourseListViewController.swift
//  CoursesViper
//
//  Created by Дарья Кобелева on 03.08.2024.
//

import UIKit

protocol CourseListViewInputProtocol: AnyObject {
    func reloadData(for section: CourseSectionViewModel)
}

protocol CourseListViewOutputProtocol {
    init(view: CourseListViewInputProtocol)
    func viewDidLoad()
    func didTapCell(at indexPath: IndexPath)
}

class CourseListViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    var presenter: CourseListViewOutputProtocol!
    
    private let configurator: CourseListConfiguratorInputProtocol = CourseListConfigurator()
    private var activityIndicator: UIActivityIndicatorView?
    private var sectionViewModel: CourseSectionViewModelProtocol = CourseSectionViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(withView: self)
        tableView.rowHeight = 100
        activityIndicator = showActivityIndicator(in: view)
        setupNavigationBar()
        presenter.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailsVC = segue.destination as? CourseDetailsViewController else {
            return
        }
        let configurator: CourseDetailsConfiguratorInputProtocol = CourseDetailsConfigurator()
        configurator.configure(with: detailsVC, and: sender as! Course)
    }
    
    private func setupNavigationBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
    
    private func showActivityIndicator(in view: UIView) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .black
        activityIndicator.startAnimating()
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        
        view.addSubview(activityIndicator)
        
        return activityIndicator
    }
}

// MARK: - UITableViewDataSource
extension CourseListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sectionViewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellViewModel = sectionViewModel.rows[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellViewModel.cellIdentifier, for: indexPath)
        guard let cell = cell as? CourseCell else { return UITableViewCell() }
        cell.viewModel = cellViewModel
        return cell
    }
}

// MARK: - UITableViewDelegate
extension CourseListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.didTapCell(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        sectionViewModel.rows[indexPath.row].cellHeight
    }
}

//MARK: - CourseListViewInputProtocol
extension CourseListViewController: CourseListViewInputProtocol {
    func reloadData(for section: CourseSectionViewModel) {
        sectionViewModel = section
        tableView.reloadData()
        activityIndicator?.stopAnimating()
    }
}
