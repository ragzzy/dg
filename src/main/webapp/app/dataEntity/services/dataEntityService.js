angular.module('angularDashboardApp').factory('dataEntityStateSvc', function ($http, $log) {
	var allDEs = {};
    var URL = 'mockData/mockDataEntity.json';
//    var URL = 'rest/dataEntity/all/';
	$log.log("hihihihihihihihihhihihihih in the service");
    var factory = {
		query: function () {
			var data = $http({method: 'GET', url: URL}).then(
				function (result) {
					$log.log(result);
					allDEs = result.data;
				},
				function (result) {
					alert("Error: No data returned");
				}
			);
        },
        getAllDEList: function () {
           return allDEs;
        }
    };

    return factory;
});