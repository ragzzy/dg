angular.module('angularDashboardApp').controller('donutChartCtrl', function($scope){

        $scope.options = {
            chart: {
                type: 'pieChart',
                height: 500,
                donut: true,
                x: function(d){return d.key;},
                y: function(d){return d.y;},
                showLabels: true,
                pie: {
                    startAngle: function(d) { return d.startAngle/2 -Math.PI/2 },
                    endAngle: function(d) { return d.endAngle/2 -Math.PI/2 }
                },
                transitionDuration: 500,
                legend: {
                    margin: {
                        top: 5,
                        right: 140,
                        bottom: 5,
                        left: 0
                    }
                }
            },
            title: {
                enable: true,
                text: 'Certification'
            }
        };

        $scope.data = [
            {
                key: "APO",
                y: 200
            },
            {
                key: "BPO",
                y: 150
            },
            {
                key: "DEO",
                y: 40
            },
        ];
    })