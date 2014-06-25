angular.module('angularDashboardApp').controller('DashboardDataEntityPieCtrl1', function($scope){

        $scope.options = {
            chart: {
                type: 'pieChart',
                height: 500,
                x: function(d){return d.key;},
                y: function(d){return d.y;},
                showLabels: true,
                transitionDuration: 500,
                labelThreshold: 0.01,
                legend: {
                    margin: {
                        top: 5,
                        right: 35,
                        bottom: 5,
                        left: 0
                    }
                }
            },
	        title: {
	            enable: true,
	            text: '% Usage in Departments',
	            class: 'h4'
	        }
        };

        $scope.data = [
            {
                key: "Account Coding",
                y: 5
            },
            {
                key: "Employee",
                y: 2
            },
            {
                key: "Branch",
                y: 9
            },
            {
                key: "Bank Transactions",
                y: 10
            },
            {
                key: "Market Data",
                y: 4
            },
            {
                key: "Human Resources",
                y: 3
            },
            {
                key: "Legal",
                y: .5
            }
        ];
    })