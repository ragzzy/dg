//BEGIN - Application Master Controller
angular.module('angularDashboardApp').controller('ManageAppMasterController', function ($scope, $http, $rootScope, $timeout, $dialogs) {
     $scope.filterOptions = {
         filterText: ""
        //useExternalFilter: true
     };
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
                 $http.get('rest/appMaster/all/').success(function (largeLoad) {
                 //$http.get('mockData/mockAppMaster.json').success(function (largeLoad) {
                     data = largeLoad.filter(function(item) {
                         return JSON.stringify(item).toLowerCase().indexOf(ft) != -1;
                     });
                     $scope.setPagingData(data,page,pageSize);
                 });
             } else {
                 $http.get('rest/appMaster/all/').success(function (largeLoad) {
                 //$http.get('mockData/mockAppMaster.json').success(function (largeLoad) {
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
    		 columnDefs: [
                {
	                displayName: 'Actions',
                    sortable: false,
                    width: '1%', //2 not included to avoid horizontal scrollbar
                    cellTemplate: 'views/templates/for-ng-grid/edit-delete-cell-template.html'
                },
				{ field: 'applNm', displayName: 'Name', sortable: true, wordWrap:true, toolTip:'description', width: '10%' },
				{ field: 'applTierId', displayName: 'Tier', sortable: false, wordWrap:true, toolTip:'description', width: '2%' },
				{ field: 'applDsc', displayName: 'Description', sortable: false, wordWrap:true, toolTip:'description', width: '20%' },
				{ field: 'applRbacControlledFlg', displayName: 'RBAC', sortable: false, wordWrap:true, toolTip:'description', width: '2%' },
				{ field: 'applHasBpsInBlueworksFlg', displayName: 'Blueworks', sortable: false, wordWrap:true, toolTip:'description', width: '2%' },
				{ field: 'developedBy', displayName: 'Developed by', sortable: false, wordWrap:true, toolTip:'description', width: '5%' },
				{ field: 'hostedAt', displayName: 'Hosted At', sortable: false, wordWrap:true, toolTip:'description', width: '5%' },
				{ field: 'authenticationMode', displayName: 'Authenticated by', sortable: false, wordWrap:true, toolTip:'description', width: '5%' },
				{ field: 'authorizedBy', displayName: 'Authorised by', sortable: false, wordWrap:true, toolTip:'description', width: '5%' },
				{ field: 'vendorNm', displayName: 'Vendor', sortable: false, wordWrap:true, toolTip:'description', width: '4%' },
				{ field: 'propsdBAOdeptNm', displayName: 'BAO', sortable: false, wordWrap:true, toolTip:'description', width: '10%' },
				{ field: 'propsdBAOtitle', displayName: 'BAO Title', sortable: false, wordWrap:true, toolTip:'description', width: '10%' },
				{ field: 'propsdITAOdeptNm', displayName: 'ITAO Dept', sortable: false, wordWrap:true, toolTip:'description', width: '10%' },
				{ field: 'drBcDsc', displayName: 'DR/BC', sortable: false, wordWrap:true, toolTip:'description', width: '3%' },
				{ field: 'containsCustInfoFlg', displayName: 'Customer Data', sortable: false, wordWrap:true, toolTip:'description', width: '2%' }
         ],
         enablePinning: true,
         enablePaging: true,
         enableGroupPanel: true,
         //enableRowSelection: true,
         showFooter: true,
         showColumnMenu: false,
         showFilter: false,
         headerRowHeight: 50,
         enableHighlighting: true,
         pagingOptions: $scope.pagingOptions,
         filterOptions: $scope.filterOptions,
         rowTemplate:
        	 '<div style="height: 100%" ng-class="{green: row.getProperty(\'age\') < 30}"><div ng-style="{ \'cursor\': row.cursor }" ng-repeat="col in renderedColumns" ng-class="col.colIndex()" class="ngCell ">' +
        	 	'<div class="ngVerticalBar" ng-style="{height: rowHeight}" ng-class="{ ngVerticalBarVisible: !$last }"> </div>' +
        	 	'<div ng-cell></div>' +
        	 	'</div></div>'
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
// END   - Application Master Controller