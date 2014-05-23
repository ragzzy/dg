// BEGIN - Add Data Entity Controller
// Create angular controller
angularDashboardApp.controller('AddDataEntityController', function ($scope, $modalInstance, data) {
	$scope.today = function () {
        $scope.dt = new Date();
    };
    $scope.today();

    $scope.clear = function () {
        $scope.dt = null;
    };
    // Disable weekend selection
    $scope.disabled = function (date, mode) {
        return (mode === 'day' && (date.getDay() === 0 || date.getDay() === 6));
    };
    $scope.open = function ($event) {
        $event.preventDefault();
        $event.stopPropagation();
        $scope.opened = true;
    };

    $scope.initDate = new Date('2016-15-20');
    $scope.format = 'MM-dd-yyyy';

    //Modal related
    $scope.cancel = function(){
    	$modalInstance.dismiss('canceled');  
    }; // end cancel

    $scope.save = function(){
    	$modalInstance.close($scope.user.name);
    }; // end save
 	  
    $scope.hitEnter = function(evt) {
    	if(angular.equals(evt.keyCode,13) && !(angular.equals($scope.name,null) || angular.equals($scope.name,'')))
    		$scope.save();
    }; // end hitEnter
});
//END   - Add Data Entity Controller