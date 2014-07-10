angular.module('angularDashboardApp').factory('appMasterSvc', function ($http, $log) {
	var allApps = {};
    var URL = 'mockData/mockAppMaster.json';
//    var URL = 'rest/dataEntity/all/';
	$log.log("hihihihihihihihihhihihihih loading the application master as startup singleton service");
    var factory = {
		query: function () {
			var data = $http({method: 'GET', url: URL}).then(
				function (result) {
					$log.log(result);
					allApps = result.data;
				},
				function (result) {
					alert("Error: No data returned");
				}
			);
        },
        getAppMstrList: function () {
           return allApps;
        }
    };

    return factory;
});