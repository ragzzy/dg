/*
NOTE:
Raghu, I have put all the code in a single file
It is best practise to separate directives and controllers and routes into separate files
*/
// =================================================================================================================================== //
// PREPARING ALL THE DIRECTIVES FOR DEP INJECTION INTO THE MAIN APP MODULE
// =================================================================================================================================== //
angular.module('rcForm', []).directive(rcSubmitDirective);
angular.module('autoFocusInput', []).directive(autoFocusInputDirective);

// =================================================================================================================================== //
// ANGULAR APP MODULE
// =================================================================================================================================== //
var angularDashboardApp = angular.module('angularDashboardApp', ['ngRoute', 'rcForm', 'autoFocusInput', 'ngGrid', 'ui.bootstrap','dialogs']);

// =================================================================================================================================== //
// ROUTES
// =================================================================================================================================== //
angularDashboardApp.config(function($routeProvider) {
    $routeProvider
        // DEFAULT route goes toLOGIN view
        .when('/', { templateUrl: 'pages/user-login.html', controller: 'loginController' })
        //login view for re-routing
        .when('/login', { templateUrl: 'pages/user-login.html', controller: 'loginController' })
        //logged out view
        .when('/loggedout', { templateUrl: 'pages/user-logged-out.html', controller: 'loggedOutController' })
        //register user
        .when('/register', { templateUrl: 'pages/user-register.html', controller: 'loginController' })
        //forgot password
        .when('/forgotpassword', { templateUrl: 'pages/user-forgot-password.html', controller: 'loginController' })
        //any error or 404
        .when('/error', { templateUrl: 'pages/error-404.html', controller: 'loginController' })
        //home dashboard
        .when('/home', { templateUrl: 'pages/manage-temp.html', controller: 'sampleManageController' })

        // Data Entity
        .when('/entity', { templateUrl: 'pages/manageDataEntity.html', controller: 'ViewDataEntityController' })
        // Add Entity
        .when('/addDataEntity', { templateUrl: 'pages/addDataEntity.html', controller: 'AddDataEntityController' })

        //glossary
        .when('/glossary', { templateUrl: 'pages/manage-temp.html', controller: 'sampleManageController' })
        //dictionary
        .when('/dictionary', { templateUrl: 'pages/manage-temp.html', controller: 'sampleManageController' })
        //applications
        .when('/applications', { templateUrl: 'pages/manage-temp.html', controller: 'sampleManageController' })
        //manage-users
        .when('/manage-users', { templateUrl: 'pages/manage-temp.html', controller: 'sampleManageController' })
        //manage-user-roles
        .when('/manage-user-roles', { templateUrl: 'pages/manage-temp.html', controller: 'sampleManageController' })
        //manage-departments
        .when('/manage-departments', { templateUrl: 'pages/manage-temp.html', controller: 'sampleManageController' })
        //manage-owners
        .when('/manage-owners', { templateUrl: 'pages/manage-temp.html', controller: 'sampleManageController' })
        //manage-entities
        .when('/manage-entities', { templateUrl: 'pages/manage-temp.html', controller: 'sampleManageController' })
        //manage-apps
        .when('/manage-apps', { templateUrl: 'pages/manage-temp.html', controller: 'sampleManageController' });
});

