//BEGIN - Manage Data Entity Controller
angular.module('angularDashboardApp').controller('ManageDataEntityController', function($scope, $http, $filter, $dialogs, $log, ngTableParams, dataEntityStateSvc) {

    var data = dataEntityStateSvc.getAllDEList();
    /*
    $scope.tableParams = new ngTableParams({
        page: 1,            // show first page
        total: data.length, // length of data
        count: 10          // count per page
    });
    
    $scope.$watch('tableParams', function(params) {
        $scope.allEntities = data;//orderedData.slice((params.page - 1) * params.count, params.page * params.count);
    }, true);
    */

    $scope.tableParams = new ngTableParams({
        page: 1,            // show first page
        count: 10,          // count per page
        filter: {
            entityNm: ''
        },
        sorting: {
            entityNm: 'asc'
        }
    }, {
        total: data.length, // length of data
        getData: function($defer, params) {
            // use build-in angular filter
            var filteredData = params.filter() ?
                    $filter('filter')(data, params.filter()) :
                    data;
            var orderedData = params.sorting() ?
                    $filter('orderBy')(filteredData, params.orderBy()) :
                    data;

            params.total(orderedData.length); // set total for recalc pagination
            $defer.resolve(orderedData.slice((params.page() - 1) * params.count(), params.page() * params.count()));
        }
    });

    // Add Data Entity Launch dialog
    $scope.addEntityDialog = function() {
        var dlg =
            $dialogs.create (
                'app/dataEntity/pages/dialogs/add-entity-data.html', 
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
     $scope.editDataEntity = function (id) {
         $log.log('In Edit Data Entity --- id: ' + id);

         var dlg = $dialogs.create(
                 'app/dataEntity/pages/dialogs/editDataEntity.html', 
                 'EditDataEntityController', 
                 id,
                 { key: false, back: 'static' }
         );
     };
});
// END   - Manage Data Entity Controller