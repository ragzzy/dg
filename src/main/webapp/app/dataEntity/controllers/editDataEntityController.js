// BEGIN - Edit Data Entity Controller
angular.module('angularDashboardApp').controller('EditDataEntityController', function ($scope, $modalInstance, $http, data, $log, dataEntityStateSvc) {
    $scope.form = {};
    //Modal related
    $scope.cancel = function () {
        $modalInstance.dismiss('canceled');
    }; // end cancel

    $scope.allDEs = dataEntityStateSvc.getAllDEList();

    $scope.entityId = data;
    $scope.entityNm = $scope.allDEs[$scope.entityId].entityNm;
    $scope.entityDefn = $scope.allDEs[$scope.entityId].entityDefn;
    $scope.entityExtUrl = $scope.allDEs[$scope.entityId].entityExtUrl;
    //    $scope.parentDECheckboxes = { 'checked': false, entityId: {} };

    $scope.selectedEntityFilter = function (dataEntity) {
        return dataEntity.entityId != $scope.entityId;
    };

    // Save operation from edit data entity dialog.
    $scope.save = function () {
        var modDataEntity = {
            "entityId": $scope.entityId,
            "entityNm": $scope.form.dataEntityFormDialog.entityNm.$viewValue,
            "entityDefn": $scope.form.dataEntityFormDialog.entityDefn.$viewValue,
            "entityExtUrl": $scope.form.dataEntityFormDialog.entityExtRefUrl.$viewValue
        };

        console.log('modDataEntity data = ', modDataEntity);
        $http.post('rest/dataEntity/edit', modDataEntity)
            .success(function (data, status, headers, config) {
                console.log('data = ', data);
                alert('Data Entity created: ' + data);
            })
            .error(function (data, status, headers, config) {
                console.log('error: data = ', data);
                alert('Error creating Data Entity: ' + data);
            });

        $modalInstance.close('');
    }; // end save

    // selected entities
    $scope.selection = [];
    
    // helper method
    $scope.selectedDEs = function selectedDEs() {
      return entityFilter($scope.allDEs, { selected: true });
    };
    
    // watch fruits for changes
    $scope.$watch('$scope.allDEs|filter:{selected:true}', function (nv) {
        $scope.selection = nv.map(function (de) {
            return de.entityId;
        });
    }, true);

    $scope.hitEnter = function (evt) {
        if (angular.equals(evt.keyCode, 13) && !(angular.equals($scope.entityNm, null) || angular.equals($scope.entityNm, ''))) {
            $scope.save();
        }
    }; // end hitEnter
});
// END   - Edit Data Entity Controller

/**
 * custom filter
 */
angular.module('angularDashboardApp').filter('entitySelection', ['entityFilter', function (entityFilter) {
    return function entitySelection(input, prop) {
        return entityFilter(input, { selected: true }).map(function (fruit) {
            return fruit[prop];
        });
    };
}]);