// =================================================================================================================================== //
// CONTROLLERS
// =================================================================================================================================== //
// =================================================================================================================================== //
// MAIN ADMIN WHOLISTIC controller
// =================================================================================================================================== //
angularDashboardApp.controller('mainController', function ($scope) {
    //header banner links
    $scope.headerLinks = [
        { linkname: 'Home', linkIcon: 'home', linkUrl: '#home' , subLinks: []},
        { linkname: 'Glossary', linkIcon: 'globe', linkUrl: '#glossary', subLinks: [] },
        { linkname: 'Dictionary', linkIcon: 'book', linkUrl: '#dictionary', subLinks: [] },
        { linkname: 'Entity', linkIcon: 'key', linkUrl: '#entity', subLinks: []},
        { linkname: 'Applications', linkIcon: 'briefcase', linkUrl: '#applications', subLinks: [] },
        {
            linkname: 'Manage', linkIcon: 'cogs', linkUrl: '#manage-users',
            subLinks: [
                { subLinkName: 'Manage User', subLinkUrl: '#manage-users' },
                { subLinkName: 'Manage User Roles', subLinkUrl: '#manage-user-roles' },
                { subLinkName: 'Manage Departments', subLinkUrl: '#manage-departments' },
                { subLinkName: 'Manage Owners', subLinkUrl: '#manage-owners' },
                { subLinkName: 'Manage Entities', subLinkUrl: '#manage-entities' },
                { subLinkName: 'Manage Applications', subLinkUrl: '#manage-apps' }
            ]
        },
        {
            linkname: 'Partials', linkIcon: 'link', linkUrl: '#login',
            subLinks: [
                { subLinkName: 'Login', subLinkUrl: '#login' },
                { subLinkName: 'Logged Out', subLinkUrl: '#loggedout' },
                { subLinkName: 'Register', subLinkUrl: '#register' },
                { subLinkName: 'Forgot Password', subLinkUrl: '#forgotpassword' },
                { subLinkName: 'Error Page', subLinkUrl: '#error' }
            ]
        }
    ];
});

// =================================================================================================================================== //
// SUB CONTROLLERS - these are passed for rendered objects inside the ng-view
// =================================================================================================================================== //
// BEGIN - Add Data Entity Controller
//create angular controller
angularDashboardApp.controller('AddDataEntityController', function($scope,$modalInstance,data) {
	  $scope.cancel = function(){
	    $modalInstance.dismiss('canceled');  
	  }; // end cancel
	  
	  $scope.save = function(){
	    $modalInstance.close($scope.user.name);
	  }; // end save
	  
	  $scope.hitEnter = function(evt){
	    if(angular.equals(evt.keyCode,13) && !(angular.equals($scope.name,null) || angular.equals($scope.name,'')))
					$scope.save();
	  }; // end hitEnter
})

;
// END   - Add Data Entity Controller

// BEGIN - View Data Entity Controller
angularDashboardApp.controller('ViewDataEntityController', function($scope, $http, $rootScope, $timeout, $dialogs) {
    $scope.filterOptions = {
        filterText: ""
//       ,useExternalFilter: true
    };
    $scope.totalServerItems = 0;
    $scope.pagingOptions = {
        pageSizes: [25, 50],
        pageSize: 25,
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
                    data = largeLoad.filter(function(item) {
                        return JSON.stringify(item).toLowerCase().indexOf(ft) != -1;
                    });
                    $scope.setPagingData(data,page,pageSize);
                });
            } else {
                $http.get('rest/allDataEntities/').success(function (largeLoad) {
                    $scope.setPagingData(largeLoad,page,pageSize);
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
        data: 'myData'
       ,columnDefs: [
            { field: 'entityNm', displayName: 'Name', sortable: true, width: '25%' },
            { field: 'entityDefn', displayName: 'Description', sortable: false, width: '70%' },
            { displayName: 'Actions', sortable: false, width: '5%',
            	cellTemplate: 
            		  '<button class="btn btn-primary btn-xs" data-placement="top" data-ng-click="editDataEntity(row)" rel="tooltip">'
            		     + '<span class="glyphicon glyphicon-pencil"></span>'
            		+ '</button>'
            		+ '&nbsp;'
            		+ '<button class="btn btn-danger btn-xs" data-placement="top" data-ng-click="deleteDataEntity(row)" rel="tooltip">'
            		     + '<span class="glyphicon glyphicon-trash"></span>'
            		+ '</button>'
            }
        ]
       ,enablePaging: true
       ,enableRowSelection: false
       ,showFooter: true
       ,showColumnMenu: true
       ,showFilter: true
       ,pagingOptions: $scope.pagingOptions
       ,filterOptions: $scope.filterOptions
    };

    $scope.launchDialog = function(which) {
        var dlg = null;
        switch(which){
        	// Error Dialog
        	case 'error':
        		dlg = $dialogs.error('This is my error message');
        		break;
        	/* Wait / Progress Dialog
        	case 'wait':
        		dlg = $dialogs.wait(msgs[i++],progress);
        		fakeProgress();
        		break;
        	*/
			// Notify Dialog
			case 'notify':
            	dlg = $dialogs.notify('Something Happened!','Something happened that I need to tell you.');
            	break;
			// Confirm Dialog
			case 'confirm':
            	dlg = $dialogs.confirm('Please Confirm','Is this awesome or what?');
            	dlg.result.then(function(btn) {
              		$scope.confirmed = 'You thought this quite awesome!';
            	},function(btn) {
              		$scope.confirmed = 'Shame on you for not thinking this is awesome!';
            	});
            	break;
          	// Create Your Own Dialog
          	case 'addDataEntity':
            	dlg = $dialogs.create('pages/addDataEntity.html','AddDataEntityController',{}, {key: false,back: 'static'});
            	dlg.result.then(function(name){
              		$scope.name = name;
            	},function(){
              		$scope.name = 'You decided not to enter in your name, that makes me sad.';
            	});
            	break;
        }; // end switch
    }; // end launch

    $scope.editDataEntity = function (row) {
		   window.console && console.log(row.entity);
		   //$window.location.href= 'newPage/?id='+ row.entity.id;
		   // Make http request and load the screen for the entity.
    };
});
// END   - Manage Data Entity Controller

