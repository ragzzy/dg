'use strict';

/*
NOTE:
Raghu, I have put all the code in a single file
It is best practice to separate directives and controllers and routes into separate files
*/
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
        'ngGrid',
        'ngRoute',
        'rcForm',
        'autoFocusInput',
        'dialogs',
        'ui.select2'
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
        .when('/entity', { templateUrl: 'pages/manageDataEntity.html', controller: 'ManageDataEntityController' })
        // Add Entity
        .when('/addDataEntity', { templateUrl: 'pages/addDataEntity.html', controller: 'AddDataEntityController' })
        // Collect Team Functions and Processes
        .when('/collTeamFuncBusPrcs/:dptId', { templateUrl: 'pages/collectTeamFuncBusPrcs.html', controller: 'CollectTeamFuncBusPrcsController' })
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
angularDashboardApp.controller('mainController', function ($scope) {
    //header banner links
    $scope.headerLinks = [
        { linkname: 'Home', linkIcon: 'home', linkUrl: '#home' , subLinks: [] },
        { linkname: 'Policies', linkIcon: 'globe', linkUrl: '#policies', subLinks: [], hasSubLinks: false },
        { linkname: 'Glossary', linkIcon: 'globe', linkUrl: '#glossary', subLinks: [] },
        { linkname: 'Dictionary', linkIcon: 'book', linkUrl: '#dictionary', subLinks: [] },
        { linkname: 'Entity', linkIcon: 'key', linkUrl: '#entity', subLinks: [] },
        { linkname: 'Applications', linkIcon: 'briefcase', linkUrl: '#applications', subLinks: [] },
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
        { linkname: 'Policies', linkIcon: 'globe', linkUrl: '#policies', subLinks: [], hasSubLinks: false },
        { linkname: 'Glossary', linkIcon: 'globe', linkUrl: '#glossary', subLinks: [], hasSubLinks: false },
        { linkname: 'Dictionary', linkIcon: 'book', linkUrl: '#dictionary', subLinks: [], hasSubLinks: false },
        { linkname: 'Entity', linkIcon: 'key', linkUrl: '#entity', subLinks: [], hasSubLinks: false },
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