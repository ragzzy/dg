//BEGIN - Department, Positions, Employees Controller
angular.module('angularDashboardApp').controller('DeptPositionsEmployeesController', function ($scope, $http, $rootScope, $timeout, $dialogs) {
    $scope.filterOptions = {
        filterText: ""
        //useExternalFilter: true
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

    $scope.totalServerItems = 0;
    $scope.pagingOptions = {
        pageSizes: [500, 1000],
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
                $http.get('mockData/mockDepartmentPositions.json').success(function (largeLoad) {
                    data = largeLoad.filter(function(item) {
                        return JSON.stringify(item).toLowerCase().indexOf(ft) != -1;
                    });
                    $scope.setPagingData(data,page,pageSize);
                });
            } else {
                //$http.get('rest/appMaster/all/').success(function (largeLoad) {
                $http.get('mockData/mockDepartmentPositions.json').success(function (largeLoad) {
                    $scope.setPagingData(largeLoad, page, pageSize);
                });
            }
        }, 100);
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

    pdfOpts = {} ;
    $scope.gridOptions = {
        data: 'myData',
        plugins: [new ngGridFlexibleHeightPlugin(), new ngGridCsvExportPlugin()],
        showGroupPanel: true,
        columnDefs: [
			{ field: 'lob',           displayName: 'Line of Business',   sortable: false, toolTip:'description', width: '10%' },
			{ field: 'division',      displayName: 'Division',           sortable: false, toolTip:'description', width: '10%' },
            { field: 'deptNm',        displayName: 'Dept. Name',         sortable: true,  toolTip:'description', width: '20%' },
            { field: 'payrollDeptNm', displayName: 'Payroll Dept. Name', sortable: false, toolTip:'description', width: '20%' },
			{ field: 'empNm',         displayName: 'Employee',           sortable: false, toolTip:'description', width: '15%' },
			{ field: 'positionDsc',   displayName: 'Position Title',     sortable: false, toolTip:'description', width: '20%' },
			{ field: 'jobDsc',        displayName: 'Job Title',          sortable: false, toolTip:'description', width: '20%' },
			{ field: 'effStatus',     displayName: 'Effective',          sortable: false, toolTip:'description', width: '6%'  },
			{ field: 'empId',         displayName: 'Empl. Id',           sortable: false, toolTip:'description', width: '5%'  },
			{ field: 'positionNbr',   displayName: 'Position #',         sortable: false, toolTip:'description', width: '5%'  },
			{ field: 'jobCode',       displayName: 'Job Code',           sortable: false, toolTip:'description', width: '5%'  },
			{ field: 'deptId',        displayName: 'Dept. Id',           sortable: false, toolTip:'description', width: '5%'  },
			{ field: 'payrollDeptId', displayName: 'Payroll Dept. Id',   sortable: false, toolTip:'description', width: '5%'  }
        ],
        enablePinning: false,
        enableSorting: false,
        enablePaging: true,
        //enableRowSelection: true,
        showFooter: true,
        footerRowHeight: 10,
        showColumnMenu: false,
        showFilter: false,
        headerRowHeight: 40,
        enableColumnResize: true,
        enableHighlighting: true,
        totalServerItems: 'totalServerItems',
        pagingOptions: $scope.pagingOptions,
        filterOptions: $scope.filterOptions,
        jqueryUITheme: true,
        multiSelect: false
    };

         // Add Data Entity Launch dialog
    $scope.uploadAdpHrData = function() {
        alert('Nothing going on here yet...');
    };
 });
// END   - Department, Positions, Employees Controller