//=======================================================================================================================//

// LOGIN controller
angularDashboardApp.controller('loginController', function ($scope) {
    
});
// LOGGED OUT controller
angularDashboardApp.controller('loggedOutController', function ($scope) {
    $scope.currentlyLoggedInUser = 'Justin HuHu Williams';
    $scope.session = {};
    $scope.login = function () {
        // process $scope.session
        alert('logged in!');
    };
});
// REGISTER controller
angularDashboardApp.controller('registerController', function ($scope) {
    $scope.message = 'Everyone come and see how good I look!';
});
// FORGOT PASSWORD controller
angularDashboardApp.controller('forgotPasswordController', function ($scope) {
    $scope.message = 'Everyone come and see how good I look!';
});
// 404 controller
angularDashboardApp.controller('404Controller', function ($scope) {
    $scope.message = 'Everyone! Come and see how good I look!';
});


//sample directive for all manage pages
angularDashboardApp.controller('sampleManageController', function ($scope) {
    $scope.sideBarLinks = [
        { linkname: 'Home', linkIcon: 'home', linkUrl: '#home', subLinks: [], hasSubLinks: false },
        { linkname: 'Glossary', linkIcon: 'globe', linkUrl: '#glossary', subLinks: [], hasSubLinks: false },
        { linkname: 'Dictionary', linkIcon: 'book', linkUrl: '#dictionary', subLinks: [], hasSubLinks: false },
        { linkname: 'Entity', linkIcon: 'key', linkUrl: '#entity', subLinks: [], hasSubLinks: false },
        { linkname: 'Applications', linkIcon: 'briefcase', linkUrl: '#applications', subLinks: [], hasSubLinks: true },
        {
            linkname: 'Manage', linkIcon: 'cogs', linkUrl: '#manage-users',
            subLinks: [
                { subLinkName: 'Manage User', subLinkUrl: '#manage-users' },
                { subLinkName: 'Manage User Roles', subLinkUrl: '#manage-user-roles' },
                { subLinkName: 'Manage Departments', subLinkUrl: '#manage-departments' },
                { subLinkName: 'Manage Owners', subLinkUrl: '#manage-owners' },
                { subLinkName: 'Manage Entities', subLinkUrl: '#manage-entities' },
                { subLinkName: 'Manage Applications', subLinkUrl: '#manage-apps' }
            ]
        },
        {
            linkname: 'Partials', linkIcon: 'link', linkUrl: '#login', hasSubLinks: true,
            subLinks: [
                { subLinkName: 'Login', subLinkUrl: '#login' },
                { subLinkName: 'Logged Out', subLinkUrl: '#loggedout' },
                { subLinkName: 'Register', subLinkUrl: '#register' },
                { subLinkName: 'Forgot Password', subLinkUrl: '#forgotpassword' },
                { subLinkName: 'Error Page', subLinkUrl: '#error' }
            ]
        }
    ];
});


// =================================================================================================================================== //
// DIRECTIVES
// =================================================================================================================================== //