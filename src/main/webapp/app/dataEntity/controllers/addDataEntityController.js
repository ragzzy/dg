// BEGIN - Add Data Entity Controller
angular.module('angularDashboardApp').controller('AddDataEntityController', function ($scope, $modalInstance, $http, data, $log, dataEntityStateSvc) {
	$scope.form = {};
    // $scope.today = function () {
    //     $scope.dt = new Date();
    // };
    // $scope.today();

    // $scope.clear = function () {
    //     $scope.dt = null;
    // };
    // // Disable weekend selection
    // $scope.disabled = function (date, mode) {
    //     return (mode === 'day' && (date.getDay() === 0 || date.getDay() === 6));
    // };
    // $scope.open = function ($event) {
    //     $event.preventDefault();
    //     $event.stopPropagation();
    //     $scope.opened = true;
    // };

    // $scope.initDate = new Date('2016-15-20');
    // $scope.format = 'dd-MMMM-yyyy';

    //Modal related
    $scope.cancel = function() {
    	$modalInstance.dismiss('canceled');  
    }; // end cancel

    $scope.save = function() {
    	var newDataEntity = {
    		"entityNm"     : $scope.form.dataEntityFormDialog.entityNm.$viewValue
    	   ,"entityDefn"   : $scope.form.dataEntityFormDialog.entityDefn.$viewValue
    	   ,"entityExtUrl" : $scope.form.dataEntityFormDialog.entityExtRefUrl.$viewValue
    	};

    	console.log('data = ' , newDataEntity);
    	$http.post('rest/post/dataEntity/add', newDataEntity)
    	.success( function (data, status, headers, config) {
    		console.log('data = ' , data);
    		alert('Data Entity created: ' + data);
    	})
   		.error(function(data, status, headers, config) {
   			console.log('error: data = ' , data);
    		alert('Error creating Data Entity: ' + data);
   		});

    	$modalInstance.close('');
    }; // end save

    $scope.hitEnter = function (evt) {
    	if (	  angular.equals(evt.keyCode,13)
    		   && !(angular.equals( $scope.entityNm, null ) || angular.equals( $scope.entityNm, '' ) )) {
    			$scope.save();
    	}
    }; // end hitEnter

    var allDEs = dataEntityStateSvc.getAllDEList();

    $scope.parentDataEntitySelect = {
		query: function (query) {
    	    var data = {results: []};
    	    	angular.forEach(allDEs, function(deRec, key) {
    	    		if (query.term.toUpperCase() === deRec.entityNm.substring(0, query.term.length).toUpperCase()) {
    	    			data.results.push(deRec);
    	    		}
    	    	});
    	    	query.callback(data);
    		}
    };

    $scope.childDataEntitySelect = {
		minimumInputLength: 3,
		ajax: {
			// instead of writing the function to execute the request we use Select2's convenient helper
			url: 'rest/dataEntity/all/',
			data: function (term, page) {
				return {};
			},
			results: function (data, page) {
				// parse the results into the format expected by Select2.
				// since we are using custom formatting functions we do not need to alter remote JSON data
				return { results: data };
			}
		}
    };
});
//END   - Add Data Entity Controller