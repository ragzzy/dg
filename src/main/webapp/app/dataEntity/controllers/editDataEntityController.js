// BEGIN - Edit Data Entity Controller
angular.module('angularDashboardApp').controller('EditDataEntityController', function ($scope, $modalInstance, $http, data) {
	$scope.form = {};
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
    	$http.post('rest/dataEntity/add', newDataEntity)
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

    var allDEs = [
  		{"entityId":"a","entityNm":"Account Coding"},
  		{"entityId":"b","entityNm":"Admin"},
  		{"entityId":"c","entityNm":"Branch -  Internal Org"},
  		{"entityId":"d","entityNm":"Communication"},
  		{"entityId":"e","entityNm":"Compass/CRM"},
  		{"entityId":"f","entityNm":"Event "},
  		{"entityId":"g","entityNm":"HR"},
  		{"entityId":"h","entityNm":"IT"},
  		{"entityId":"i","entityNm":"Market Data"},
  		{"entityId":"j","entityNm":"Name"},
  		{"entityId":"k","entityNm":"Organization"},
  		{"entityId":"l","entityNm":"Person - Account Representative"},
  		{"entityId":"m","entityNm":"Person - Business contacts at external organizations"},
  		{"entityId":"n","entityNm":"Person - Customer"},
  		{"entityId":"o","entityNm":"Person - Employee"},
  		{"entityId":"p","entityNm":"Revenue"},
  		{"entityId":"q","entityNm":"Securities"},
  		{"entityId":"r","entityNm":"Trading Platforms/ Feature Usage"},
  		{"entityId":"s","entityNm":"Transactions - Account/Customer"},
  		{"entityId":"t","entityNm":"Transactions - Firm"}
  	];

    /*
	setTimeout(function () {
		$http.get('rest/dataEntity/all/').success(function (data) {
  	    	$scope.allDEs = JSON.stringify(data);
		});
	}, 100);
    */
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
// END   - Edit Data Entity Controller
