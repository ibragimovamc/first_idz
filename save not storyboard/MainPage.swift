import UIKit

class MainPage: UIViewController {
    
    // started: "14:49", finished: "16:31"
    
    var checker_for_button = false
    
    let database: [ActivitiesTableSection] = {
        let yesterdayData: [ActivityModel] = [
            ActivityModel(
                distance: "14.32 км", duration: "1 час 42 минуты", descriptionName: "Велосипед", deltaTime: "14 часов назад",started: "14:49", finished: "16:31"
            ),
        ]
        let mayData: [ActivityModel] = [
            ActivityModel(
                distance: "14.32 км", duration: "1 час 42 минуты", descriptionName: "Велосипед", deltaTime: "14 часов назад",started: "14:49", finished: "16:31"
            ),
        ]
        return [
            ActivitiesTableSection(date: "Вчера", activities: yesterdayData),
            ActivitiesTableSection(date: "Май  2022 года", activities: mayData),
        ]
    }()
    
    
    let idCell = "MainCell"
    @IBOutlet weak var TableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Активности"
        navigationController?.navigationBar.prefersLargeTitles = false
        TableView.isHidden = true
        TableView.dataSource = self
        TableView.delegate = self
        
        TableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
    }
    
    
    @IBAction func isPresssed_button(_ sender: Any) {
        
        TableView.isHidden = false
        if (checker_for_button ){
            let mapView = MapViewController(nibName: "MapViewController", bundle: nil)
            navigationController?.pushViewController(mapView, animated: true)
            let check = ActivityViewViewController(nibName: "ActivityViewViewController", bundle: nil)
//            navigationController?.pushViewController(check, animated: true)
        }
        checker_for_button = true
    }
    
}

extension MainPage: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return database[section].activities.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return database.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = self.database[indexPath.section].activities[indexPath.row]
        let cell = TableView.dequeueReusableCell(withIdentifier: "TableViewCell",for: indexPath)
        guard let topCell = cell as? TableViewCell else {return UITableViewCell()}
        topCell.setCellStats(data)
        return topCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let details = TableViewActivitesPage(nibName: "TableViewActivitesPage", bundle: nil)
        details.activity = self.database[indexPath.section].activities[indexPath.row]
        navigationController?.pushViewController(details, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeader = UILabel()
        sectionHeader.text = database[section].date
        sectionHeader.font = .boldSystemFont(ofSize: 20)
        return sectionHeader
    }
}

