'use strict';

// =================================================================================================================================== //
// PREPARING ALL THE DIRECTIVES FOR DEP INJECTION INTO THE MAIN APP MODULE
// =================================================================================================================================== //
angular.module('rcForm', []).directive(rcSubmitDirective);
angular.module('autoFocusInput', []).directive(autoFocusInputDirective);

// =================================================================================================================================== //
// ANGULAR APP MODULE
// =================================================================================================================================== //
//, , 'ui.bootstrap', 
var angularDashboardApp = angular.module('angularDashboardApp',
    [
        'ui.bootstrap',
        //'ng-custom-template',
        'ngTable',
        'ngRoute',
        'rcForm',
        'autoFocusInput',
        'dialogs',
        'ui.select2',
        'nvd3'
    ]);

// =================================================================================================================================== //
// BEGIN - SERVICE FACTORIES 
// =================================================================================================================================== //

// =================================================================================================================================== //
// END   - SERVICE FACTORIES 
// =================================================================================================================================== //

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
        .when('/dataEntity', { templateUrl: 'app/dataEntity/pages/manageDataEntity.html', controller: 'ManageDataEntityController' })
        // ADD Entity
        .when('/addDataEntity', { templateUrl: 'app/dataEntity/pages/dialogs/addDataEntity.html', controller: 'AddDataEntityController' })
        // EDIT Entity
        .when('/editDataEntity', { templateUrl: 'app/dataEntity/pages/dialogs/editDataEntity.html', controller: 'EditDataEntityController' })
        // Add Entity
        .when('/deleteDataEntity', { templateUrl: 'app/dataEntity/pages/dialogs/deleteDataEntity.html', controller: 'DeleteDataEntityController' })

        // Collect Team Functions and Processes
        .when('/collectBusinessPrcs/:dptId', { templateUrl: 'pages/collectBusinessPrcs.html', controller: 'CollectBusinessPrcsController' })
        // Dashboard
        .when('/dashboard', { templateUrl: 'pages/dashboard.html', controller: 'DashboardController' })
        //glossary
        .when('/glossary', { templateUrl: 'pages/manage-temp.html', controller: 'sampleManageController' })
        //dictionary
        .when('/dictionary', { templateUrl: 'pages/manage-temp.html', controller: 'sampleManageController' })
        //applications
        .when('/applications', { templateUrl: 'pages/manageAppMaster.html', controller: 'ManageAppMasterController' })
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
angularDashboardApp.controller('mainController', function ($scope, dataEntityStateSvc) {

    // // // preloads \\ \\ \\
    // data entities.
    dataEntityStateSvc.query();

    //header banner links
    $scope.headerLinks = [
        { linkname: 'Home', linkIcon: 'home', linkUrl: '#home' , subLinks: [] }
       ,{ linkname: 'Dashboard', linkIcon: 'dashboard', linkUrl: '#dashboard' , subLinks: [] }
       ,{ linkname: 'Policies', linkIcon: 'anchor', linkUrl: '#policies', subLinks: [] }
       ,{ linkname: 'Glossary', linkIcon: 'globe', linkUrl: '#glossary', subLinks: [] }
       ,{ linkname: 'Dictionary', linkIcon: 'book', linkUrl: '#dictionary', subLinks: [] }
       ,{ linkname: 'Entity', linkIcon: 'key', linkUrl: '#dataEntity', subLinks: [] }
       ,{ linkname: 'Applications', linkIcon: 'briefcase', linkUrl: '#applications', subLinks: [] }
       ,{
            linkname: 'Manage', linkIcon: 'cogs', linkUrl: '#manage-users',
            subLinks: [
                 { subLinkName: 'User', subLinkUrl: '#manage-users' }
                ,{ subLinkName: 'User Roles', subLinkUrl: '#manage-user-roles' }
                ,{ subLinkName: 'Policies', subLinkUrl: '#manage-policies' }
                ,{ subLinkName: 'Departments', subLinkUrl: '#manage-departments' }
                ,{ subLinkName: 'Owners', subLinkUrl: '#manage-owners' }
                ,{ subLinkName: 'Entities', subLinkUrl: '#manage-entities' }
                ,{ subLinkName: 'Applications', subLinkUrl: '#manage-apps' }
            ]
        },
        {
            linkname: 'Partials', linkIcon: 'link', linkUrl: '#login',
            subLinks: [
                { subLinkName: 'Login', subLinkUrl: '#login' }
               ,{ subLinkName: 'Logged Out', subLinkUrl: '#loggedout' }
               ,{ subLinkName: 'Register', subLinkUrl: '#register' }
               ,{ subLinkName: 'Forgot Password', subLinkUrl: '#forgotpassword' }
               ,{ subLinkName: 'Error Page', subLinkUrl: '#error' }
            ]
        }
    ];
});

