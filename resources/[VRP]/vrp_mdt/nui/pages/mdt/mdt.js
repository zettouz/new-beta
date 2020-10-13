const mdtApp = new Vue({
    el:"#actionmenu",
    data: {
        page: "desktop",
        homepage: {
            reports: [],
            warrants: [],
            persons: [],
            vehicles: []
        },
        people: {
            search: '',
            peoples: [],
            selected: {}
        },
        vehicles: {
            search: '',
            vehicles: [],
            selected: {}
        }
    }
})


document.onreadystatechange = () => {
    if (document.readyState === "complete") {
        window.addEventListener('message', function(event) {
            if (event.data.type == "enable") {
                document.body.style.display = event.data.isVisible ? "block" : "none";
            } else if (event.data.type == "returnedPersonMatches") {
                mdtApp.offender_results.results = event.data.matches;
            } else if (event.data.type == "returnedOffenderDetails") {
                mdtApp.offender_selected = event.data.details;
                mdtApp.offender_results.results = false;
                mdtApp.offender_results.query = "";
                mdtApp.offender_changes.notes = mdtApp.offender_selected.notes;
                mdtApp.offender_changes.mugshot_url = mdtApp.offender_selected.mugshot_url;
                mdtApp.offender_changes.licenses = mdtApp.offender_selected.licenses;
                mdtApp.offender_changes.licenses_removed = [];
                mdtApp.offender_changes.convictions = mdtApp.offender_selected.convictions;
                mdtApp.offender_changes.convictions_removed = [];
                mdtApp.offender_search = mdtApp.offender_selected.name + " " + mdtApp.offender_selected.firstname;
                mdtApp.changePage("Search Offenders");

                mdtApp.recent_searches.person.unshift(event.data.details);
                if (mdtApp.recent_searches.person.length > 3) {
                    Vue.delete(mdtApp.recent_searches.person, 3)
                }
            } else if (event.data.type == "offensesAndOfficerLoaded") {
                mdtApp.offenses = event.data.offenses;

                mdtApp.officer.name = event.data.name;
            } else if (event.data.type == "returnedReportMatches") {
                mdtApp.report_results.results = event.data.matches;
            } else if (event.data.type == "returnedVehicleMatches") {
                mdtApp.vehicle_results.results = event.data.matches;
                mdtApp.vehicle_selected = {
                    plate: null,
                    type: null,
                    owner: null,
                    owner_id: null,
                    model: null,
                    color: null
                };
            } else if (event.data.type == "returnedVehicleDetails") {
                mdtApp.vehicle_selected = event.data.details;
                mdtApp.vehicle_search = mdtApp.vehicle_selected.plate;

                mdtApp.recent_searches.vehicle.unshift(event.data.details);
                if (mdtApp.recent_searches.vehicle.length > 3) {
                    Vue.delete(mdtApp.recent_searches.vehicle, 3)
                }
            } else if (event.data.type == "returnedVehicleMatchesInFront") {
                mdtApp.vehicle_results.results = event.data.matches;
                mdtApp.vehicle_results.query = event.data.plate;
                mdtApp.vehicle_search = event.data.plate;
                mdtApp.vehicle_selected = {
                    plate: null,
                    type: null,
                    owner: null,
                    owner_id: null,
                    model: null,
                    color: null
                };
                mdtApp.changePage("Search Vehicles");
            } else if (event.data.type == "returnedWarrants") {
                mdtApp.warrants = event.data.warrants;
            } else if (event.data.type == "completedWarrantAction") {
                mdtApp.changePage("Warrants");
            } else if (event.data.type == "returnedReportDetails") {
                mdtApp.changePage("Search Reports");
                mdtApp.report_selected = event.data.details;
            } else if (event.data.type == "recentReportsAndWarrantsLoaded") {
                mdtApp.homepage.reports = event.data.reports;
                mdtApp.homepage.warrants = event.data.warrants;
                mdtApp.officer.name = event.data.officer;
            };
        });
    };
};