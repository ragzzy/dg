angular.module('angularDashboardApp').factory('departmentPositionsDataSvc', function ($http, $log) {
	var allDeptPosns = {};
    var URL = 'mockData/mockDepartmentPositions.json';
//    var URL = 'rest/dataEntity/all/';
	$log.log("hihihihihihihihihhihihihih loading Department Positions as startup singleton service");
    var factory = {
		query: function () {
			var data = $http({method: 'GET', url: URL}).then(
				function (result) {
					$log.log(result);
					allDeptPosns = result.data;
				},
				function (result) {
					alert("Error: No data returned");
				}
			);
        },
        getDeptPosnsList: function () {
           return allDeptPosns;
        }
    };

    return factory;
});