// =================================================================================================================================== //
// SUB CONTROLLERS - these are passed for rendered objects inside the ng-view
// =================================================================================================================================== //
// BEGIN - Collect Team function and Business Process Controller
angularDashboardApp.controller('CollectTeamFuncBusPrcsController', function ($rootScope, $scope, $routeParams, $route, $http, data) {
	$scope.teamFunctions = {}; // [{id: 'choice1'}, {id: 'choice2'}, {id: 'choice3'}]; // $http to get team functions within department.

	//If you want to use URL attributes before the website is loaded
    $rootScope.$on('$routeChangeSuccess', function () {
        console.log($routeParams.dptId);
        $http.get('rest/busPrcs/');
    });

	$scope.addNewTf = function() {
		var newTfNo = $scope.teamFunctions.length + 1;
		$scope.teamFunctions.push({'id':'choice' + newTfNo});
	};
	$scope.showAddTf = function(tf) {
		return tf.id === $scope.teamFunctions[ $scope.teamFunctions.length - 1 ].id;
	};

	$scope.showAddTfLabel = function (tf) {
		return tf.id === $scope.teamFunctions[0].id;
	};
});
// END   - Collect Team function and Business Process Controller

// LOGIN controller
angularDashboardApp.controller('loginController', function ($scope) {
    
});
// LOGGED OUT controller
angularDashboardApp.controller('loggedOutController', function ($scope) {
    $scope.currentlyLoggedInUser = 'Justin Williams';
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
    $scope.message = 'Everyone come and see how good I look!';
});


//sample directive for all manage pages
angularDashboardApp.controller('sampleManageController', function ($scope) {
    $scope.sideBarLinks = [
        { linkname: 'Home', linkIcon: 'home', linkUrl: '#home', subLinks: [], hasSubLinks: false },
        { linkname: 'Dashboard', linkIcon: 'dashboard', linkUrl: '#dashboard', subLinks: [], hasSubLinks: false },
        { linkname: 'Policies', linkIcon: 'anchor', linkUrl: '#policies', subLinks: [], hasSubLinks: false },
        { linkname: 'Glossary', linkIcon: 'globe', linkUrl: '#glossary', subLinks: [], hasSubLinks: false },
        { linkname: 'Dictionary', linkIcon: 'book', linkUrl: '#dictionary', subLinks: [], hasSubLinks: false },
        { linkname: 'Entity', linkIcon: 'key', linkUrl: '#dataEntity', subLinks: [], hasSubLinks: false },
        { linkname: 'Applications', linkIcon: 'briefcase', linkUrl: '#applications', subLinks: [], hasSubLinks: true },
        {
            linkname: 'Manage', linkIcon: 'cogs', linkUrl: '#manage-users',
            subLinks: [
                { subLinkName: 'User', subLinkUrl: '#manage-users' }
               ,{ subLinkName: 'User Roles', subLinkUrl: '#manage-user-roles' }
               ,{ subLinkName: 'Policies', subLinkUrl: '#manage-policies' }
               ,{ subLinkName: 'Departments', subLinkUrl: '#manage-departments' }
               ,{ subLinkName: 'Owners', subLinkUrl: '#manage-owners' }
               ,{ subLinkName: 'Entities', subLinkUrl: '#manage-entities' }
               ,{ subLinkName: 'Applications', subLinkUrl: '#manage-apps' }
            ]
        },
        {
            linkname: 'Partials', linkIcon: 'link', linkUrl: '#login', hasSubLinks: true,
            subLinks: [
                { subLinkName: 'Login', subLinkUrl: '#login' }
               ,{ subLinkName: 'Logged Out', subLinkUrl: '#loggedout' }
               ,{ subLinkName: 'Register', subLinkUrl: '#register' }
               ,{ subLinkName: 'Forgot Password', subLinkUrl: '#forgotpassword' }
               ,{ subLinkName: 'Error Page', subLinkUrl: '#error' }
            ]
        }
    ];
});

// =================================================================================================================================== //
// DIRECTIVES
// =================================================================================================================================== //