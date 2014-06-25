angular.module('angularDashboardApp').controller('DashboardDataEntityPieCtrl2', function($scope){

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
                text: 'Department - BlueWorks Usage'
            }
        };

        $scope.data = [
            {
                key: "Bank Division",
                y: 20
            },
            {
                key: "Bank Equipment Finance",
                y: 10
            },
            {
                key: "Finance Division",
                y: 12
            },
            {
                key: "Treasury",
                y: 8
            },
            {
                key: "Accounting",
                y: 4
            },
            {
                key: "Program Management",
                y: 34
            },
            {
                key: "Quality Assurance",
                y: .1
            }
        ];
    })