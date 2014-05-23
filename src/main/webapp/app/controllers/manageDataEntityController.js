//BEGIN - Manage Data Entity Controller
angularDashboardApp.controller('ManageDataEntityController', function ($scope, $http, $rootScope, $timeout, $dialogs) {
	$scope.filterOptions = {
			filterText: ""
        //useExternalFilter: true
	};
    $scope.totalServerItems = 0;
    $scope.pagingOptions = {
    		pageSizes: [10, 15],
    		pageSize: 10,
    		totalServerItems: 0,
    		currentPage: 1
    };
    $scope.setPagingData = function(data, page, pageSize) {
    	var pagedData = data.slice((page - 1) * pageSize, page * pageSize);
        $scope.myData = pagedData;
        $scope.totalServerItems = data.length;
        if (!$scope.$$phase) {
        	$scope.$apply();
        }
    };
    $scope.getPagedDataAsync = function (pageSize, page, searchText) {
    	setTimeout(function () {
        var data;
        if (searchText) {
        	var ft = searchText.toLowerCase();
            $http.get('rest/allDataEntities/').success(function (largeLoad) {
            //$http.get('dataEntitySample.json').success(function (largeLoad) {
            	data = largeLoad.filter(function(item) {
            		return JSON.stringify(item).toLowerCase().indexOf(ft) != -1;
            	});
                $scope.setPagingData(data,page,pageSize);
                });
             } else {
            	 $http.get('rest/allDataEntities/').success(function (largeLoad) {
                 //$http.get('dataEntitySample.json').success(function (largeLoad) {
            		 $scope.setPagingData(largeLoad, page, pageSize);
            	 });
             }
    	}, 100);
    };

    $scope.filterEntity = function() {
    	var filterText = '';
        if ($scope.filterOptions.filterText === '') {
        	$scope.filterOptions.filterText = filterText;
        }
        else if ($scope.filterOptions.filterText === filterText) {
        	$scope.filterOptions.filterText = '';
        }
    };

    $scope.getPagedDataAsync($scope.pagingOptions.pageSize, $scope.pagingOptions.currentPage);
    $scope.$watch('pagingOptions', function (newVal, oldVal) {
    	if (newVal !== oldVal && newVal.currentPage !== oldVal.currentPage) {
    		$scope.getPagedDataAsync(
    				$scope.pagingOptions.pageSize,
    				$scope.pagingOptions.currentPage,
    				$scope.filterOptions.filterText
    		);
    	}
    }, true);

    $scope.$watch('filterOptions', function (newVal, oldVal) {
    	if (newVal !== oldVal) {
    		$scope.getPagedDataAsync($scope.pagingOptions.pageSize, $scope.pagingOptions.currentPage, $scope.filterOptions.filterText);
    	}
    }, true);

    $scope.gridOptions = {
		data: 'myData',
		columnDefs: [
            {
            	field: 'entityNm',
                displayName: 'Name',
                sortable: true,
                width: '20%'
            },
            {
            	field: 'entityDefn',
                displayName: 'Description',
                sortable: false,
                width: '70%'
            },
            {
                displayName: 'Actions',
                sortable: false,
                width: '8%', //2 not included to avoid horizontal scrollbar
                cellTemplate: 'views/templates/for-ng-grid/edit-delete-cell-template.html'
            }
        ],
        enablePaging: true,
        enableRowSelection: false,
        showFooter: true,
        showColumnMenu: false,
        showFilter: false,
        headerRowHeight: 50,
        pagingOptions: $scope.pagingOptions,
        filterOptions: $scope.filterOptions
   	};

    $scope.launchAddEntityDialog = function() {
    	var dlg = $dialogs.create(
    		'views/templates/for-dialogs/add-entity-data.html', 
    		'AddDataEntityController', 
    		{}, {
    			key: false,
    			back: 'static'
    		});
        dlg.result.then(function(name) {
        	$scope.name = name;
        }, function() {
        	$scope.name = 'You decided not to enter in your name, that makes me sad.';
        });
    };

    $scope.editDataEntity = function (row) {
    	window.console && console.log(row.entity);
    	//$window.location.href= 'newPage/?id='+ row.entity.id;
 		//Make http request and load the screen for the entity.
    };
});
// END   - Manage Data Entity Controller