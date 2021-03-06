//BEGIN - Business Process Controller
angular.module('angularDashboardApp').controller('ManageBusProcessController', function ($scope, $http, $rootScope, $timeout, $dialogs) {
    $scope.filterOptions = {
        filterText: "",
        useExternalFilter: true
    };

    $scope.totalServerItems = 0;
    $scope.pagingOptions = {
        pageSizes: [20, 40, 60],
        pageSize: 20,
        currentPage: 1
    };
    $scope.setPagingData = function(data, page, pageSize) {
        var pagedData = data.slice((page - 1) * pageSize, page * pageSize);
        $scope.myData = pagedData;
        $scope.totalServerItems = data.length;
        console.log(data.length);
        if (!$scope.$$phase) {
            $scope.$apply();
        }
    };
    $scope.getPagedDataAsync = function (pageSize, page, searchText) {
        setTimeout(function () {
            var data;
            if (searchText) {
                var ft = searchText.toLowerCase();
                //$http.get('rest/appMaster/all/').success(function (largeLoad) {
                $http.get('mockData/mockBusProcess.json').success(function (largeLoad) {
                    data = largeLoad.filter(function(item) {
                        return JSON.stringify(item).toLowerCase().indexOf(ft) != -1;
                    });
                    $scope.setPagingData(data,page,pageSize);
                });
            } else {
                //$http.get('rest/appMaster/all/').success(function (largeLoad) {
                $http.get('mockData/mockBusProcess.json').success(function (largeLoad) {
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
            $scope.getPagedDataAsync($scope.pagingOptions.pageSize, $scope.pagingOptions.currentPage, $scope.filterOptions.filterText);
        }
    }, true);

    $scope.$watch('filterOptions', function (newVal, oldVal) {
        if (newVal !== oldVal) {
            $scope.getPagedDataAsync($scope.pagingOptions.pageSize, $scope.pagingOptions.currentPage, $scope.filterOptions.filterText);
        }
    }, true);

    $scope.gridOptions = {
        data: 'myData',
        plugins: [new ngGridFlexibleHeightPlugin(), new ngGridCsvExportPlugin()],
        showGroupPanel: true,
        footerRowHeight: 5,
        columnDefs: [
            {
                displayName: 'Actions',
                groupable: false,
                pinnable: false,
                sortable: false,
                width: '7%',
                cellTemplate: 'app/busProcess/pages/templates/busProcessActions.html'
            },
			{ field: 'bpNm',           displayName: 'Business Process',   sortable: true,  toolTip:'description', width: '15%' },
			{ field: 'busOwnerNm',     displayName: 'Bus. Process Owner', sortable: false, toolTip:'description', width: '10%' },
            { field: 'busOwnerTitle',  displayName: 'Owner Title',        sortable: false, toolTip:'description', width: '10%' },
            { field: 'busOwnerDeptNm', displayName: 'Department',         sortable: false, toolTip:'description', width: '10%' },
			{ field: 'subProcessNm',   displayName: 'Sub Process Name',   sortable: false, toolTip:'description', width: '20%'  },
            { field: 'dataEntity',     displayName: 'Data Entites',       sortable: false, toolTip:'description', width: '10%'  },
            { field: 'crud',           displayName: 'C R U D',            sortable: false, toolTip:'description', width: '3%'  },
			{ field: 'application',    displayName: 'Application',        sortable: false, toolTip:'description', width: '20%'  },
            { field: 'participant',    displayName: 'Participant',        sortable: false, toolTip:'description', width: '20%'  }
        ],
        enablePinning: true,
        enableSorting: false,
        enablePaging: true,
        //enableRowSelection: true,
        showFooter: true,
        totalServerItems: 'totalServerItems',
        showColumnMenu: false,
        showFilter: false,
        headerRowHeight: 50,
        enableColumnResize: true,
        enableHighlighting: true,
        pagingOptions: $scope.pagingOptions,
        filterOptions: $scope.filterOptions,
        jqueryUITheme: true,
        multiSelect: false
    };

     // Add Data Entity Launch dialog
     $scope.addApplication = function() {
    	 var dlg = $dialogs.create (
			 'views/templates/for-dialogs/add-entity-data.html', 
			 'AddApplicationController',
			 {},
			 { key: false, back: 'static' }
    	 );

//         dlg.result.then(function(name) {
//             $scope.name = name;
//         }, function() {
//             $scope.name = 'You decided not to enter in your name, that makes me sad.';
//         });
     };

     // Edit Data Entity Launch dialog
     $scope.editRecord = function (row) {
    	 window.console && console.log(row.entity);
 		 //$window.location.href= 'newPage/?id='+ row.entity.id;
 		 // Make http request and load the screen for the entity.
    	 var dlg = $dialogs.create(
    			 'views/templates/for-dialogs/editDataEntity.html',
    			 'EditApplicationController',
    			 {},
    			 { key: false, back: 'static' }
    	 );
     };
 });
// END   - Business Process Controller