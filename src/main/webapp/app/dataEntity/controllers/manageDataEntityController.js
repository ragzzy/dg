//BEGIN - Manage Data Entity Controller
angular.module('angularDashboardApp').controller('ManageDataEntityController', function ($scope, $http, $rootScope, $timeout, $dialogs) {
     $scope.filterOptions = {
         filterText: ""
        //useExternalFilter: true
     };
     $scope.pagingOptions = {
         pageSizes: [15, 30],
         pageSize: 15,
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
                 $http.get('rest/dataEntity/all/').success(function (largeLoad) {
                 //$http.get('mockData/mockDataEntity.json').success(function (largeLoad) {
                     data = largeLoad.filter(function(item) {
                         return JSON.stringify(item).toLowerCase().indexOf(ft) != -1;
                     });
                     $scope.setPagingData(data,page,pageSize);
                 });
             } else {
                 $http.get('rest/dataEntity/all/').success(function (largeLoad) {
                 //$http.get('mockData/mockDataEntity.json').success(function (largeLoad) {
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
             { field: 'entityNm', displayName: 'Name', sortable: true, wordWrap:true, toolTip:'description', width: '20%' },
             { field: 'entityDefn', displayName: 'Description', sortable: false, wordWrap:true, toolTip:'description', width: '70%' },
             {
                 displayName: 'Actions',
                 sortable: false,
                 width: '8%', //2 not included to avoid horizontal scrollbar
                 cellTemplate: 'views/templates/for-ng-grid/edit-delete-cell-template.html'
             }
         ],
         enablePaging: true,
         //enableRowSelection: true,
         showFooter: true,
         showColumnMenu: false,
         showFilter: false,
         headerRowHeight: 50,
         enableHighlighting: true,
         pagingOptions: $scope.pagingOptions,
         filterOptions: $scope.filterOptions
     };

     // Add Data Entity Launch dialog
     $scope.addEntityDialog = function() {
    	 var dlg = $dialogs.create (
			 'views/templates/for-dialogs/add-entity-data.html', 
			 'AddDataEntityController', 
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
    			 'EditDataEntityController', 
    			 {},
    			 { key: false, back: 'static' }
    	 );
     };
 });
// END   - Manage Data Entity Controller